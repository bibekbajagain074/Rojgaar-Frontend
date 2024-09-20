import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:roj_gaar_app/utils/constants.dart';
import 'package:roj_gaar_app/views/utils/screen_utils.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ScreenUtils.customLabel(
                        labelType: LabelType.heading2,
                        text: 'Choose your ',
                        isBold: true),
                    ScreenUtils.customLabel(
                        labelType: LabelType.heading2,
                        color: primaryColor,
                        isBold: true,
                        text: 'account type'),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                ScreenUtils.customLabel(
                    labelType: LabelType.heading2,
                    maxLines: 3,
                    text:
                        'Are you looking for a new job\nor\nlooking to hire someone?',
                    isCenterAligned: true),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ScreenUtils.customGestureDetector(
                      child: ScreenUtils.roundedContainer(
                          height: 0.3.sh,
                          width: 0.4.sw,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/shopping_bag.svg",
                                width: 50.w,
                                height: 50.h,
                                allowDrawingOutsideViewBox: true,
                              ),
                              ScreenUtils.customLabel(
                                  labelType: LabelType.body,
                                  text: 'Find jobs',
                                  color: Colors.white),
                            ],
                          )),
                      callbackAction: () => Get.toNamed(employeeRegistration),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    ScreenUtils.customGestureDetector(
                      child: ScreenUtils.roundedContainer(
                          height: 0.3.sh,
                          width: 0.4.sw,
                          isPrimary: false,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/user_circle.svg",
                                width: 50.w,
                                height: 50.h,
                                allowDrawingOutsideViewBox: true,
                              ),
                              ScreenUtils.customLabel(
                                  labelType: LabelType.body,
                                  maxLines: 2,
                                  text: 'Find employees',
                                  isCenterAligned: true,
                                  color: primaryColor),
                            ],
                          )),
                      callbackAction: () => Get.toNamed(employerRegistration),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
