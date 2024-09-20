import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roj_gaar_app/controllers/clients/registration_controller.dart';

import '../../utils/constants.dart';
import '../utils/screen_utils.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  RegistrationController registrationController =
      Get.find<RegistrationController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0.w),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: registrationController.otpController.value,
              textInputAction: TextInputAction.done,
              maxLength: 6,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter OTP!';
                } else if (value.length != 6) {
                  return 'Invalid OTP';
                }
                return null;
              },
            ),
            SizedBox(
              height: 20.h,
            ),
            ScreenUtils.customGestureDetector(
              child: ScreenUtils.customLabel(
                  labelType: LabelType.body, text: "Resend OTP?"),
              callbackAction: () {},
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: (registrationController.isProcessing.value)
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ScreenUtils.customGestureDetector(
                      child: ScreenUtils.roundedContainer(
                        borderRadius: 10.r,
                        child: ScreenUtils.customLabel(
                            text: "Verify",
                            labelType: LabelType.body,
                            color: Colors.white),
                      ),
                      callbackAction: () async {
                        if (_formKey.currentState!.validate()) {
                          await registrationController.verifyOtp();
                        }
                      }),
            ),
          ],
        ),
      ),
    ));
  }
}
