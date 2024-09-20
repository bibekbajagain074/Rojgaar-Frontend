import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:roj_gaar_app/models/category_model.dart';
import 'package:roj_gaar_app/models/company_model.dart';
import 'package:roj_gaar_app/models/user_model.dart';
import 'package:roj_gaar_app/utils/api_endpoints.dart';
import 'package:roj_gaar_app/views/dashboard/setup_incomplete_screen.dart';
import 'package:roj_gaar_app/views/onboarding/login_screen.dart';
import '../../models/login_model.dart';
import '../../utils/constants.dart';
import '../../utils/secure_storage_helper.dart';
import '../../views/utils/screen_utils.dart';
import 'dio_client.dart';
import 'package:http/http.dart' as http;

class AppController extends GetxController {
  final DioClient _dioClient = DioClient();
  final SecureStorageHelper _localStorage = SecureStorageHelper();

  Rx<TextEditingController> usernameController = TextEditingController().obs,
      passwordController = TextEditingController().obs,
      newPasswordController = TextEditingController().obs,
      newPasswordVerifyController = TextEditingController().obs,
      usertypeController = TextEditingController().obs,
      editValue = TextEditingController().obs;
  RxBool isUser = false.obs,
      initializing = false.obs,
      passwordVisible = false.obs, // login
      newPasswordVisible = false.obs, // change password
      newPasswordVerifyVisible = false.obs, // change password
      isProcessing = false.obs,
      rememberUser = false.obs, // login
      expandInfo = false.obs, // settings
      expandSkills = false.obs, // settings
      expandExperiences = false.obs, // settings
      expandChangePassword = false.obs, // settings
      expandAcademic = false.obs, // settings
      expandCategories = false.obs; // settings

  late Rx<UserModel> appUser, // app user
      currentEmployee; // temp user
  late Rx<CompanyModel> currentCompany; // temp user
  late Rx<CategoryModel> currentCategory; // temp user

