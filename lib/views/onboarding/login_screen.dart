import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roj_gaar_app/controllers/clients/app_controller.dart';
import 'package:roj_gaar_app/utils/constants.dart';
import 'package:roj_gaar_app/views/utils/screen_utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AppController appController = Get.find<AppController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              SizedBox(
                height: 80.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScreenUtils.customLabel(
                    labelType: LabelType.title,
                    text: 'Welcome ',
                  ),
                  ScreenUtils.customLabel(
                      labelType: LabelType.title,
                      text: 'aboard!',
                      color: primaryColor,
                      isBold: true),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              ScreenUtils.customLabel(
                  labelType: LabelType.body,
                  text: 'Use your email and password to log in.',
                  isCenterAligned: true),
              SizedBox(
                height: 40.h,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    ScreenUtils.customGestureDetector(
                      child: Obx(
                        () => TextFormField(
                          controller: appController.usertypeController.value,
                          enabled: false,
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.arrow_drop_down),
                            border: OutlineInputBorder(),
                            labelText: 'User type',
                            // hintText: 'Please select user type',
                          ),
                        ),
                      ),
                      callbackAction: () {
                        ScreenUtils.companySectorBottomList(
                          items: ['User', 'Company'],
                          controller: appController.usertypeController.value,
                        );
                      },
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    TextFormField(
                      controller: appController.usernameController.value,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username!';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Username',
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Obx(
                      () => TextFormField(
                        controller: appController.passwordController.value,
                        obscureText: !appController.passwordVisible.value,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (pw) async =>
                            await appController.login(),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password!';
                          }else if (value.length<8){
                            return 'Invalid password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            label: const Text('Password'),
                            suffixIcon: IconButton(
                                onPressed: () => appController.passwordVisible(
                                    !appController.passwordVisible.value),
                                icon: Icon(appController.passwordVisible.value
                                    ? Icons.visibility
                                    : Icons.visibility_off))),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Obx(
                  () => Row(
                    children: [
                      Expanded(
                        child: (appController.isProcessing.value)
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ScreenUtils.customGestureDetector(
                                child: ScreenUtils.roundedContainer(
                                  borderRadius: 10.r,
                                  child: ScreenUtils.customLabel(
                                      text: "Login",
                                      labelType: LabelType.body,
                                      color: Colors.white),
                                ),
                                callbackAction: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await appController.login();
                                  }
                                }),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              ScreenUtils.customLabel(
                  labelType: LabelType.body,
                  text: 'If you don’t have account,'),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScreenUtils.customLabel(
                      labelType: LabelType.body, text: 'please'),
                  ScreenUtils.customGestureDetector(
                    child: ScreenUtils.customLabel(
                        labelType: LabelType.body,
                        text: ' sign up.',
                        color: primaryColor),
                    callbackAction: () => Get.toNamed(onBoarding),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
