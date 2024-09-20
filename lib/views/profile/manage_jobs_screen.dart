import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roj_gaar_app/controllers/clients/dashboard_controller.dart';
import '../../controllers/clients/app_controller.dart';
import '../../controllers/clients/job_controller.dart';
import '../../utils/constants.dart';
import '../jobs/job_detail.dart';
import '../utils/screen_utils.dart';

class ManageJobScreen extends StatefulWidget {
  ManageJobScreen({super.key, required this.isPending});

  bool isPending = false;

  @override
  State<ManageJobScreen> createState() => _ManageJobScreenState();
}

class _ManageJobScreenState extends State<ManageJobScreen> {
  JobController jobController = Get.find<JobController>();
  DashboardController dashboardController = Get.find<DashboardController>();
  AppController appController = Get.find<AppController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJobDetails();
  }

  getJobDetails() async {
    if (!appController.isUser.value) {
      await jobController.getCompanyJobs(
          companyId: appController.appUser.value.company!.id);
    } else {
      await jobController.getAppliedJobs();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ScreenUtils.customLabel(
              labelType: LabelType.heading1,
              text: (appController.isUser.value)
                  ? 'Applied job list'
                  : (widget.isPending)
                      ? 'Pending applications'
                      : 'Posted Jobs',
              isBold: true,
              color: primaryColor),
        ),
        body: RefreshIndicator(
          onRefresh: () async => getJobDetails(),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Obx(
                    () => (jobController.userJobsLoading.value)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : (appController.isUser.value)
                            // user
                            ? (jobController.jobsList.isEmpty)
                                ? Center(
                                    child: ScreenUtils.customLabel(
                                        labelType: LabelType.body,
                                        text: 'No applied jobs found!'),
                                  )
                                : ListView.builder(
                                    itemCount: jobController.jobsList.length,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ScreenUtils.customGestureDetector(
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 5.h),
                                          child: SizedBox(
                                            height: 0.24.sh,
                                            child: Card(
                                              child: Stack(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: ColorFiltered(
                                                          colorFilter:
                                                              ColorFilter.mode(
                                                                  Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.95),
                                                                  BlendMode
                                                                      .srcOver),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.r),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: (jobController.jobsList.indexWhere((p0) =>
                                                                          p0.title ==
                                                                          jobController
                                                                              .jobsList[
                                                                                  index]
                                                                              .category) ==
                                                                      -1)
                                                                  ? jobsImageUrl
                                                                  : dashboardController
                                                                      .categories
                                                                      .firstWhere((p0) =>
                                                                          p0.title ==
                                                                          jobController
                                                                              .jobsList[index]
                                                                              .category)
                                                                      .image,
                                                              fit: BoxFit.cover,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  const CircularProgressIndicator(),
                                                              errorWidget:
                                                                  (context, url,
                                                                          error) =>
                                                                      Icon(
                                                                Icons.error,
                                                                size: 40.h,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.0.w,
                                                            vertical: 5.h),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: ScreenUtils.customLabel(
                                                                  labelType:
                                                                      LabelType
                                                                          .body,
                                                                  text: jobController
                                                                      .jobsList[
                                                                          index]
                                                                      .title,
                                                                  hasEllipsis:
                                                                      true,
                                                                  color:
                                                                      primaryColor,
                                                                  isBold: true),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: ScreenUtils.customLabel(
                                                                  labelType:
                                                                      LabelType
                                                                          .small,
                                                                  isItalic:
                                                                      true,
                                                                  text: jobController
                                                                      .jobsList[
                                                                          index]
                                                                      .category,
                                                                  hasEllipsis:
                                                                      true),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: ScreenUtils.customLabel(
                                                                  maxLines: 5,
                                                                  labelType:
                                                                      LabelType
                                                                          .body,
                                                                  text: jobController
                                                                      .jobsList[
                                                                          index]
                                                                      .description,
                                                                  hasEllipsis:
                                                                      true),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        callbackAction: () {
                                          jobController.currentJob =
                                              (jobController.jobsList[index])
                                                  .obs;
                                          Get.to(() => JobDetailScreen(
                                                isAppliedList: true,
                                              ));
                                        },
                                      );
                                    },
                                  )
                            // company
                            : (jobController.companyJobList.isEmpty)
                                ? Center(
                                    child: ScreenUtils.customLabel(
                                        labelType: LabelType.body,
                                        text: 'No posted jobs found!'),
                                  )
                                : ListView.builder(
                                    itemCount:
                                        jobController.companyJobList.length,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ScreenUtils.customGestureDetector(
                                        child: Padding(
                                          padding: EdgeInsets.only(bottom: 5.h),
                                          child: SizedBox(
                                            height: 0.24.sh,
                                            child: Card(
                                              child: Stack(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: ColorFiltered(
                                                          colorFilter:
                                                              ColorFilter.mode(
                                                                  Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.95),
                                                                  BlendMode
                                                                      .srcOver),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.r),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: (jobController.companyJobList.indexWhere((p0) =>
                                                                          p0.title ==
                                                                          jobController
                                                                              .companyJobList[
                                                                                  index]
                                                                              .category) ==
                                                                      -1)
                                                                  ? jobsImageUrl
                                                                  : dashboardController
                                                                      .categories
                                                                      .firstWhere((p0) =>
                                                                          p0.title ==
                                                                          jobController
                                                                              .companyJobList[index]
                                                                              .category)
                                                                      .image,
                                                              fit: BoxFit.cover,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  const CircularProgressIndicator(),
                                                              errorWidget:
                                                                  (context, url,
                                                                          error) =>
                                                                      Icon(
                                                                Icons.error,
                                                                size: 40.h,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10.0.w,
                                                            vertical: 5.h),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: ScreenUtils.customLabel(
                                                                  labelType:
                                                                      LabelType
                                                                          .body,
                                                                  text: jobController
                                                                      .companyJobList[
                                                                          index]
                                                                      .title,
                                                                  hasEllipsis:
                                                                      true,
                                                                  color:
                                                                      primaryColor,
                                                                  isBold: true),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: ScreenUtils.customLabel(
                                                                  labelType:
                                                                      LabelType
                                                                          .small,
                                                                  isItalic:
                                                                      true,
                                                                  text: jobController
                                                                      .companyJobList[
                                                                          index]
                                                                      .category,
                                                                  hasEllipsis:
                                                                      true),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: ScreenUtils.customLabel(
                                                                  maxLines: 5,
                                                                  labelType:
                                                                      LabelType
                                                                          .body,
                                                                  text: jobController
                                                                      .companyJobList[
                                                                          index]
                                                                      .description,
                                                                  hasEllipsis:
                                                                      true),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        callbackAction: () {
                                          jobController.currentCompanyJob =
                                              (jobController
                                                      .companyJobList[index])
                                                  .obs;
                                          Get.to(() => JobDetailScreen());
                                        },
                                      );
                                    },
                                  ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
