import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roj_gaar_app/views/utils/screen_utils.dart';
import '../../controllers/clients/app_controller.dart';
import '../../controllers/clients/dashboard_controller.dart';
import '../../utils/constants.dart';

class OnBoardSelectionScreen extends StatefulWidget {
  const OnBoardSelectionScreen({super.key});

  @override
  State<OnBoardSelectionScreen> createState() => _OnBoardSelectionScreenState();
}

class _OnBoardSelectionScreenState extends State<OnBoardSelectionScreen> {
  DashboardController dashboardController =
  Get.put(DashboardController(), permanent: true);
  AppController appController = Get.put(AppController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ScreenUtils.customLabel(
              text: "Discover",
              color: primaryColor,
              isBold: true,
              labelType: LabelType.title,
            ),
            ScreenUtils.customLabel(
              text: "your dream job here!",
              labelType: LabelType.heading2,
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Image.asset(
                "assets/onBoarding.png",
                fit: BoxFit.cover,
                width: 1.sw,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Expanded(
                    child: ScreenUtils.customGestureDetector(
                  child: ScreenUtils.roundedContainer(
                      child: ScreenUtils.customLabel(
                          labelType: LabelType.body,
                          text: 'Login ',
                          color: Colors.white)),
                  callbackAction: () => Get.offAllNamed(login),
                )),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                Expanded(
                  child: ScreenUtils.customGestureDetector(
                      child: ScreenUtils.roundedContainer(
                          isPrimary: false,
                          child: ScreenUtils.customLabel(
                              labelType: LabelType.body,
                              text: 'Sign Up ',
                              color: primaryColor)),
                      callbackAction: () => Get.toNamed(onBoarding)),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
