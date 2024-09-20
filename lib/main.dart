import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roj_gaar_app/controllers/clients/dashboard_controller.dart';
import 'package:roj_gaar_app/controllers/clients/job_controller.dart';
import 'package:roj_gaar_app/controllers/clients/app_controller.dart';
import 'package:http/http.dart' as http;
import 'package:roj_gaar_app/utils/api_endpoints.dart';
import 'package:roj_gaar_app/utils/app_theme_data.dart';
import 'package:roj_gaar_app/views/dashboard/home_screen.dart';
import 'package:roj_gaar_app/views/onboarding/onboarding_screen.dart';
import 'package:roj_gaar_app/views/onboarding/login_screen.dart';
import 'package:roj_gaar_app/views/onboarding/onboard_selection_screen.dart';
import 'package:roj_gaar_app/views/onboarding/register_employee_screen.dart';
import 'package:roj_gaar_app/views/onboarding/register_company_screen.dart';
import 'package:roj_gaar_app/views/profile/change_password_screen.dart';
import 'package:roj_gaar_app/views/profile/manage_profile_screen.dart';
import 'package:roj_gaar_app/views/utils/screen_utils.dart';
import 'utils/constants.dart';
import 'utils/secure_storage_helper.dart';

void main() {
  Get.put(AppController(), permanent: true);
  Get.put(JobController(), permanent: true);
  Get.put(DashboardController(), permanent: true);

  runApp(ScreenUtilInit(
    child: GetMaterialApp(
      theme: AppThemeData.appThemeData,
      debugShowCheckedModeBanner: false,
      initialRoute: splashScreen,
      getPages: [
        GetPage(name: splashScreen, page: () => const SplashScreen()),
        GetPage(
            name: onBoardingSelection,
            page: () => const OnBoardSelectionScreen()),
        GetPage(name: onBoarding, page: () => const OnBoardingScreen()),
        GetPage(
          name: employeeRegistration,
          page: () => const EmployeeRegisterScreen(),
        ),
        GetPage(
          name: employerRegistration,
          page: () => const CompanyRegisterScreen(),
        ),
        GetPage(name: login, page: () => const LoginScreen()),
        GetPage(name: home, page: () => const HomeContainer()),
        GetPage(
          name: employeeProfile,
          page: () => const ManageProfileScreen(),
        ),
        GetPage(name: changePassword, page: () => const ChangePasswordScreen()),
      ],
    ),
  ));
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppController appController = Get.find<AppController>();

  @override
  void initState() {
    super.initState();
    checkConnection();
  }

  Future checkConnection() async {
    try {
      final result = await http.get(Uri.parse(APIEndpoints.baseUrl));
      if (result.statusCode == 200) {
        debugPrint('>> server found!');
        if (await SecureStorageHelper().readKey(key: uUser) != null) {
          // retrieve user data
          await appController.retrieveCredentials();
        } else {
          await appController.clearCredentials();
          // no login session found
          Get.toNamed(onBoardingSelection);
        }

        return true;
      } else {
        throw result.statusCode;
      }
    } on SocketException catch (_) {
      debugPrint('>> error checking connection: ${_.toString()}');
      ScreenUtils.showSnackBar(msg: 'Could not establish connection!');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => checkConnection(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 120.h,
              ),
              Center(
                child: Image.asset(
                  "assets/rojgar_logo.png",
                ),
              ),
              Center(
                child: ScreenUtils.customLabel(
                  labelType: LabelType.title,
                  text: 'ROJGAAR',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
