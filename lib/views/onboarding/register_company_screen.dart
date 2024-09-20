import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../controllers/clients/registration_controller.dart';
import '../../utils/constants.dart';
import '../utils/screen_utils.dart';

class CompanyRegisterScreen extends StatefulWidget {
  const CompanyRegisterScreen({super.key});

  @override
  State<CompanyRegisterScreen> createState() => _CompanyRegisterScreenState();
}

class _CompanyRegisterScreenState extends State<CompanyRegisterScreen> {
  RegistrationController registrationController =
      Get.put(RegistrationController(), permanent: true);
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    registrationController.getCategories();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<RegistrationController>(force: true);
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
                              return 'Please enter your company email!';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Company Email'),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        TextFormField(
                          controller:
                              registrationController.usernameController.value,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username/alias!';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text('Company Alias'),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Obx(
                          () => ScreenUtils.customGestureDetector(
                            child: TextFormField(
                              onTap: () async =>
                                  ScreenUtils.companySectorBottomList(
                                      items:
                                          registrationController.companySector,
                                      controller: registrationController
                                          .selectedCompanySectorController
                                          .value),
                              controller: registrationController
                                  .selectedCompanySectorController.value,
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select company sector!';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  label: const Text('Company Sector'),
                                  suffixIcon: IconButton(
                                      onPressed: () =>
                                          ScreenUtils.companySectorBottomList(
                                              items: registrationController
                                                  .companySector,
                                              controller: registrationController
                                                  .selectedCompanySectorController
                                                  .value),
                                      icon: const Icon(Icons.arrow_drop_down))),
                            ),
                            callbackAction: () async =>
                                await ScreenUtils.companySectorBottomList(
                                    items: registrationController.companySector,
                                    controller: registrationController
                                        .selectedCompanySectorController.value),
                          ),
                        ),
                        SizedBox(
                          height: 15.h,
                        ),
                        Obx(
                          () => TextFormField(
                            controller:
                                registrationController.passwordController.value,
                            obscureText:
                                !registrationController.passwordVisible.value,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password!';
                              } else if (value.length < 8) {
                                return 'Invalid password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                label: const Text('Password'),
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
                          height: 15.h,
                        ),
                        Obx(
                          () => TextFormField(
                            controller: registrationController
                                .confirmPasswordController.value,
                            obscureText: !registrationController
                                .confirmPasswordVisible.value,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please verify your password!';
                              } else if (value.length < 8) {
                                return 'Invalid password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(),
                                label: const Text('Confirm Password'),
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
                              isUser: false);
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
