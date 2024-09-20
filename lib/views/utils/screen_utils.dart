import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:roj_gaar_app/controllers/clients/app_controller.dart';
import 'package:roj_gaar_app/controllers/clients/dashboard_controller.dart';
import 'package:roj_gaar_app/controllers/clients/job_controller.dart';
import '../../utils/constants.dart';

class ScreenUtils {
  static Widget roundedContainer(
      {required Widget child,
      bool isPrimary = true,
      bool hasBorder = true,
      double? height,
      double? width,
      double? borderRadius}) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: (height == null) ? 20.w : 0,
          vertical: (width == null) ? 10.h : 0),
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: (isPrimary) ? primaryColor : null,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 20.r)),
          border: Border.all(
              color: (hasBorder) ? primaryColor : Colors.transparent)),
      child: Center(child: child),
    );
  }

  static Widget navBar() {
    DashboardController dashboardController = Get.find<DashboardController>();
    JobController jobController = Get.find<JobController>();
    AppController appController = Get.find<AppController>();

    return Obx(
      () => BottomAppBar(
        shape: (!appController.isUser.value)
            ? const CircularNotchedRectangle()
            : AutomaticNotchedShape(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.r))),
              ),
        notchMargin: 5,
        height: 50.h,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: GestureDetector(
              onLongPress: () async {
                await dashboardController.getCategories();
                await jobController.getRecommendedJobs();
                await jobController.getAvailableJobs();
              },
              onTap: () => dashboardController.navigate(
                page: DashboardPages.dashboard,
              ),
              child: Icon(
                (dashboardController.currentPage.value ==
                        DashboardPages.dashboard)
                    ? Icons.home
                    : Icons.home_outlined,
                color: (dashboardController.currentPage.value ==
                        DashboardPages.dashboard)
                    ? primaryColor
                    : Colors.grey,
                size: 25.h,
              ),
            )),
            if (appController.isUser.value)
              Expanded(
                  child: GestureDetector(
                onTap: () => dashboardController.navigate(
                  page: DashboardPages.search,
                ),
                child: Icon(
                  (dashboardController.currentPage.value ==
                          DashboardPages.search)
                      ? Icons.search
                      : Icons.search_outlined,
                  color: (dashboardController.currentPage.value ==
                          DashboardPages.search)
                      ? primaryColor
                      : Colors.grey,
                  size: 25.h,
                ),
              )),
            if (appController.isUser.value)
              Expanded(
                  child: GestureDetector(
                onTap: () => dashboardController.navigate(
                  page: DashboardPages.categories,
                ),
                child: Icon(
                  (dashboardController.currentPage.value ==
                          DashboardPages.categories)
                      ? Icons.dashboard_sharp
                      : Icons.dashboard_outlined,
                  color: (dashboardController.currentPage.value ==
                          DashboardPages.categories)
                      ? primaryColor
                      : Colors.grey,
                  size: 25.h,
                ),
              )),
            Expanded(
                child: GestureDetector(
              onTap: () => dashboardController.navigate(
                page: DashboardPages.settings,
              ),
              child: Icon(
                (dashboardController.currentPage.value ==
                        DashboardPages.settings)
                    ? Icons.settings
                    : Icons.settings_outlined,
                color: (dashboardController.currentPage.value ==
                        DashboardPages.settings)
                    ? primaryColor
                    : Colors.grey,
                size: 25.h,
              ),
            )),
          ],
        ),
      ),
    );
  }

  static Widget customGestureDetector(
      {required Widget child, required VoidCallback callbackAction}) {
    return GestureDetector(
      onTap: callbackAction,
      child: child,
    );
  }

  static Widget customLabel(
      {required LabelType labelType,
      bool isItalic = false,
      Color color = Colors.black,
      bool isBold = false,
      bool isCenterAligned = false,
      bool hasEllipsis = false,
      int maxLines = 1,
      required String text}) {
    TextStyle textStyle = const TextStyle();
    switch (labelType) {
      case LabelType.title:
        textStyle = TextStyle(
            fontWeight: (isBold) ? FontWeight.w800 : FontWeight.w400,
            fontStyle: (isItalic) ? FontStyle.italic : FontStyle.normal,
            color: color,
            fontSize: 32);
        break;
      case LabelType.heading1:
        textStyle = TextStyle(
            fontWeight: (isBold) ? FontWeight.w800 : FontWeight.w400,
            fontStyle: (isItalic) ? FontStyle.italic : FontStyle.normal,
            color: color,
            fontSize: 26);
        break;
      case LabelType.heading2:
        textStyle = TextStyle(
            fontWeight: (isBold) ? FontWeight.w600 : FontWeight.w400,
            fontStyle: (isItalic) ? FontStyle.italic : FontStyle.normal,
            color: color,
            fontSize: 20);
        break;
      case LabelType.body:
        textStyle = TextStyle(
            fontWeight: (isBold) ? FontWeight.w600 : FontWeight.w400,
            fontStyle: (isItalic) ? FontStyle.italic : FontStyle.normal,
            color: color,
            fontSize: 16);
        break;
      case LabelType.small:
        textStyle = TextStyle(
            fontWeight: (isBold) ? FontWeight.w600 : FontWeight.w400,
            fontStyle: (isItalic) ? FontStyle.italic : FontStyle.normal,
            color: color,
            fontSize: 12);
        break;
      default:
        textStyle = TextStyle(
            fontWeight: (isBold) ? FontWeight.w800 : FontWeight.w400,
            fontStyle: (isItalic) ? FontStyle.italic : FontStyle.normal,
            color: color,
            fontSize: 16);
    }

    return Text(
      text,
      style: textStyle,
      maxLines: maxLines,
      overflow: hasEllipsis ? TextOverflow.ellipsis : null,
      textAlign: (isCenterAligned) ? TextAlign.center : null,
    );
  }

  static userTypeSelection(
      {required List items, required TextEditingController controller}) {
    return Get.bottomSheet(
      Container(
        color: Colors.white,
        height: 0.5.sh,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              customLabel(labelType: LabelType.heading2, text: 'User type:'),
              SizedBox(
                height: 10.h,
              ),
              ListView.separated(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                    title: Text(items[index]),
                    onTap: () {
                      controller.text = items[index];
                      Get.back();
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    indent: 10,
                    endIndent: 10,
                  );
                },
                itemCount: items.length,
              ),
            ],
          ),
        ),
      ),
      enableDrag: false,
    );
  }

  static companySectorBottomList(
      {required List items, required TextEditingController controller}) {
    return Get.bottomSheet(
      Container(
        color: Colors.white,
        height: 0.5.sh,
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              customLabel(
                  labelType: LabelType.heading2, text: 'Company Sector'),
              SizedBox(
                height: 10.h,
              ),
              ListView.separated(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
                    title: Text(items[index]),
                    onTap: () {
                      controller.text = items[index];
                      Get.back();
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    indent: 10,
                    endIndent: 10,
                  );
                },
                itemCount: items.length,
              ),
            ],
          ),
        ),
      ),
      enableDrag: false,
    );
  }

  static showSnackBar({String? msg, bool isShort = false}) {
    Fluttertoast.showToast(
        msg: msg ?? 'Changes saved.',
        toastLength: isShort ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG);
  }
}
