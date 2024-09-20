import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roj_gaar_app/controllers/clients/app_controller.dart';
import 'package:roj_gaar_app/controllers/clients/job_controller.dart';
import 'package:roj_gaar_app/utils/api_endpoints.dart';
import '../../controllers/clients/dashboard_controller.dart';
import '../../utils/constants.dart';
import '../jobs/job_detail.dart';
import '../utils/screen_utils.dart';

class CategoryDetailScreen extends StatefulWidget {
  const CategoryDetailScreen({super.key});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  AppController appController = Get.find<AppController>();
  JobController jobController = Get.find<JobController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ScreenUtils.customLabel(
            labelType: LabelType.heading2,
            text: 'Category Detail',
            isBold: true,
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ScreenUtils.customLabel(
                        labelType: LabelType.heading1,
                        isBold: true,
                        hasEllipsis: true,
                        text: appController.currentCategory.value.title,
                        // color: primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ScreenUtils.customLabel(
                        labelType: LabelType.body,
                        maxLines: 5,
                        text: appController.currentCategory.value.description,
                        // color: primaryColor,
                      ),
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
                Obx(
                  () => (jobController.availableJobs
                          .where((p0) =>
                              p0.category.toLowerCase() ==
                              appController.currentCategory.value.title
                                  .toLowerCase())
                          .toList()
                          .isEmpty)
                      ? ScreenUtils.customLabel(
                          labelType: LabelType.body,
                          isItalic: true,
                          text: 'No jobs for the categories!')
                      : ListView.builder(
                          padding: EdgeInsets.only(bottom: 10.h),
                          itemCount: jobController.availableJobs
                              .where((p0) =>
                                  p0.category ==
                                  appController.currentCategory.value.title)
                              .toList()
                              .length,
                          shrinkWrap: true,
                          physics: const ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: .24.sh,
                              child: Card(
                                child: Stack(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                                Colors.white.withOpacity(0.85),
                                                BlendMode.srcOver),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    '${APIEndpoints.baseUrl}/${appController.currentCategory.value.image.replaceAll('\\', '/')}',
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(
                                                  Icons.error,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    ListTile(
                                      onTap: () {
                                        jobController.currentJob = jobController
                                            .availableJobs
                                            .where((p0) =>
                                                p0.category ==
                                                appController.currentCategory
                                                    .value.title)
                                            .toList()[index]
                                            .obs;
                                        Get.to(() => JobDetailScreen());
                                      },
                                      title: ScreenUtils.customLabel(
                                          labelType: LabelType.body,
                                          isBold: true,
                                          text: jobController.availableJobs
                                              .where((p0) =>
                                                  p0.category ==
                                                  appController.currentCategory
                                                      .value.title)
                                              .toList()[index]
                                              .title),
                                      subtitle: ScreenUtils.customLabel(
                                          labelType: LabelType.small,
                                          maxLines: 3,
                                          hasEllipsis: true,
                                          text:
                                              '${jobController.availableJobs.where((p0) => p0.category == appController.currentCategory.value.title).toList()[index].category}\n${jobController.availableJobs.where((p0) => p0.category == appController.currentCategory.value.title).toList()[index].description}'),
                                      isThreeLine: true,
                                    ),
                                  ],
                                ),
                              ),
                            );

                            return const SizedBox.shrink();
                          }),
                )
              ],
            ),
          ),
        )));
  }
}
