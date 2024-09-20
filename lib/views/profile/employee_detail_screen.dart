import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roj_gaar_app/controllers/clients/app_controller.dart';
import 'package:roj_gaar_app/controllers/clients/dashboard_controller.dart';
import '../../utils/constants.dart';
import '../utils/screen_utils.dart';

class EmployeeDetailScreen extends StatefulWidget {
  const EmployeeDetailScreen({super.key});

  @override
  State<EmployeeDetailScreen> createState() => _EmployeeDetailScreenState();
}

class _EmployeeDetailScreenState extends State<EmployeeDetailScreen> {
  AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                ScreenUtils.customLabel(
                    labelType: LabelType.heading1,
                    text: 'Employee Detail',
                    isBold: true,
                    color: primaryColor),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            CachedNetworkImage(
              height: 100.h,
              imageUrl: avatarImageURL,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                ScreenUtils.customLabel(
                    labelType: LabelType.heading2,
                    text: appController.currentEmployee.value.username,
                    color: primaryColor),
              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            const Divider(),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                ScreenUtils.customLabel(
                    labelType: LabelType.body,
                    text: appController.currentEmployee.value.email,
                    color: primaryColor),
              ],
            ),
            if (appController.currentEmployee.value.skills != null)
              Column(
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      ScreenUtils.customLabel(
                          labelType: LabelType.body,
                          text: 'Skills:',
                          color: primaryColor),
                    ],
                  ),
                  for (var skill
                      in appController.currentEmployee.value.skills!.skills)
                    Row(
                      children: [
                        Expanded(
                          child: ScreenUtils.customLabel(
                            labelType: LabelType.body,
                            maxLines: 20,
                            text: '- $skill',
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            if (appController.currentEmployee.value.experience.isNotEmpty)
              Column(
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      ScreenUtils.customLabel(
                          labelType: LabelType.body,
                          text: 'Past Experiences:',
                          color: primaryColor),
                    ],
                  ),
                  for (var experience
                      in appController.currentEmployee.value.experience)
                    Row(
                      children: [
                        Expanded(
                          child: ScreenUtils.customLabel(
                            labelType: LabelType.body,
                            maxLines: 20,
                            text: '- $experience',
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            if (appController.currentEmployee.value.education.isNotEmpty)
              Column(
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  const Divider(),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      ScreenUtils.customLabel(
                          labelType: LabelType.body,
                          text: 'Education:',
                          color: primaryColor),
                    ],
                  ),
                  for (var education
                      in appController.currentEmployee.value.education)
                    Row(
                      children: [
                        Expanded(
                          child: ScreenUtils.customLabel(
                            labelType: LabelType.body,
                            maxLines: 20,
                            text: '- $education',
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            SizedBox(
              height: 5.h,
            ),
            const Divider(),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                ScreenUtils.customLabel(
                    labelType: LabelType.body,
                    text:
                        'CTC: ${appController.currentEmployee.value.currentCtc.toStringAsFixed(2)}',
                    color: primaryColor),
              ],
            ),
            // SizedBox(
            //   height: 10.h,
            // ),
            // Row(
            //   children: [
            //     ScreenUtils.customLabel(
            //         labelType: LabelType.body,
            //         text:
            //             'Experience: ${appController.currentEmployee.value.expYears.toStringAsFixed(2)} year(s)',
            //         color: primaryColor),
            //   ],
            // ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    )));
  }
}
