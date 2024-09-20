import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:roj_gaar_app/controllers/clients/dashboard_controller.dart';
import 'package:roj_gaar_app/utils/api_endpoints.dart';
import 'package:roj_gaar_app/utils/constants.dart';
import 'package:roj_gaar_app/views/onboarding/login_screen.dart';
import 'package:roj_gaar_app/views/onboarding/otp_verification_screen.dart';
import '../../models/category_model.dart';
import '../../models/user_model.dart';
import 'dio_client.dart';

class RegistrationController extends GetxController {
  final DioClient _dioClient = DioClient();

  late Rx<UserModel> registeredUser; // app user

  RxBool passwordVisible = false.obs,
      confirmPasswordVisible = false.obs,
      isProcessing = false.obs;

  RxList<String> companySector = <String>[].obs;

  Rx<TextEditingController> usernameController = TextEditingController().obs,
      emailController = TextEditingController().obs,
      passwordController = TextEditingController().obs,
      confirmPasswordController = TextEditingController().obs,
      selectedCompanySectorController = TextEditingController().obs,
      otpController = TextEditingController().obs;

  getCategories() async {
    DashboardController dashboardController = Get.find<DashboardController>();
    await dashboardController.getCategories();
    companySector.value =
        dashboardController.categories.map((model) => model.title).toList();
  }

  registerUser({required bool isUser}) async {
    isProcessing(true);
    try {
      var registrationBody = isUser
          ? {
              'username': usernameController.value.text,
              'email': emailController.value.text,
              'password': passwordController.value.text,
              'type': 'user'
            }
          : {
              'cname': usernameController.value.text,
              'username': usernameController.value.text,
              'email': emailController.value.text,
              'password': passwordController.value.text,
              'type': 'Company'
            };

      var request = await _dioClient.post(
          url: isUser
              ? APIEndpoints.employeeRegister
              : APIEndpoints.companyRegister,
          data: registrationBody);

      debugPrint(
          '>> registration request: ${isUser ? APIEndpoints.employeeRegister : APIEndpoints.companyRegister}\n>> $registrationBody');

      if (_dioClient.checkResponse(request: request)) {
        Fluttertoast.showToast(msg: request.data['msg']);

        Get.offAll(() => const LoginScreen());

        // registeredUser = UserModel.fromJson(request.data['user'])
        //     .obs; // user model for registered user
        //
        // await sendOtp(
        //     id: registeredUser.value.appId, email: emailController.value.text);
      } else {
        throw request.data['msg'] ?? "Failed to register!";
      }
    } catch (e) {
      debugPrint('>> error while registration: ${e.toString()}');
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    } finally {
      isProcessing(false);
    }
  }

  Future sendOtp({required String id, required String email}) async {
    isProcessing(true);
    try {
      var otpBody = {"id": id, "email": email};

      var request =
          await _dioClient.post(url: APIEndpoints.sendOTP, data: otpBody);

      debugPrint('>> OTP request: ${APIEndpoints.sendOTP}\n>> $otpBody');

      if (_dioClient.checkResponse(request: request)) {
        Fluttertoast.showToast(msg: request.data['msg']);

        Get.to(() => const OTPScreen());
      } else {
        throw request.data['msg'] ?? "Failed to send OTP!";
      }
    } catch (e) {
      debugPrint('>> error while sending OTP: ${e.toString()}');
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    } finally {
      isProcessing(false);
    }
  }

  Future verifyOtp() async {
    isProcessing(true);
    try {
      var request = await _dioClient.post(
          url:
              '${APIEndpoints.verifyOTP}/${registeredUser.value.appId}/${otpController.value.text}');

      debugPrint(
          '>> OTP request: ${'${APIEndpoints.verifyOTP}/${registeredUser.value.appId}/${otpController.value.text}'}');

      if (_dioClient.checkResponse(request: request)) {
        Fluttertoast.showToast(msg: request.data['msg']);

        Get.offAll(() => const LoginScreen());
      } else {
        throw request.data['msg'] ?? "Failed to verify OTP!";
      }
    } catch (e) {
      debugPrint('>> error while verifying OTP: ${e.toString()}');
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    } finally {
      isProcessing(false);
    }
  }
}
