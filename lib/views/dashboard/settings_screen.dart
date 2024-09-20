import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roj_gaar_app/controllers/clients/dashboard_controller.dart';
import 'package:roj_gaar_app/controllers/clients/job_controller.dart';
import 'package:roj_gaar_app/utils/constants.dart';
import 'package:roj_gaar_app/views/utils/screen_utils.dart';
import '../../controllers/clients/app_controller.dart';
import '../profile/manage_jobs_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  AppController appController = Get.find<AppController>();
  DashboardController dashboardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            ScreenUtils.customLabel(
              labelType: LabelType.heading2,
              text: 'Settings',
              isBold: true,
            ),
            SizedBox(
              height: 5.h,
            ),
            Center(
              child: ScreenUtils.customGestureDetector(
                child: Card(
                  shape: const CircleBorder(),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CachedNetworkImage(
                      height: 80.h,
                      imageUrl: appController.appUser.value.avatarUrl,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ),
                callbackAction: () {},
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(
                      () => Icon(
                        (appController.isUser.value)
                            ? Icons.person
                            : Icons.business,
                        color: primaryColor,
                        size: 20,
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    ScreenUtils.customLabel(
                        labelType: LabelType.body,
                        text: 'Account',
                        isBold: true),
                    SizedBox(
                      width: 10.w,
                    ),
                    Obx(
                      () => (appController.appUser.value.isVerified)
                          ? const Icon(
                              Icons.verified,
                              color: primaryColor,
                              size: 20,
                            )
                          : const SizedBox.shrink(),
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () async {
                      await appController.clearCredentials();
                      Get.offAllNamed(login);
                    },
                    icon: const Icon(Icons.logout)),
              ],
            ),
            const Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 10.h,
            ),
            Obx(() => (appController.isUser.value)
                ? employeeProfile()
                : companyProfile()),
            SizedBox(
              height: 40.h,
            ),
            Row(
              children: [
                const Icon(
                  Icons.feed,
                  color: primaryColor,
                  size: 20,
                ),
                SizedBox(
                  width: 10.w,
                ),
                ScreenUtils.customLabel(
                    labelType: LabelType.body,
                    text: 'Job Section',
                    isBold: true)
              ],
            ),
            const Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 10.h,
            ),
            Obx(() =>
                (appController.isUser.value) ? employeeJobs() : companyJobs()),
            SizedBox(
              height: 10.h,
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
                        text: 'Update',
                        color: Colors.white)
                  ],
                ),
              ),
              callbackAction: () async {
                if (await appController.updateProfile()) {
                  ScreenUtils.showSnackBar(msg: 'Profile updated.');
                  await Get.find<JobController>().getRecommendedJobs();
                }
              },
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        ),
      ),
    );
  }

  Widget employeeProfile() {
    return Column(
      children: [
        Obx(
          () => ExpansionPanelList(
            expansionCallback: (int i, bool expand) {
              switch (i) {
                case 0:
                  appController.expandInfo(!appController.expandInfo.value);
                  appController.expandSkills(false);
                  appController.expandExperiences(false);
                  appController.expandAcademic(false);
                  appController.expandChangePassword(false);
                  break;
                case 1:
                  appController.expandInfo(false);
                  appController.expandSkills(!appController.expandSkills.value);
                  appController.expandExperiences(false);
                  appController.expandAcademic(false);
                  appController.expandChangePassword(false);
                  break;
                case 2:
                  //   appController.expandInfo(false);
                  //   appController.expandSkills(false);
                  //   appController.expandExperiences(
                  //       !appController.expandExperiences.value);
                  //   appController.expandAcademic(false);
                  //   appController.expandChangePassword(false);
                  //   break;
                  // case 3:
                  //   appController.expandInfo(false);
                  //   appController.expandSkills(false);
                  //   appController.expandExperiences(false);
                  //   appController
                  //       .expandAcademic(!appController.expandAcademic.value);
                  //   appController.expandChangePassword(false);
                  //   break;

                  // case 4:
                  appController.expandInfo(false);
                  appController.expandSkills(false);
                  appController.expandExperiences(false);
                  appController.expandAcademic(false);
                  appController.expandChangePassword(
                      !appController.expandChangePassword.value);
                  break;
                default:
                  appController.expandInfo(false);
                  appController.expandSkills(false);
                  appController.expandExperiences(false);
                  appController.expandAcademic(false);
                  appController.expandChangePassword(false);
                  break;
              }
            },
            children: [
              // basic info
              ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: ScreenUtils.customLabel(
                              labelType: LabelType.body,
                              isBold: true,
                              text: 'Basic Info'),
                        ),
                      ],
                    );
                  },
                  isExpanded: appController.expandInfo.value,
                  body: Column(
                    children: [
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 1,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          indent: 10,
                          endIndent: 10,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              trailing: ScreenUtils.customGestureDetector(
                                  child: const Icon(Icons.edit),
                                  callbackAction: () {
                                    final _formKey = GlobalKey<FormState>();

                                    TextEditingController username =
                                            TextEditingController(
                                                text: appController
                                                    .appUser.value.username),
                                        firstName = TextEditingController(
                                            text: appController
                                                .appUser.value.firstName),
                                        lastName = TextEditingController(
                                            text: appController
                                                .appUser.value.lastName);
                                    Get.defaultDialog(
                                        title: 'Edit basic info:',
                                        content: SizedBox(
                                          // height: 0.5.sh,
                                          width: 0.8.sw,
                                          child: Form(
                                            key: _formKey,
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  controller: username,
                                                  decoration:
                                                      const InputDecoration(
                                                    label: Text('Username'),
                                                  ),
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please enter your username!';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: TextFormField(
                                                        controller: firstName,
                                                        decoration:
                                                            const InputDecoration(
                                                          label: Text(
                                                              'First Name'),
                                                        ),
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'Please enter your first name!';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Expanded(
                                                      child: TextFormField(
                                                        controller: lastName,
                                                        decoration:
                                                            const InputDecoration(
                                                          label:
                                                              Text('Last Name'),
                                                        ),
                                                        textInputAction:
                                                            TextInputAction
                                                                .done,
                                                        keyboardType:
                                                            TextInputType.text,
                                                        validator: (value) {
                                                          if (value == null ||
                                                              value.isEmpty) {
                                                            return 'Please enter your last name!';
                                                          }
                                                          return null;
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ScreenUtils
                                                        .customGestureDetector(
                                                      child: ScreenUtils.roundedContainer(
                                                          child: ScreenUtils
                                                              .customLabel(
                                                                  labelType:
                                                                      LabelType
                                                                          .body,
                                                                  text:
                                                                      'Cancel'),
                                                          isPrimary: false),
                                                      callbackAction: () =>
                                                          Get.back(),
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    ScreenUtils
                                                        .customGestureDetector(
                                                      child: ScreenUtils
                                                          .roundedContainer(
                                                        child: ScreenUtils
                                                            .customLabel(
                                                                labelType:
                                                                    LabelType
                                                                        .body,
                                                                text: 'Confirm',
                                                                color: Colors
                                                                    .white),
                                                      ),
                                                      callbackAction: () {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          appController
                                                                  .appUser
                                                                  .value
                                                                  .username =
                                                              username.text;
                                                          appController
                                                                  .appUser
                                                                  .value
                                                                  .firstName =
                                                              firstName.text;
                                                          appController
                                                                  .appUser
                                                                  .value
                                                                  .lastName =
                                                              lastName.text;

                                                          appController.appUser
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
                                  }),
                              title: ScreenUtils.customLabel(
                                  labelType: LabelType.body,
                                  text:
                                      '${appController.appUser.value.firstName} ${appController.appUser.value.lastName} (${appController.appUser.value.username})'),
                              subtitle: ScreenUtils.customLabel(
                                labelType: LabelType.small,
                                isItalic: true,
                                text: appController.appUser.value.email,
                              ));
                        },
                      )
                    ],
                  )),

              // professional skills
              ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: ScreenUtils.customLabel(
                              labelType: LabelType.body,
                              isBold: true,
                              text: 'Professional Skills'),
                        ),
                      ],
                    );
                  },
                  isExpanded: appController.expandSkills.value,
                  body: Column(
                    children: [
                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 1,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          indent: 10,
                          endIndent: 10,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              trailing: ScreenUtils.customGestureDetector(
                                  child: const Icon(Icons.edit),
                                  callbackAction: () {
                                    final _formKey = GlobalKey<FormState>();

                                    TextEditingController title =
                                            TextEditingController(
                                                text: appController.appUser
                                                    .value.skills!.title),
                                        sector = TextEditingController(
                                            text: appController
                                                .appUser.value.skills!.sector),
                                        summary = TextEditingController(
                                            text: appController
                                                .appUser.value.skills!.summary);
                                    Get.defaultDialog(
                                        title: 'Edit professional info:',
                                        content: SizedBox(
                                          height: 0.3.sh,
                                          width: 0.8.sw,
                                          child: SingleChildScrollView(
                                            child: Form(
                                              key: _formKey,
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller: title,
                                                    decoration:
                                                        const InputDecoration(
                                                      label: Text('Title'),
                                                    ),
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter your professional title!';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 10.h,
                                                  ),
                                                  TextFormField(
                                                    controller: sector,
                                                    decoration:
                                                        const InputDecoration(
                                                      label: Text(
                                                          'Professional Sector'),
                                                    ),
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter your professional sector!';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                  SizedBox(height: 10.h),
                                                  TextFormField(
                                                    controller: summary,
                                                    decoration:
                                                        const InputDecoration(
                                                      label: Text(
                                                          'Professional Summary'),
                                                    ),
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter your summary!';
                                                      }
                                                      return null;
                                                    },
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
                                                            child: ScreenUtils
                                                                .customLabel(
                                                                    labelType:
                                                                        LabelType
                                                                            .body,
                                                                    text:
                                                                        'Cancel'),
                                                            isPrimary: false),
                                                        callbackAction: () =>
                                                            Get.back(),
                                                      ),
                                                      SizedBox(
                                                        width: 10.w,
                                                      ),
                                                      ScreenUtils
                                                          .customGestureDetector(
                                                        child: ScreenUtils
                                                            .roundedContainer(
                                                          child: ScreenUtils
                                                              .customLabel(
                                                                  labelType:
                                                                      LabelType
                                                                          .body,
                                                                  text:
                                                                      'Confirm',
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        callbackAction: () {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            appController
                                                                    .appUser
                                                                    .value
                                                                    .skills!
                                                                    .title =
                                                                title.text;
                                                            appController
                                                                    .appUser
                                                                    .value
                                                                    .skills!
                                                                    .sector =
                                                                sector.text;
                                                            appController
                                                                    .appUser
                                                                    .value
                                                                    .skills!
                                                                    .summary =
                                                                summary.text;

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
                                          ),
                                        ));
                                  }),
                              title: ScreenUtils.customLabel(
                                  labelType: LabelType.body,
                                  text: appController
                                      .appUser.value.skills!.title),
                              subtitle: ScreenUtils.customLabel(
                                labelType: LabelType.small,
                                maxLines: 2,
                                text:
                                    'Professional Sector: ${appController.appUser.value.skills!.sector}\n${appController.appUser.value.skills!.summary}',
                              ));
                        },
                      ),

                      ListTile(
                        title: ScreenUtils.customLabel(
                            labelType: LabelType.body,
                            isBold: true,
                            text: 'Skills:'),
                      ),

                      ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            appController.appUser.value.skills!.skills.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(
                          indent: 10,
                          endIndent: 10,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            trailing: ScreenUtils.customGestureDetector(
                                child: const Icon(Icons.delete),
                                callbackAction: () {
                                  Get.defaultDialog(
                                      title:
                                          'Are you sure you want to delete this skill?',
                                      content: SizedBox(
                                        // height: 0.3.sh,
                                        width: 0.8.sw,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ScreenUtils.customGestureDetector(
                                              child:
                                                  ScreenUtils.roundedContainer(
                                                      child: ScreenUtils
                                                          .customLabel(
                                                              labelType:
                                                                  LabelType
                                                                      .body,
                                                              text: 'No'),
                                                      isPrimary: false),
                                              callbackAction: () => Get.back(),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            ScreenUtils.customGestureDetector(
                                              child:
                                                  ScreenUtils.roundedContainer(
                                                child: ScreenUtils.customLabel(
                                                    labelType: LabelType.body,
                                                    text: 'Yes',
                                                    color: Colors.white),
                                              ),
                                              callbackAction: () {
                                                appController.appUser.value
                                                    .skills!.skills
                                                    .remove(appController
                                                        .appUser
                                                        .value
                                                        .skills!
                                                        .skills[index]);
                                                appController.appUser.refresh();
                                                Get.back();
                                                ScreenUtils.showSnackBar();
                                              },
                                            ),
                                          ],
                                        ),
                                      ));
                                }),
                            title: GestureDetector(
                              onLongPress: () {
                                final _formKey = GlobalKey<FormState>();

                                String temp = appController
                                    .appUser.value.skills!.skills[index];
                                appController.editValue.value.text = temp;
                                Get.defaultDialog(
                                    title: 'Edit skill:',
                                    content: SizedBox(
                                      // height: 0.5.sh,
                                      width: 0.8.sw,
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller:
                                                  appController.editValue.value,
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter a valid skill!';
                                                }
                                                return null;
                                              },
                                              decoration: const InputDecoration(
                                                label: Text('Skill'),
                                              ),
                                              textInputAction:
                                                  TextInputAction.done,
                                              keyboardType: TextInputType.text,
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ScreenUtils
                                                    .customGestureDetector(
                                                  child: ScreenUtils
                                                      .roundedContainer(
                                                          child: ScreenUtils
                                                              .customLabel(
                                                                  labelType:
                                                                      LabelType
                                                                          .body,
                                                                  text:
                                                                      'Cancel'),
                                                          isPrimary: false),
                                                  callbackAction: () =>
                                                      Get.back(),
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                ScreenUtils
                                                    .customGestureDetector(
                                                  child: ScreenUtils
                                                      .roundedContainer(
                                                    child:
                                                        ScreenUtils.customLabel(
                                                            labelType:
                                                                LabelType.body,
                                                            text: 'Confirm',
                                                            color:
                                                                Colors.white),
                                                  ),
                                                  callbackAction: () {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      appController
                                                                  .appUser
                                                                  .value
                                                                  .skills!
                                                                  .skills[
                                                              appController
                                                                  .appUser
                                                                  .value
                                                                  .skills!
                                                                  .skills
                                                                  .indexOf(
                                                                      temp)] =
                                                          appController
                                                              .editValue
                                                              .value
                                                              .text;
                                                      appController
                                                          .editValue.value
                                                          .clear();
                                                      appController.appUser
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
                              child: ScreenUtils.customLabel(
                                  labelType: LabelType.body,
                                  text: appController
                                      .appUser.value.skills!.skills[index]),
                            ),
                          );
                        },
                      ),

                      // add skills
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ScreenUtils.customGestureDetector(
                            child: ScreenUtils.roundedContainer(
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ),
                            callbackAction: () {
                              final _formKey = GlobalKey<FormState>();

                              Get.defaultDialog(
                                  title: 'Add new skill:',
                                  content: SizedBox(
                                    width: 0.8.sw,
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          TextFormField(
                                            controller:
                                                appController.editValue.value,
                                            decoration: const InputDecoration(
                                              label: Text('Skill'),
                                            ),
                                            textInputAction:
                                                TextInputAction.done,
                                            keyboardType: TextInputType.text,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter a valid skill!';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              ScreenUtils.customGestureDetector(
                                                child: ScreenUtils
                                                    .roundedContainer(
                                                        child: ScreenUtils
                                                            .customLabel(
                                                                labelType:
                                                                    LabelType
                                                                        .body,
                                                                text: 'Cancel'),
                                                        isPrimary: false),
                                                callbackAction: () =>
                                                    Get.back(),
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              ScreenUtils.customGestureDetector(
                                                child: ScreenUtils
                                                    .roundedContainer(
                                                  child:
                                                      ScreenUtils.customLabel(
                                                          labelType:
                                                              LabelType.body,
                                                          text: 'Confirm',
                                                          color: Colors.white),
                                                ),
                                                callbackAction: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    appController.appUser.value
                                                        .skills!.skills
                                                        .add(appController
                                                            .editValue
                                                            .value
                                                            .text);
                                                    appController
                                                        .editValue.value
                                                        .clear();
                                                    appController.appUser
                                                        .refresh();
                                                    Get.back();
                                                    ScreenUtils.showSnackBar();
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
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      )
                    ],
                  )),

              // experiences
              // ExpansionPanel(
              //     headerBuilder: (context, isExpanded) {
              //       return Row(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //             child: ScreenUtils.customLabel(
              //                 labelType: LabelType.body,
              //                 isBold: true,
              //                 text: 'Past Experiences'),
              //           ),
              //         ],
              //       );
              //     },
              //     isExpanded: appController.expandExperiences.value,
              //     body: Column(
              //       children: [
              //         ListView.separated(
              //           physics: const NeverScrollableScrollPhysics(),
              //           shrinkWrap: true,
              //           itemCount:
              //               appController.appUser.value.experience.length,
              //           separatorBuilder: (BuildContext context, int index) =>
              //               const Divider(
              //             indent: 10,
              //             endIndent: 10,
              //           ),
              //           itemBuilder: (BuildContext context, int index) {
              //             return GestureDetector(
              //               onLongPress: () {
              //                 String temp =
              //                     appController.appUser.value.experience[index];
              //                 appController.editValue.value.text = temp;
              //                 Get.defaultDialog(
              //                     title: 'Edit past experience:',
              //                     content: SizedBox(
              //                       // height: 0.5.sh,
              //                       width: 0.8.sw,
              //                       child: Column(
              //                         children: [
              //                           TextFormField(
              //                             controller:
              //                                 appController.editValue.value,
              //                             decoration: const InputDecoration(
              //                               label: Text('Experience'),
              //                             ),
              //                             textInputAction: TextInputAction.done,
              //                             keyboardType: TextInputType.text,
              //                           ),
              //                           SizedBox(
              //                             height: 10.h,
              //                           ),
              //                           Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.center,
              //                             children: [
              //                               ScreenUtils.customGestureDetector(
              //                                 child:
              //                                     ScreenUtils.roundedContainer(
              //                                         child: ScreenUtils
              //                                             .customLabel(
              //                                                 labelType:
              //                                                     LabelType
              //                                                         .body,
              //                                                 text: 'Cancel'),
              //                                         isPrimary: false),
              //                                 callbackAction: () => Get.back(),
              //                               ),
              //                               SizedBox(
              //                                 width: 10.w,
              //                               ),
              //                               ScreenUtils.customGestureDetector(
              //                                 child:
              //                                     ScreenUtils.roundedContainer(
              //                                   child: ScreenUtils.customLabel(
              //                                       labelType: LabelType.body,
              //                                       text: 'Confirm',
              //                                       color: Colors.white),
              //                                 ),
              //                                 callbackAction: () {
              //                                   if (appController
              //                                       .editValue.value.text
              //                                       .trim()
              //                                       .isEmpty) {
              //                                     Get.back();
              //                                   } else {
              //                                     appController.appUser.value
              //                                                 .experience[
              //                                             appController.appUser
              //                                                 .value.experience
              //                                                 .indexOf(temp)] =
              //                                         appController
              //                                             .editValue.value.text;
              //                                     appController.editValue.value
              //                                         .clear();
              //                                     appController.appUser
              //                                         .refresh();
              //                                     Get.back();
              //                                     ScreenUtils.showSnackBar();
              //                                   }
              //                                 },
              //                               ),
              //                             ],
              //                           ),
              //                         ],
              //                       ),
              //                     ));
              //               },
              //               child: ListTile(
              //                 trailing: ScreenUtils.customGestureDetector(
              //                     child: const Icon(Icons.delete),
              //                     callbackAction: () {
              //                       Get.defaultDialog(
              //                           title:
              //                               'Are you sure you want to delete this experiences?',
              //                           content: SizedBox(
              //                             width: 0.8.sw,
              //                             child: Row(
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.center,
              //                               children: [
              //                                 ScreenUtils.customGestureDetector(
              //                                   child: ScreenUtils
              //                                       .roundedContainer(
              //                                           child: ScreenUtils
              //                                               .customLabel(
              //                                                   labelType:
              //                                                       LabelType
              //                                                           .body,
              //                                                   text: 'No'),
              //                                           isPrimary: false),
              //                                   callbackAction: () =>
              //                                       Get.back(),
              //                                 ),
              //                                 SizedBox(
              //                                   width: 10.w,
              //                                 ),
              //                                 ScreenUtils.customGestureDetector(
              //                                   child: ScreenUtils
              //                                       .roundedContainer(
              //                                     child:
              //                                         ScreenUtils.customLabel(
              //                                             labelType:
              //                                                 LabelType.body,
              //                                             text: 'Yes',
              //                                             color: Colors.white),
              //                                   ),
              //                                   callbackAction: () {
              //                                     appController
              //                                         .appUser.value.experience
              //                                         .remove(appController
              //                                             .appUser
              //                                             .value
              //                                             .experience[index]);
              //                                     appController.appUser
              //                                         .refresh();
              //                                     Get.back();
              //                                     ScreenUtils.showSnackBar();
              //                                   },
              //                                 ),
              //                               ],
              //                             ),
              //                           ));
              //                     }),
              //                 title: ScreenUtils.customLabel(
              //                     labelType: LabelType.body,
              //                     text: appController
              //                         .appUser.value.experience[index]),
              //               ),
              //             );
              //           },
              //         ),
              //         // add experience
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             ScreenUtils.customGestureDetector(
              //               child: ScreenUtils.roundedContainer(
              //                 child: const Icon(
              //                   Icons.add,
              //                   color: Colors.white,
              //                 ),
              //               ),
              //               callbackAction: () => Get.defaultDialog(
              //                   title: 'Add past experience:',
              //                   content: SizedBox(
              //                     // height: 0.5.sh,
              //                     width: 0.8.sw,
              //                     child: Column(
              //                       children: [
              //                         TextFormField(
              //                           controller:
              //                               appController.editValue.value,
              //                           decoration: const InputDecoration(
              //                             label: Text('Company'),
              //                           ),
              //                           textInputAction: TextInputAction.done,
              //                           keyboardType: TextInputType.text,
              //                         ),
              //                         SizedBox(
              //                           height: 10.h,
              //                         ),
              //                         Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.center,
              //                           children: [
              //                             ScreenUtils.customGestureDetector(
              //                               child: ScreenUtils.roundedContainer(
              //                                   child: ScreenUtils.customLabel(
              //                                       labelType: LabelType.body,
              //                                       text: 'Cancel'),
              //                                   isPrimary: false),
              //                               callbackAction: () => Get.back(),
              //                             ),
              //                             SizedBox(
              //                               width: 10.w,
              //                             ),
              //                             ScreenUtils.customGestureDetector(
              //                               child: ScreenUtils.roundedContainer(
              //                                 child: ScreenUtils.customLabel(
              //                                     labelType: LabelType.body,
              //                                     text: 'Confirm',
              //                                     color: Colors.white),
              //                               ),
              //                               callbackAction: () {
              //                                 if (appController
              //                                     .editValue.value.text
              //                                     .trim()
              //                                     .isEmpty) {
              //                                   ScreenUtils.showSnackBar(
              //                                       msg:
              //                                           'Cannot add empty company!');
              //                                   Get.back();
              //                                 } else {
              //                                   appController
              //                                       .appUser.value.experience
              //                                       .add(appController
              //                                           .editValue.value.text);
              //                                   appController.editValue.value
              //                                       .clear();
              //                                   appController.appUser.refresh();
              //                                   Get.back();
              //                                   ScreenUtils.showSnackBar();
              //                                 }
              //                               },
              //                             ),
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                   )),
              //             ),
              //           ],
              //         ),
              //
              //         SizedBox(
              //           height: 10.h,
              //         )
              //       ],
              //     )),

              // education
              // ExpansionPanel(
              //     headerBuilder: (context, isExpanded) {
              //       return Row(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //             child: ScreenUtils.customLabel(
              //                 labelType: LabelType.body,
              //                 isBold: true,
              //                 text: 'Education'),
              //           ),
              //         ],
              //       );
              //     },
              //     isExpanded: appController.expandAcademic.value,
              //     body: Column(
              //       children: [
              //         ListView.separated(
              //           physics: const NeverScrollableScrollPhysics(),
              //           shrinkWrap: true,
              //           itemCount: appController.appUser.value.education.length,
              //           separatorBuilder: (BuildContext context, int index) =>
              //               const Divider(
              //             indent: 10,
              //             endIndent: 10,
              //           ),
              //           itemBuilder: (BuildContext context, int index) {
              //             return GestureDetector(
              //               onLongPress: () {
              //                 String temp =
              //                     appController.appUser.value.education[index];
              //                 appController.editValue.value.text = temp;
              //                 Get.defaultDialog(
              //                     title: 'Edit academic past:',
              //                     content: SizedBox(
              //                       // height: 0.5.sh,
              //                       width: 0.8.sw,
              //                       child: Column(
              //                         children: [
              //                           TextFormField(
              //                             controller:
              //                                 appController.editValue.value,
              //                             decoration: const InputDecoration(
              //                               label: Text(
              //                                   'School/College/University'),
              //                             ),
              //                             textInputAction: TextInputAction.done,
              //                             keyboardType: TextInputType.text,
              //                           ),
              //                           SizedBox(
              //                             height: 10.h,
              //                           ),
              //                           Row(
              //                             mainAxisAlignment:
              //                                 MainAxisAlignment.center,
              //                             children: [
              //                               ScreenUtils.customGestureDetector(
              //                                 child:
              //                                     ScreenUtils.roundedContainer(
              //                                         child: ScreenUtils
              //                                             .customLabel(
              //                                                 labelType:
              //                                                     LabelType
              //                                                         .body,
              //                                                 text: 'Cancel'),
              //                                         isPrimary: false),
              //                                 callbackAction: () => Get.back(),
              //                               ),
              //                               SizedBox(
              //                                 width: 10.w,
              //                               ),
              //                               ScreenUtils.customGestureDetector(
              //                                 child:
              //                                     ScreenUtils.roundedContainer(
              //                                   child: ScreenUtils.customLabel(
              //                                       labelType: LabelType.body,
              //                                       text: 'Confirm',
              //                                       color: Colors.white),
              //                                 ),
              //                                 callbackAction: () {
              //                                   if (appController
              //                                       .editValue.value.text
              //                                       .trim()
              //                                       .isEmpty) {
              //                                     Get.back();
              //                                   } else {
              //                                     appController.appUser.value
              //                                                 .education[
              //                                             appController.appUser
              //                                                 .value.education
              //                                                 .indexOf(temp)] =
              //                                         appController
              //                                             .editValue.value.text;
              //                                     appController.editValue.value
              //                                         .clear();
              //                                     appController.appUser
              //                                         .refresh();
              //                                     Get.back();
              //                                     ScreenUtils.showSnackBar();
              //                                   }
              //                                 },
              //                               ),
              //                             ],
              //                           ),
              //                         ],
              //                       ),
              //                     ));
              //               },
              //               child: ListTile(
              //                 trailing: ScreenUtils.customGestureDetector(
              //                     child: const Icon(Icons.delete),
              //                     callbackAction: () {
              //                       Get.defaultDialog(
              //                           title:
              //                               'Are you sure you want to delete this institution?',
              //                           content: SizedBox(
              //                             width: 0.8.sw,
              //                             child: Row(
              //                               mainAxisAlignment:
              //                                   MainAxisAlignment.center,
              //                               children: [
              //                                 ScreenUtils.customGestureDetector(
              //                                   child: ScreenUtils
              //                                       .roundedContainer(
              //                                           child: ScreenUtils
              //                                               .customLabel(
              //                                                   labelType:
              //                                                       LabelType
              //                                                           .body,
              //                                                   text: 'No'),
              //                                           isPrimary: false),
              //                                   callbackAction: () =>
              //                                       Get.back(),
              //                                 ),
              //                                 SizedBox(
              //                                   width: 10.w,
              //                                 ),
              //                                 ScreenUtils.customGestureDetector(
              //                                   child: ScreenUtils
              //                                       .roundedContainer(
              //                                     child:
              //                                         ScreenUtils.customLabel(
              //                                             labelType:
              //                                                 LabelType.body,
              //                                             text: 'Yes',
              //                                             color: Colors.white),
              //                                   ),
              //                                   callbackAction: () {
              //                                     appController
              //                                         .appUser.value.education
              //                                         .remove(appController
              //                                             .appUser
              //                                             .value
              //                                             .education[index]);
              //                                     appController.appUser
              //                                         .refresh();
              //                                     Get.back();
              //                                     ScreenUtils.showSnackBar();
              //                                   },
              //                                 ),
              //                               ],
              //                             ),
              //                           ));
              //                     }),
              //                 title: ScreenUtils.customLabel(
              //                     labelType: LabelType.body,
              //                     text: appController
              //                         .appUser.value.education[index]),
              //               ),
              //             );
              //           },
              //         ),
              //
              //         // add education
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             ScreenUtils.customGestureDetector(
              //               child: ScreenUtils.roundedContainer(
              //                 child: const Icon(
              //                   Icons.add,
              //                   color: Colors.white,
              //                 ),
              //               ),
              //               callbackAction: () => Get.defaultDialog(
              //                   title: 'Add institution:',
              //                   content: SizedBox(
              //                     // height: 0.5.sh,
              //                     width: 0.8.sw,
              //                     child: Column(
              //                       children: [
              //                         TextFormField(
              //                           controller:
              //                               appController.editValue.value,
              //                           decoration: const InputDecoration(
              //                             label: Text('Institution'),
              //                           ),
              //                           textInputAction: TextInputAction.done,
              //                           keyboardType: TextInputType.text,
              //                         ),
              //                         SizedBox(
              //                           height: 10.h,
              //                         ),
              //                         Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.center,
              //                           children: [
              //                             ScreenUtils.customGestureDetector(
              //                               child: ScreenUtils.roundedContainer(
              //                                   child: ScreenUtils.customLabel(
              //                                       labelType: LabelType.body,
              //                                       text: 'Cancel'),
              //                                   isPrimary: false),
              //                               callbackAction: () => Get.back(),
              //                             ),
              //                             SizedBox(
              //                               width: 10.w,
              //                             ),
              //                             ScreenUtils.customGestureDetector(
              //                               child: ScreenUtils.roundedContainer(
              //                                 child: ScreenUtils.customLabel(
              //                                     labelType: LabelType.body,
              //                                     text: 'Confirm',
              //                                     color: Colors.white),
              //                               ),
              //                               callbackAction: () {
              //                                 if (appController
              //                                     .editValue.value.text
              //                                     .trim()
              //                                     .isEmpty) {
              //                                   ScreenUtils.showSnackBar(
              //                                       msg:
              //                                           'Cannot add empty company!');
              //                                   Get.back();
              //                                 } else {
              //                                   appController
              //                                       .appUser.value.education
              //                                       .add(appController
              //                                           .editValue.value.text);
              //                                   appController.editValue.value
              //                                       .clear();
              //                                   appController.appUser.refresh();
              //                                   Get.back();
              //                                   ScreenUtils.showSnackBar();
              //                                 }
              //                               },
              //                             ),
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                   )),
              //             )
              //           ],
              //         ),
              //         SizedBox(
              //           height: 10.h,
              //         ),
              //       ],
              //     )),
              changePassword()
            ],
          ),
        ),
      ],
    );
  }

  ExpansionPanel changePassword() {
    final _formKey = GlobalKey<FormState>();

    // change password
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ScreenUtils.customLabel(
                  labelType: LabelType.body,
                  isBold: true,
                  text: 'Change Password'),
            ),
          ],
        );
      },
      isExpanded: appController.expandChangePassword.value,
      body: Obx(
        () => Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  obscureText: !appController.passwordVisible.value,
                  controller: appController.passwordController.value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your old password!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Old Password',
                      suffixIcon: IconButton(
                          onPressed: () => appController.passwordVisible(
                              !appController.passwordVisible.value),
                          icon: Icon(appController.passwordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off))),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  obscureText: !appController.newPasswordVisible.value,
                  controller: appController.newPasswordController.value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your new password!';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'New Password',
                      suffixIcon: IconButton(
                          onPressed: () => appController.newPasswordVisible(
                              !appController.newPasswordVisible.value),
                          icon: Icon(appController.newPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off))),
                ),
                SizedBox(
                  height: 10.h,
                ),
                TextFormField(
                  obscureText: !appController.newPasswordVerifyVisible.value,
                  controller: appController.newPasswordVerifyController.value,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please verify your new password!';
                    } else if (value !=
                        appController.newPasswordController.value.text) {
                      return "Passwords didn't match!";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Verify New Password',
                      suffixIcon: IconButton(
                          onPressed: () => appController
                              .newPasswordVerifyVisible(!appController
                                  .newPasswordVerifyVisible.value),
                          icon: Icon(
                              appController.newPasswordVerifyVisible.value
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: ScreenUtils.customGestureDetector(
                    child: ScreenUtils.roundedContainer(
                        child: ScreenUtils.customLabel(
                            labelType: LabelType.body,
                            text: 'Confirm',
                            color: Colors.white)),
                    callbackAction: () async {
                      if (_formKey.currentState!.validate()) {
                        await appController.changePassword(
                            oldPassword:
                                appController.passwordController.value.text,
                            newPassword:
                                appController.newPasswordController.value.text);
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget companyProfile() {
    return Obx(
      () => ExpansionPanelList(
        expansionCallback: (int i, bool expand) {
          debugPrint(i.toString());
          switch (i) {
            case 0:
              appController.expandInfo(!appController.expandInfo.value);
              appController.expandSkills(false);
              appController.expandExperiences(false);
              appController.expandAcademic(false);
              appController.expandChangePassword(false);
              break;
            case 1:
              appController.expandInfo(false);
              appController.expandSkills(false);
              appController.expandExperiences(false);
              appController.expandAcademic(false);
              appController.expandChangePassword(
                  !appController.expandChangePassword.value);
              break;
            default:
              appController.expandInfo(false);
              appController.expandSkills(false);
              appController.expandExperiences(false);
              appController.expandAcademic(false);
              appController.expandChangePassword(false);
              break;
          }
        },
        children: [
          ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ScreenUtils.customLabel(
                        labelType: LabelType.body,
                        isBold: true,
                        text: 'Basic Info'),
                  ),
                ],
              );
            },
            isExpanded: appController.expandInfo.value,
            body: Column(
              children: [
                // company basic info
                ListTile(
                    trailing: ScreenUtils.customGestureDetector(
                        child: const Icon(Icons.edit),
                        callbackAction: () {
                          final _formKey = GlobalKey<FormState>();

                          TextEditingController companyName =
                                  TextEditingController(
                                      text: appController
                                          .appUser.value.company!.name),
                              username = TextEditingController(
                                  text: appController.appUser.value.username),
                              country = TextEditingController(
                                  text: appController
                                      .appUser.value.company!.country),
                              region = TextEditingController(
                                  text: appController
                                      .appUser.value.company!.region),
                              phone = TextEditingController(
                                  text: appController
                                      .appUser.value.company!.phone);
                          Get.defaultDialog(
                              title: 'Edit basic info:',
                              titlePadding: EdgeInsets.only(top: 20.h),
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 20.w),
                              content: SizedBox(
                                height: 0.3.sh,
                                child: SingleChildScrollView(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          controller: username,
                                          decoration: const InputDecoration(
                                            label: Text('Username'),
                                          ),
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your username!';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        TextFormField(
                                          controller: companyName,
                                          decoration: const InputDecoration(
                                            label: Text('Company Name'),
                                          ),
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your company name!';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        TextFormField(
                                          controller: country,
                                          decoration: const InputDecoration(
                                            label: Text('Country'),
                                          ),
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your country of operation!';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        TextFormField(
                                          controller: region,
                                          decoration: const InputDecoration(
                                            label: Text('Region'),
                                          ),
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your region of operation!';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        TextFormField(
                                          controller: phone,
                                          decoration: const InputDecoration(
                                            label: Text('Contact number'),
                                          ),
                                          maxLength: 10,
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your company phone number!';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ScreenUtils.customGestureDetector(
                                              child:
                                                  ScreenUtils.roundedContainer(
                                                      child: ScreenUtils
                                                          .customLabel(
                                                              labelType:
                                                                  LabelType
                                                                      .body,
                                                              text: 'Cancel'),
                                                      isPrimary: false),
                                              callbackAction: () => Get.back(),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            ScreenUtils.customGestureDetector(
                                              child:
                                                  ScreenUtils.roundedContainer(
                                                child: ScreenUtils.customLabel(
                                                    labelType: LabelType.body,
                                                    text: 'Confirm',
                                                    color: Colors.white),
                                              ),
                                              callbackAction: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  appController
                                                      .appUser
                                                      .value
                                                      .company!
                                                      .name = companyName.text;
                                                  appController.appUser.value
                                                      .username = username.text;
                                                  appController
                                                      .appUser
                                                      .value
                                                      .company!
                                                      .country = country.text;
                                                  appController
                                                      .appUser
                                                      .value
                                                      .company!
                                                      .region = region.text;
                                                  appController
                                                      .appUser
                                                      .value
                                                      .company!
                                                      .phone = phone.text;

                                                  appController.appUser
                                                      .refresh();
                                                  Get.back();
                                                  ScreenUtils.showSnackBar();
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        }),
                    title: ScreenUtils.customLabel(
                        labelType: LabelType.body,
                        text:
                            '${appController.appUser.value.company!.name} (${appController.appUser.value.username})'),
                    subtitle: ScreenUtils.customLabel(
                      labelType: LabelType.small,
                      isItalic: true,
                      maxLines: 3,
                      text:
                          '${appController.appUser.value.email}\n${appController.appUser.value.company!.region}, ${appController.appUser.value.company!.country}\n${appController.appUser.value.company!.phone}',
                    )),
                // company sector
                ListTile(
                    trailing: ScreenUtils.customGestureDetector(
                        child: const Icon(Icons.edit),
                        callbackAction: () {
                          final _formKey = GlobalKey<FormState>();

                          TextEditingController description =
                                  TextEditingController(
                                      text: appController
                                          .appUser.value.company!.desc),
                              sector = TextEditingController(
                                  text: appController
                                      .appUser.value.company!.sector);
                          Get.defaultDialog(
                              title: 'Edit sector info:',
                              content: SizedBox(
                                height: 0.3.sh,
                                width: 0.8.sw,
                                child: SingleChildScrollView(
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        ScreenUtils.customGestureDetector(
                                          child: TextFormField(
                                            controller: sector,
                                            enabled: false,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please enter company sector!';
                                              }
                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                              suffixIcon:
                                                  Icon(Icons.arrow_drop_down),
                                              border: OutlineInputBorder(),
                                              labelText: 'Company Sector',
                                            ),
                                          ),
                                          callbackAction: () {
                                            ScreenUtils.companySectorBottomList(
                                              items: dashboardController
                                                  .categories
                                                  .map((element) =>
                                                      element.title)
                                                  .toList(),
                                              controller: sector,
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        TextFormField(
                                          controller: description,
                                          decoration: const InputDecoration(
                                            label: Text('Description'),
                                          ),
                                          maxLength: 50,
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.text,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter company description!';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ScreenUtils.customGestureDetector(
                                              child:
                                                  ScreenUtils.roundedContainer(
                                                      child: ScreenUtils
                                                          .customLabel(
                                                              labelType:
                                                                  LabelType
                                                                      .body,
                                                              text: 'Cancel'),
                                                      isPrimary: false),
                                              callbackAction: () => Get.back(),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            ScreenUtils.customGestureDetector(
                                              child:
                                                  ScreenUtils.roundedContainer(
                                                child: ScreenUtils.customLabel(
                                                    labelType: LabelType.body,
                                                    text: 'Confirm',
                                                    color: Colors.white),
                                              ),
                                              callbackAction: () {
                                                if (_formKey.currentState!
                                                    .validate()) {
                                                  appController
                                                      .appUser
                                                      .value
                                                      .company!
                                                      .desc = description.text;
                                                  appController
                                                      .appUser
                                                      .value
                                                      .company!
                                                      .sector = sector.text;
                                                  appController.appUser.value
                                                      .username = sector.text;

                                                  appController.appUser
                                                      .refresh();
                                                  Get.back();
                                                  ScreenUtils.showSnackBar();
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        }),
                    title: ScreenUtils.customLabel(
                        labelType: LabelType.body,
                        text: appController.appUser.value.company!.sector),
                    subtitle: ScreenUtils.customLabel(
                      labelType: LabelType.small,
                      isItalic: true,
                      text: appController.appUser.value.company!.desc,
                    )),
              ],
            ),
          ),
          changePassword()
        ],
      ),
    );
  }

  Widget employeeJobs() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ScreenUtils.customLabel(
                  labelType: LabelType.body, text: 'Applied Jobs'),
            ),
            IconButton(
                onPressed: () =>
                    Get.to(() => ManageJobScreen(isPending: false)),
                icon: const Icon(Icons.arrow_forward_ios))
          ],
        ),
      ],
    );
  }

  Widget companyJobs() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ScreenUtils.customLabel(
                  labelType: LabelType.body, text: 'All Applications'),
            ),
            IconButton(
                onPressed: () {
                  Get.to(() => ManageJobScreen(
                        isPending: false,
                      ));
                },
                icon: const Icon(Icons.arrow_forward_ios))
          ],
        ),
      ],
    );
  }
}
