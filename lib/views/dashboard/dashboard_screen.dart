import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:roj_gaar_app/controllers/clients/app_controller.dart';
import 'package:roj_gaar_app/controllers/clients/dashboard_controller.dart';
import 'package:roj_gaar_app/controllers/clients/job_controller.dart';
import 'package:roj_gaar_app/utils/api_endpoints.dart';
import 'package:roj_gaar_app/utils/constants.dart';
import 'package:roj_gaar_app/views/jobs/job_detail.dart';
import 'package:roj_gaar_app/views/utils/screen_utils.dart';
import '../profile/manage_jobs_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardController dashboardController = Get.find<DashboardController>();
  AppController appController = Get.find<AppController>();
  JobController jobController = Get.find<JobController>();

  @override
  void initState() {
    if (appController.appUser.value.skills == null) {
      dashboardController.navigate(page: DashboardPages.setup);
      ScreenUtils.showSnackBar(
          msg: 'Please complete your profile to get recommendations!',
          isShort: false);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        if (appController.isUser.value) {
          await jobController.getRecommendedJobs();
        } else {
          await jobController.getCompanyJobs(
              companyId: appController.appUser.value.company!.id);
        }
        await jobController.getAvailableJobs();
      },
      child: SizedBox(
        height: 1.sh,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15.0.w,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              if (appController.isUser.value)
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ScreenUtils.customLabel(
                            labelType: LabelType.heading2,
                            text: 'Recommended Jobs',
                            isBold: true),
                        ScreenUtils.customGestureDetector(
                          child: Image.asset(
                            'assets/rojgar_logo.png',
                            width: 30.w,
                            fit: BoxFit.contain,
                          ),
                          callbackAction: () => dashboardController.navigate(
                            page: DashboardPages.settings,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              Expanded(
                child: Obx(() => (jobController.jobLoading.value)
                    ? const Center(child: CircularProgressIndicator())
                    : (appController.isUser.value)
                        // user section
                        ? (jobController.jobLoading.value)
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : (jobController.recommendedJobs.isEmpty)
                                ? (appController.appUser.value.skills == null ||
                                        appController.appUser.value.skills!
                                            .skills.isEmpty)
                                    ? Center(
                                        child: ScreenUtils.customLabel(
                                            labelType: LabelType.body,
                                            maxLines: 3,
                                            isCenterAligned: true,
                                            text:
                                                'Please complete your profile by navigating to Settings on the bottom right to get recommendations!'),
                                      )
                                    : Center(
                                        child: ScreenUtils.customLabel(
                                            labelType: LabelType.body,
                                            text:
                                                'No jobs available currently.'),
                                      )
                                : ListView.builder(
                                    itemCount:
                                        jobController.recommendedJobs.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 5.h),
                                        child:
                                            ScreenUtils.customGestureDetector(
                                          child: SizedBox(
                                            height: 0.24.sh,
                                            child: Card(
                                              // elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                              // color: Colors.white,
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
                                                                        10.r),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: (dashboardController.categories.indexWhere((p0) =>
                                                                          p0.title ==
                                                                          jobController
                                                                              .recommendedJobs[index]
                                                                              .category) ==
                                                                      -1)
                                                                  ? jobsImageUrl
                                                                  : '${APIEndpoints.baseUrl}/${dashboardController.categories.firstWhere((p0) => p0.title == jobController.recommendedJobs[index].category).image.replaceAll('\\', '/')}',
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
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: ScreenUtils.customLabel(
                                                                  labelType:
                                                                      LabelType
                                                                          .body,
                                                                  text: jobController
                                                                      .recommendedJobs[
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
                                                                      .recommendedJobs[
                                                                          index]
                                                                      .category,
                                                                  hasEllipsis:
                                                                      true),
                                                            ),
                                                          ],
                                                        ),
                                                        if (jobController
                                                                .recommendedJobs[
                                                                    index]
                                                                .company !=
                                                            null)
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: ScreenUtils.customLabel(
                                                                    labelType:
                                                                        LabelType
                                                                            .small,
                                                                    text: jobController
                                                                        .recommendedJobs[
                                                                            index]
                                                                        .company!
                                                                        .name,
                                                                    hasEllipsis:
                                                                        true),
                                                              ),
                                                            ],
                                                          ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: ScreenUtils.customLabel(
                                                                  maxLines: 4,
                                                                  labelType:
                                                                      LabelType
                                                                          .body,
                                                                  text: jobController
                                                                      .recommendedJobs[
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
                                          callbackAction: () {
                                            jobController.currentJob =
                                                (jobController
                                                        .recommendedJobs[index])
                                                    .obs;
                                            Get.to(() => JobDetailScreen());
                                          },
                                        ),
                                      );
                                    },
                                  )

                        // company section
                        : (appController
                                    .appUser.value.company!.sector.isEmpty ||
                                appController
                                    .appUser.value.company!.country.isEmpty ||
                                appController
                                    .appUser.value.company!.region.isEmpty ||
                                appController
                                    .appUser.value.company!.phone.isEmpty)
                            ? Center(
                                child: ScreenUtils.customLabel(
                                    labelType: LabelType.body,
                                    isCenterAligned: true,
                                    text:
                                        'Please complete your profile by navigating to Settings on the bottom right to continue!',
                                    maxLines: 2),
                              )
                            : SingleChildScrollView(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ScreenUtils.customLabel(
                                            labelType: LabelType.heading1,
                                            text: appController
                                                .appUser.value.company!.name,
                                            isBold: true),
                                        ScreenUtils.customGestureDetector(
                                          child: Image.asset(
                                            'assets/rojgar_logo.png',
                                            width: 30.w,
                                            fit: BoxFit.contain,
                                          ),
                                          callbackAction: () =>
                                              dashboardController.navigate(
                                            page: DashboardPages.settings,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      children: [
                                        ScreenUtils.customLabel(
                                            labelType: LabelType.body,
                                            isItalic: true,
                                            text: appController
                                                .appUser.value.email,
                                            color:
                                                primaryColor.withOpacity(0.8),
                                            isBold: true),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(Icons.phone),
                                        SizedBox(
                                          width: 5.w,
                                        ),
                                        ScreenUtils.customLabel(
                                            labelType: LabelType.body,
                                            text: appController
                                                .appUser.value.company!.phone,
                                            color: primaryColor,
                                            isItalic: true),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    Row(
                                      children: [
                                        ScreenUtils.customLabel(
                                          labelType: LabelType.body,
                                          text:
                                              '${appController.appUser.value.company!.region}, ${appController.appUser.value.company!.country}',
                                          color: primaryColor,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    if (appController
                                        .appUser.value.company!.desc.isNotEmpty)
                                      Row(
                                        children: [
                                          ScreenUtils.customLabel(
                                            labelType: LabelType.body,
                                            text: appController
                                                .appUser.value.company!.desc,
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
                                        Expanded(
                                          child: ScreenUtils.customLabel(
                                            labelType: LabelType.heading2,
                                            isBold: true,
                                            text: 'About Us:',
                                            color: primaryColor,
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              TextEditingController about =
                                                  TextEditingController(
                                                      text: appController
                                                          .appUser
                                                          .value
                                                          .company!
                                                          .about);
                                              Get.defaultDialog(
                                                  title: 'Edit about company:',
                                                  titlePadding: EdgeInsets.only(
                                                      top: 20.h),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 20.w),
                                                  content: SizedBox(
                                                    height: 0.3.sh,
                                                    child:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          TextFormField(
                                                            controller: about,
                                                            decoration:
                                                                const InputDecoration(
                                                              label: Text(
                                                                  'About Company'),
                                                            ),
                                                            textInputAction:
                                                                TextInputAction
                                                                    .done,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                          ),
                                                          SizedBox(
                                                            height: 10.h,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              ScreenUtils
                                                                  .customGestureDetector(
                                                                child: ScreenUtils.roundedContainer(
                                                                    child: ScreenUtils.customLabel(
                                                                        labelType:
                                                                            LabelType
                                                                                .body,
                                                                        text:
                                                                            'Cancel'),
                                                                    isPrimary:
                                                                        false),
                                                                callbackAction:
                                                                    () => Get
                                                                        .back(),
                                                              ),
                                                              SizedBox(
                                                                width: 10.w,
                                                              ),
                                                              ScreenUtils
                                                                  .customGestureDetector(
                                                                child: ScreenUtils
                                                                    .roundedContainer(
                                                                  child: ScreenUtils.customLabel(
                                                                      labelType:
                                                                          LabelType
                                                                              .body,
                                                                      text:
                                                                          'Confirm',
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                callbackAction:
                                                                    () {
                                                                  if (about.text
                                                                      .trim()
                                                                      .isEmpty) {
                                                                    Get.back();
                                                                  } else {
                                                                    appController
                                                                        .appUser
                                                                        .value
                                                                        .company!
                                                                        .about = about.text;

                                                                    appController
                                                                        .appUser
                                                                        .refresh();
                                                                    Get.back();
                                                                    ScreenUtils
                                                                        .showSnackBar();
                                                                  }
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ));
                                            },
                                            icon: const Icon(Icons.edit))
                                      ],
                                    ),
                                    // SizedBox(
                                    //   height: 5.h,
                                    // ),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ScreenUtils.customLabel(
                                              maxLines: 7,
                                              hasEllipsis: true,
                                              labelType: LabelType.body,
                                              text: appController.appUser.value
                                                      .company!.about.isEmpty
                                                  ? lorem
                                                  : appController.appUser.value
                                                      .company!.about),
                                        ),
                                        // color: primaryColor,
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
                                      () => (jobController.jobLoading.value)
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            )
                                          : ScreenUtils.customGestureDetector(
                                              child: Card(
                                                color: Colors.white,
                                                child: SizedBox(
                                                  height: 0.2.sh,
                                                  width: 0.4.sw,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Column(
                                                      children: [
                                                        const Expanded(
                                                            child: Icon(
                                                                Icons.work)),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: ScreenUtils
                                                                  .customLabel(
                                                                maxLines: 3,
                                                                labelType:
                                                                    LabelType
                                                                        .heading2,
                                                                isBold: true,
                                                                isCenterAligned:
                                                                    true,
                                                                text:
                                                                    'Posted Jobs\n(${jobController.companyJobList.length})',
                                                                color:
                                                                    primaryColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              callbackAction: () => Get.to(() =>
                                                  ManageJobScreen(
                                                      isPending: false)),
                                            ),
                                    ),
                                    // if (jobController
                                    //     .companyJobList.isNotEmpty)
                                    //   for (var application
                                    //       in jobController
                                    //           .companyJobList)
                                    //     Row(
                                    //       children: [
                                    //         ScreenUtils.customLabel(
                                    //           labelType:
                                    //               LabelType.body,
                                    //           maxLines: 20,
                                    //           hasEllipsis: true,
                                    //           text:
                                    //               '- ${application.title}',
                                    //           // color: primaryColor,
                                    //         ),
                                    //       ],
                                    //     ),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                  ],
                                ),
                              )),
              ),
              // SizedBox(
              //   height: 70.h,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
