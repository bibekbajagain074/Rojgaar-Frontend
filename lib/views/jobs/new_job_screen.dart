import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roj_gaar_app/controllers/clients/app_controller.dart';
import 'package:roj_gaar_app/controllers/clients/dashboard_controller.dart';
import 'package:roj_gaar_app/controllers/clients/job_controller.dart';
import '../../utils/constants.dart';
import '../utils/screen_utils.dart';

class NewJobScreen extends StatefulWidget {
  const NewJobScreen({super.key});

  @override
  State<NewJobScreen> createState() => _NewJobScreenState();
}

class _NewJobScreenState extends State<NewJobScreen> {
  AppController appController = Get.find<AppController>();
  JobController jobController = Get.find<JobController>();
  DashboardController dashboardController = Get.find<DashboardController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: ScreenUtils.customLabel(
              labelType: LabelType.heading1,
              text: 'New Job Detail',
              isBold: true,
              color: primaryColor),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0.w, vertical: 5.h),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: jobController.newJobTitleController.value,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter valid job title!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Title*',
                            hintText: 'Job title'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ScreenUtils.customGestureDetector(
                        child: TextFormField(
                          controller: jobController.newJobAboutController.value,
                          enabled: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select job category!';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            suffixIcon: Icon(Icons.arrow_drop_down),
                            border: OutlineInputBorder(),
                            labelText: 'Job Category',
                          ),
                        ),
                        callbackAction: () {
                          ScreenUtils.companySectorBottomList(
                            items: dashboardController.categories
                                .map((element) => element.title)
                                .toList(),
                            controller:
                                jobController.newJobAboutController.value,
                          );
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        controller:
                            jobController.newJobDescriptionController.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter valid description!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Description*',
                            hintText: 'Job description'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter valid requirements!';
                          }
                          return null;
                        },
                        controller:
                            jobController.newJobRequirementsController.value,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Employee requirements',
                            labelText: 'Requirements*'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter valid responsibilities!';
                          }
                          return null;
                        },
                        controller: jobController
                            .newJobResponsibilitiesController.value,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Responsibilities*',
                            hintText: 'Job responsibilities'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter valid responsibilities!';
                          }
                          return null;
                        },
                        controller: jobController.newJobSkillsController.value,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Skills*',
                            hintText: 'Employee Skills'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        controller: jobController.newJobSalaryController.value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter valid salary amount!';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Salary',
                            hintText: 'e.g. 105000'),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ScreenUtils.customGestureDetector(
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          enabled: false,
                          controller:
                              jobController.newJobClosedTimeController.value,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Application end date*',
                            hintText: 'In year(s). e.g. 2.3',
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Pick a valid end date!';
                            }
                            return null;
                          },
                        ),
                        callbackAction: () async {
                          DateTime? selectedDate = await selectDate(context);
                          if (selectedDate != null) {
                            jobController
                                    .newJobClosedTimeController.value.text =
                                ("${selectedDate.year}-${selectedDate.month}-${selectedDate.day}");
                          }
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                    ],
                  ),
                ),
                ScreenUtils.customGestureDetector(
                  child: ScreenUtils.roundedContainer(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.save,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        ScreenUtils.customLabel(
                            labelType: LabelType.body,
                            text: 'Add',
                            color: Colors.white)
                      ],
                    ),
                  ),
                  callbackAction: () async {
                    if (_formKey.currentState!.validate()) {
                      if (await jobController.addJob(
                          companyId: appController.appUser.value.company!.id)) {
                        ScreenUtils.showSnackBar(msg: 'New job posted.');

                        await jobController.getCompanyJobs(
                            companyId: appController.appUser.value.company!.id);

                        jobController.newJobTitleController.value.clear();
                        jobController.newJobAboutController.value.clear();
                        jobController.newJobDescriptionController.value.clear();
                        jobController.newJobCategoriesController.value.clear();
                        jobController.newJobSkillsController.value.clear();
                        jobController.newJobResponsibilitiesController.value
                            .clear();
                        jobController.newJobRequirementsController.value
                            .clear();
                        jobController.newJobSalaryController.value.clear();
                        jobController.newJobClosedTimeController.value.clear();

                        Get.back();
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ));
  }

  Future<DateTime?> selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();

    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      return selectedDate;
    }
    return null;
  }
}