  Future login({String? username, String? password}) async {
    isProcessing(true);
    try {
      var loginData = {
        'username': username ?? usernameController.value.text,
        'password': password ?? passwordController.value.text
      };

      var request = await _dioClient.post(
          data: loginData,
          url: (isUser.value)
              ? APIEndpoints.employeeLogin
              : APIEndpoints.companyLogin);

      // log('>> login response: ${request.data.toString()}');

      if (_dioClient.checkResponse(request: request)) {
        appUser = UserModel.fromJson(request.data['user'])
            .obs; // user model for logged in user

        isUser(appUser.value.type == 'user'); // setting user type for app
        if (!isUser.value) {
          if (request.data['company'] != null) {
            // debugPrint(
            //     '>> company details: ${request.data['company'].toString()}');
            appUser.value.company =
                CompanyModel.fromJson(request.data['company']);
          } else {
            appUser.value.company = CompanyModel(
                id: appUser.value.appId,
                name: appUser.value.username,
                email: appUser.value.email,
                avatarUrl: appUser.value.avatarUrl,
                isVerified: appUser.value.isVerified,
                isActive: true,
                hasAvatarSet: true,
                jobs: [],
                categories: [],
                applicants: [],
                openDate: DateTime.now(),
                closeDate: DateTime.now());
          }
        }

        await _localStorage.write(
            key: uAccessToken,
            value: request.data['token']); // saving access token

        await saveCredentials(); // save user session

        usernameController.value.clear();
        passwordController.value.clear();
        passwordVisible(false);

        Get.offAllNamed(home);
      } else {
        throw request.data['msg'] ?? 'Unknown error occurred!';
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
      debugPrint('>> error while performing login: ${e.toString()}');
    } finally {
      isProcessing(false);
    }
  }

  Future<String?> retrieveAccessToken() async {
    return await _localStorage.readKey(
      key: uAccessToken,
    ); // saving access token
  }

  Future<bool> updateProfile() async {
    isProcessing(true);
    try {
      var updateBody = (isUser.value)
          ? {
              "username": appUser.value.username,
              "firstName": appUser.value.firstName,
              "lastName": appUser.value.lastName,
              "email": appUser.value.email,
              "phone": appUser.value.phoneNumber,
              "avatarImage": appUser.value.avatarUrl,
              "professional": {
                "title": appUser.value.skills!.title,
                "sector": appUser.value.skills!.sector,
                "skills": appUser.value.skills!.skills,
                "summary": appUser.value.skills!.summary
              }
            }
          : {
              "name": appUser.value.company!.name,
              "sector": appUser.value.company!.sector,
              "country": appUser.value.company!.country,
              "email": appUser.value.company!.email,
              "phone": appUser.value.company!.phone,
              "about": appUser.value.company!.about,
              "region": appUser.value.company!.region
            };
      var request = await _dioClient.put(
          url: (isUser.value)
              ? APIEndpoints.updateEmployeeProfile
              : APIEndpoints.updateCompanyProfile,
          data: updateBody,
          requiresToken: true);

      if (_dioClient.checkResponse(request: request)) {
        return true;
      } else {
        throw 'error in response updating profile.';
      }
    } catch (e) {
      ScreenUtils.showSnackBar(msg: 'Could not update profile at the moment!');
      debugPrint('>> error updating profile: ${e.toString()}');
      return false;
    } finally {
      isProcessing(false);
    }
  }

  Future<bool> updateCompanyProfile({
    required String username,
    required String sector,
    required String country,
    required String email,
    required String phone,
    required String about,
    required String region,
  }) async {
    isProcessing(true);
    try {
      var updateBody = {
        "name": username,
        "sector": sector,
        "country": country,
        "email": email,
        "phone": phone,
        "about": about,
        "region": region
      };
      var request = await _dioClient.post(
          url: APIEndpoints.updateCompanyProfile, data: updateBody);

      if (request.statusCode != 200) {
        throw 'status code error';
      } else if (request.data == null) {
        throw 'error in response updating profile.';
      } else {
        return true; // success
      }
    } catch (e) {
      debugPrint('>> error updating profile: ${e.toString()}');
      return false;
    } finally {
      isProcessing(false);
    }
  }

  Future changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    isProcessing(true);
    try {
      var updatePasswordBody = {
        "oldPassword": oldPassword,
        "password": newPassword
      };
      var request = await _dioClient.put(
          url: APIEndpoints.updatePassword,
          data: updatePasswordBody,
          requiresToken: true);

      if (_dioClient.checkResponse(request: request)) {
        ScreenUtils.showSnackBar(
            msg: 'Password changed successfully!', isShort: false);

        passwordController.value.clear();
        newPasswordController.value.clear();
        newPasswordVerifyController.value.clear();

        passwordVisible(false);
        newPasswordVisible(false);
        newPasswordVerifyVisible(false);

        Get.offAll(() => const LoginScreen());
      } else {
        throw 'error in response updating password.';
      }
    } catch (e) {
      debugPrint('>> error updating password: ${e.toString()}');
      ScreenUtils.showSnackBar(
          msg: 'Could not update password!', isShort: false);
    } finally {
      isProcessing(false);
    }
  }

  saveCredentials() async {
    appUser.value.password = passwordController.value.text;

    LoginModel temp = LoginModel(
        username: usernameController.value.text,
        password: passwordController.value.text);

    await _localStorage.write(key: uUser, value: LoginModel.serialize(temp));
    debugPrint('>> user session saved');
  }

  retrieveCredentials() async {
    isProcessing(true);
    try {
      debugPrint('>> retrieving session saved');
      LoginModel? temp;
      temp = LoginModel.deserialize((await _localStorage.readKey(key: uUser))!);

      debugPrint('>> ${temp.username} ${temp.password}');
      if (temp.username.isEmpty || temp.password.isEmpty) {
        await clearCredentials();
      } else {
        await login(username: temp.username, password: temp.password);
      }
    } catch (e) {
      debugPrint('>> error retrieving previous session data: ${e.toString()}');
      Fluttertoast.showToast(msg: "Couldn't log into previous session.");
      Get.offAll(() => const LoginScreen());
    } finally {
      isProcessing(false);
    }
  }

  clearCredentials() async {
    await _localStorage.removeAll();
  }
}
