import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roj_gaar_app/controllers/clients/app_controller.dart';
import 'package:roj_gaar_app/models/application_model.dart';
import '../../controllers/clients/job_controller.dart';
import '../../utils/constants.dart';
import '../utils/screen_utils.dart';

class JobDetailScreen extends StatefulWidget {
  JobDetailScreen({super.key, this.isAppliedList = false});

  bool isAppliedList = false;

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  JobController jobController = Get.find<JobController>();
  AppController appController = Get.find<AppController>();
  bool applied = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  initialize() async {
    if (appController.isUser.value) {
      if (!widget.isAppliedList) {
        bool temp = await jobController.checkJobApplication(
            jobId: jobController.currentJob.value.id);
        setState(() {
          applied = temp;
        });
      } else {
        setState(() {
          applied = true;
        });
      }
      if (jobController.currentJob.value.status == 'Accepted') {
        ScreenUtils.showSnackBar(msg: 'Please check you inbox to continue.');
      }
    } else {
      await jobController.getApplicants(
          companyId: appController.appUser.value.company!.id);
      debugPrint(
          '>> count for applicants: ${jobController.currentCompanyJob.value.applicants.length}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ScreenUtils.customLabel(
              labelType: LabelType.heading1,
              isBold: true,
              text: (appController.isUser.value)
                  ? jobController.currentJob.value.title
                  : jobController.currentCompanyJob.value.title,
              color: primaryColor),
        ),
        bottomNavigationBar: (appController.isUser.value)
            ? ScreenUtils.customGestureDetector(
                child: ScreenUtils.roundedContainer(
                    borderRadius: 0.r,
                    height: 50.h,
                    isPrimary: !applied,
                    hasBorder: false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() => (jobController.currentJob.value.status ==
                                'Accepted')
                            ? const Icon(
                                Icons.done_all,
                                color: Colors.green,
                              )
                            : const SizedBox.shrink()),
                        ScreenUtils.customLabel(
                          labelType: LabelType.body,
                          text: applied
                              ? jobController.currentJob.value.status == 'New'
                                  ? 'Applied'
                                  : jobController.currentJob.value.status
                              : 'Apply',
                          color: applied
                              ? jobController.currentJob.value.status == 'New'
                                  ? Colors.grey
                                  : Colors.green
                              : Colors.white,
                        ),
                      ],
                    )),
                callbackAction: () async {
                  if (!applied &&
                      await jobController.applyForJob(
                          jobId: jobController.currentJob.value.id)) {
                    ApplicationModel currentApplication = ApplicationModel(
                        jobId: jobController.currentJob.value.id,
                        appliedDate:
                            '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                        status: 'New',
                        applicationId: appController.appUser.value.appId);
                    appController.appUser.value.appliedJobs
                        .add(currentApplication);
                    await initialize();
                    ScreenUtils.showSnackBar(
                        msg: 'Job Application sent successfully');
                  }
                })
            : null,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: SingleChildScrollView(
            child: Obx(
              () => (appController.isUser.value)
                  ? Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        ScreenUtils.customLabel(
                          labelType: LabelType.heading2,
                          text: jobController.currentJob.value.category,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                ScreenUtils.customLabel(
                                    labelType: LabelType.body,
                                    text: 'Salary ',
                                    isBold: true,
                                    color: primaryColor),
                                ScreenUtils.customLabel(
                                  labelType: LabelType.body,
                                  text: jobController.currentJob.value.salary
                                      .toStringAsFixed(2),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                ScreenUtils.customLabel(
                                    labelType: LabelType.body,
                                    text: 'Type ',
                                    isBold: true,
                                    color: primaryColor),
                                ScreenUtils.customLabel(
                                  labelType: LabelType.body,
                                  text: 'Full Time',
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
                                text: 'Skills required:',
                                isBold: true,
                                color: primaryColor),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ScreenUtils.customLabel(
                                labelType: LabelType.body,
                                maxLines: 2,
                                hasEllipsis: true,
                                isItalic: true,
                                text: jobController.currentJob.value.skills
                                    .toString()
                                    .replaceAll('[', '')
                                    .replaceAll(']', ''),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        if (jobController
                            .currentJob.value.requirements.isNotEmpty)
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
                                      text: 'Job requirements:',
                                      isBold: true,
                                      color: primaryColor),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              for (var requirement in jobController
                                  .currentJob.value.requirements)
                                Row(
                                  children: [
                                    Expanded(
                                      child: ScreenUtils.customLabel(
                                        labelType: LabelType.body,
                                        maxLines: 20,
                                        text: '- $requirement',
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        if (jobController
                            .currentJob.value.responsibilities.isNotEmpty)
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
                                      text: 'Employee responsibilities:',
                                      isBold: true,
                                      color: primaryColor),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              for (var responsibility in jobController
                                  .currentJob.value.responsibilities)
                                Row(
                                  children: [
                                    Expanded(
                                      child: ScreenUtils.customLabel(
                                        labelType: LabelType.body,
                                        maxLines: 20,
                                        text: '- $responsibility',
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        SizedBox(
                          height: 10.h,
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        ScreenUtils.customLabel(
                          labelType: LabelType.heading2,
                          text: jobController.currentCompanyJob.value.category,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                ScreenUtils.customLabel(
                                    labelType: LabelType.body,
                                    text: 'Salary ',
                                    isBold: true,
                                    color: primaryColor),
                                ScreenUtils.customLabel(
                                  labelType: LabelType.body,
                                  text: jobController
                                      .currentCompanyJob.value.salary
                                      .toStringAsFixed(2),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                ScreenUtils.customLabel(
                                    labelType: LabelType.body,
                                    text: 'Type ',
                                    isBold: true,
                                    color: primaryColor),
                                ScreenUtils.customLabel(
                                  labelType: LabelType.body,
                                  text: 'Full Time',
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
                                text: 'Skills required:',
                                isBold: true,
                                color: primaryColor),
                          ],
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: ScreenUtils.customLabel(
                                labelType: LabelType.body,
                                maxLines: 2,
                                hasEllipsis: true,
                                isItalic: true,
                                text: jobController
                                    .currentCompanyJob.value.skills
                                    .toString()
                                    .replaceAll('[', '')
                                    .replaceAll(']', ''),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        if (jobController
                            .currentCompanyJob.value.requirements.isNotEmpty)
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
                                      text: 'Job requirements:',
                                      isBold: true,
                                      color: primaryColor),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              for (var requirement in jobController
                                  .currentCompanyJob.value.requirements)
                                Row(
                                  children: [
                                    Expanded(
                                      child: ScreenUtils.customLabel(
                                        labelType: LabelType.body,
                                        maxLines: 20,
                                        text: '- $requirement',
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        if (jobController.currentCompanyJob.value
                            .responsibilities.isNotEmpty)
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
                                      text: 'Employee responsibilities:',
                                      isBold: true,
                                      color: primaryColor),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              for (var responsibility in jobController
                                  .currentCompanyJob.value.responsibilities)
                                Row(
                                  children: [
                                    Expanded(
                                      child: ScreenUtils.customLabel(
                                        labelType: LabelType.body,
                                        maxLines: 20,
                                        text: '- $responsibility',
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
                            const Divider(),
                            SizedBox(
                              height: 5.h,
                            ),
                            Column(children: [
                              Row(
                                children: [
                                  ScreenUtils.customLabel(
                                      labelType: LabelType.body,
                                      text: 'Applicants:',
                                      isBold: true,
                                      color: primaryColor),
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              for (var applicant in jobController
                                  .currentCompanyJob.value.applicants)
                                Card(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.h, horizontal: 10.w),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child:
                                                        ScreenUtils.customLabel(
                                                      labelType:
                                                          LabelType.heading2,
                                                      isBold: true,
                                                      maxLines: 2,
                                                      text:
                                                          '${applicant.firstName} ${applicant.lastName} (${applicant.username})',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child:
                                                        ScreenUtils.customLabel(
                                                      labelType:
                                                          LabelType.small,
                                                      maxLines: 1,
                                                      isItalic: true,
                                                      text: applicant.email,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child:
                                                        ScreenUtils.customLabel(
                                                      labelType: LabelType.body,
                                                      maxLines: 2,
                                                      hasEllipsis: true,
                                                      isItalic: true,
                                                      text: applicant
                                                          .professional!.summary
                                                          .toString(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Row(
                                                children: [
                                                  ScreenUtils.customLabel(
                                                    labelType: LabelType.body,
                                                    isBold: true,
                                                    maxLines: 1,
                                                    text: 'Skills',
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child:
                                                        ScreenUtils.customLabel(
                                                      labelType: LabelType.body,
                                                      maxLines: 20,
                                                      text:
                                                          '- ${applicant.professional!.skills.toString().replaceAll('[', '').replaceAll(']', '').replaceAll(', ', '\n- ')}',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (applicant.status == 'New')
                                          Column(
                                            children: [
                                              ScreenUtils.customGestureDetector(
                                                child: ScreenUtils
                                                    .roundedContainer(
                                                        child: ScreenUtils
                                                            .customLabel(
                                                                labelType:
                                                                    LabelType
                                                                        .body,
                                                                text: 'Accept',
                                                                color: Colors
                                                                    .white)),
                                                callbackAction: () async {
                                                  if (await jobController
                                                      .acceptApplication(
                                                          userId:
                                                              applicant.id)) {
                                                    ScreenUtils.showSnackBar(
                                                        msg:
                                                            'Applicant accepted successfully!');
                                                    setState(() {
                                                      applicant.status =
                                                          'Accepted';
                                                    });
                                                  }
                                                },
                                              )
                                            ],
                                          ),
                                        if (applicant.status == 'Accepted')
                                          Column(
                                            children: [
                                              ScreenUtils.roundedContainer(
                                                  isPrimary: false,
                                                  child: Column(
                                                    children: [
                                                      const Icon(
                                                        Icons.done_all,
                                                      ),
                                                      ScreenUtils.customLabel(
                                                          labelType:
                                                              LabelType.body,
                                                          text: 'Accepted',
                                                          color: primaryColor),
                                                    ],
                                                  )),
                                            ],
                                          )
                                      ],
                                    ),
                                  ),
                                ),
                            ])
                          ],
                        ),
                      ],
                    ),
            ),
          ),
        ));
  }
}
