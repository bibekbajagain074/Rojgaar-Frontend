import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roj_gaar_app/controllers/clients/registration_controller.dart';
import 'package:roj_gaar_app/utils/constants.dart';
import '../utils/screen_utils.dart';

class EmployeeRegisterScreen extends StatefulWidget {
  const EmployeeRegisterScreen({super.key});

  @override
  State<EmployeeRegisterScreen> createState() => _EmployeeRegisterScreenState();
}

class _EmployeeRegisterScreenState extends State<EmployeeRegisterScreen> {
  RegistrationController registrationController =
      Get.put(RegistrationController());
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<RegistrationController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 40.h,
                ),
                ScreenUtils.customLabel(
                    text: "Create Account",
                    labelType: LabelType.heading1,
                    isBold: true,
                    isCenterAligned: true,
                    color: primaryColor),
                SizedBox(
                  height: 10.h,
                ),
                ScreenUtils.customLabel(
                  text: "Enter your email and password to sign up.",
                  labelType: LabelType.body,
                  isCenterAligned: true,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller:
                              registrationController.emailController.value,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email!';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Email',
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        TextFormField(
                          controller:
                              registrationController.usernameController.value,
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
                          height: 10.h,
                        ),
                        Obx(
                          () => TextFormField(
                            obscureText:
                                !registrationController.passwordVisible.value,
                            controller:
                                registrationController.passwordController.value,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password!';
                              } else if (value.length < 8) {
                                return 'Password must be at least 8 characters!';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: 'Password',
                                suffixIcon: IconButton(
                                    onPressed: () => registrationController
                                        .passwordVisible(!registrationController
                                            .passwordVisible.value),
                                    icon: Icon(registrationController
                                            .passwordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off))),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Obx(
                          () => TextFormField(
                            obscureText: !registrationController
                                .confirmPasswordVisible.value,
                            controller: registrationController
                                .confirmPasswordController.value,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password!';
                              } else if (value.length < 8) {
                                return 'Password must be at least 8 characters!';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                hintText: 'Confirm Password',
                                suffixIcon: IconButton(
                                    onPressed: () => registrationController
                                        .confirmPasswordVisible(
                                            !registrationController
                                                .confirmPasswordVisible.value),
                                    icon: Icon(registrationController
                                            .confirmPasswordVisible.value
                                        ? Icons.visibility
                                        : Icons.visibility_off))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ScreenUtils.customGestureDetector(
                      child: ScreenUtils.roundedContainer(
                        borderRadius: 10.r,
                        child: ScreenUtils.customLabel(
                            text: "Sign up",
                            labelType: LabelType.body,
                            color: Colors.white),
                      ),
                      callbackAction: () async {
                        if (_formKey.currentState!.validate()) {
                          await registrationController.registerUser(
                              isUser: true);
                        }
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),
              ],
            ),
          ),
        ));
  }
}
