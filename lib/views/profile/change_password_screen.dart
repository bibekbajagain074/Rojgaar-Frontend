import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roj_gaar_app/controllers/clients/app_controller.dart';

import '../../controllers/clients/dashboard_controller.dart';
import '../../utils/constants.dart';
import '../utils/screen_utils.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ScreenUtils.customLabel(
              labelType: LabelType.heading1,
              text: 'Change Password',
              isBold: true,
              color: primaryColor),
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  TextField(
                    obscureText: !appController.passwordVisible.value,
                    controller: appController.passwordController.value,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Old Password',
                        suffixIcon: IconButton(
                            onPressed: () => appController.passwordVisible(
                                !appController.passwordVisible.value),
                            icon: Icon(appController.passwordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off))),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextField(
                    obscureText: !appController.newPasswordVisible.value,
                    controller: appController.newPasswordController.value,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'New Password',
                        suffixIcon: IconButton(
                            onPressed: () => appController.newPasswordVisible(
                                !appController.newPasswordVisible.value),
                            icon: Icon(appController.newPasswordVisible.value
                                ? Icons.visibility
                                : Icons.visibility_off))),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  TextField(
                    obscureText: !appController.newPasswordVerifyVisible.value,
                    controller: appController.newPasswordVerifyController.value,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: 'Verify New Password',
                        suffixIcon: IconButton(
                            onPressed: () => appController
                                .newPasswordVerifyVisible(!appController
                                    .newPasswordVerifyVisible.value),
                            icon: Icon(
                                appController.newPasswordVerifyVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off))),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
