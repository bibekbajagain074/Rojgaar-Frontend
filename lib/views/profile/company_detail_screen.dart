import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roj_gaar_app/controllers/clients/app_controller.dart';
import '../../utils/constants.dart';
import '../utils/screen_utils.dart';

class CompanyDetailScreen extends StatefulWidget {
  const CompanyDetailScreen({super.key});

  @override
  State<CompanyDetailScreen> createState() => _CompanyDetailScreenState();
}

class _CompanyDetailScreenState extends State<CompanyDetailScreen> {
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
                    text: 'Company Detail',
                    isBold: true,
                    color: primaryColor),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            CachedNetworkImage(
              height: 100.h,
              imageUrl: companyImageURL,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                ScreenUtils.customLabel(
                    labelType: LabelType.heading1,
                    isBold: true,
                    text: appController.currentCompany.value.name,
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
                    text: appController.currentCompany.value.email,
                    color: primaryColor),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            if (appController.currentCompany.value.applicants.isNotEmpty)
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
                          text: 'Applicants:',
                          color: primaryColor),
                    ],
                  ),
                  for (var applicants
                      in appController.currentCompany.value.applicants)
                    Row(
                      children: [
                        Expanded(
                          child: ScreenUtils.customLabel(
                            labelType: LabelType.body,
                            maxLines: 20,
                            text: '- $applicants',
                          ),
                        ),
                      ],
                    ),
                ],
              ),

            if (appController.currentCompany.value.jobs.isNotEmpty)
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
                          text: 'Active jobs:',
                          color: primaryColor),
                    ],
                  ),
                  for (var job in appController.currentCompany.value.jobs)
                    Row(
                      children: [
                        Expanded(
                          child: ScreenUtils.customLabel(
                            labelType: LabelType.body,
                            maxLines: 20,
                            text: '- $job',
                          ),
                        ),
                      ],
                    ),
                ],
              ),
          ],
        ),
      ),
    )));
  }
}
