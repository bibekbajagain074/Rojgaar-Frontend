import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:roj_gaar_app/models/category_model.dart';
import 'package:roj_gaar_app/views/profile/category_detail_screen.dart';

import '../../controllers/clients/app_controller.dart';
import '../../controllers/clients/dashboard_controller.dart';
import '../../utils/api_endpoints.dart';
import '../../utils/constants.dart';
import '../utils/screen_utils.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  AppController appController = Get.find<AppController>();
  DashboardController dashboardController = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => dashboardController.getCategories(),
      child: Obx(
        () => (dashboardController.categoryLoading.value)
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ScreenUtils.customLabel(
                            labelType: LabelType.heading2,
                            text: 'Categories',
                            isBold: true,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      ScreenUtils.customLabel(
                          labelType: LabelType.body,
                          text: 'Choose your preferred category'),
                      SizedBox(
                        height: 20.h,
                      ),

                      Obx(
                        () => (!dashboardController.categoryLoading.value &&
                                dashboardController.categories.isEmpty)
                            ? Center(
                                child: ScreenUtils.customLabel(
                                    labelType: LabelType.body,
                                    text: 'No categories available currently.'),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                physics: const ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: dashboardController
                                    .categories.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  return ScreenUtils.customGestureDetector(
                                    child: Card(
                                      child: SizedBox(
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5.0.w,
                                                vertical: 5.0.h),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: ScreenUtils.customLabel(
                                                          labelType: LabelType
                                                              .heading2,
                                                          isBold: true,
                                                          maxLines: 2,
                                                          isCenterAligned: true,
                                                          text: dashboardController
                                                              .categories[
                                                                  index]
                                                              .title),
                                                    ),
                                                  ],
                                                ),
                                                Expanded(
                                                  child: CachedNetworkImage(
                                                    imageUrl: '${APIEndpoints
                                                            .baseUrl}/${dashboardController
                                                            .categories[
                                                                index]
                                                            .image.replaceAll('\\', '/')}',
                                                    placeholder: (context,
                                                            url) =>
                                                        const CircularProgressIndicator(),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: ScreenUtils.customLabel(
                                                          labelType:
                                                              LabelType.small,
                                                          isItalic: true,
                                                          text: dashboardController
                                                              .categories[
                                                                  index]
                                                              .description,
                                                          maxLines: 2,
                                                          hasEllipsis: true,
                                                          isCenterAligned:
                                                              true),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    callbackAction: () {
                                      appController.currentCategory =
                                          dashboardController
                                              .categories[index].obs;
                                      Get.to(
                                          () => const CategoryDetailScreen());
                                    },
                                  );
                                }),
                      ),
                      // ListView.builder(
                      //     itemCount: appController.categories.length,
                      //     scrollDirection: Axis.vertical,
                      //     shrinkWrap: true,
                      //     physics: const BouncingScrollPhysics(),
                      //     itemBuilder: (BuildContext context, int index) {
                      //       return Card(
                      //         child: Center(
                      //           child: ScreenUtils.customLabel(
                      //               labelType: LabelType.body,
                      //               text: appController.categories[index].title),
                      //         ),
                      //       );
                      //     })
                      // Column(
                      //   children: [
                      //     Row(
                      //       children: [
                      //         Card(
                      //           color: categories[0],
                      //           child: Container(
                      //             height: 0.4.sh,
                      //             width: 0.45.sw,
                      //             padding: EdgeInsets.all(10.r),
                      //             child: Column(
                      //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //               children: [
                      //                 ScreenUtils.customLabel(
                      //                     labelType: LabelType.body,
                      //                     isCenterAligned: true,
                      //                     isBold: true,
                      //                     text: 'Information Technology'),
                      //                 Image.asset(
                      //                   "assets/hr.png",
                      //                   fit: BoxFit.cover,
                      //                   width: 0.35.sw,
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //         Card(
                      //           color: categories[1],
                      //           child: Container(
                      //             height: 0.4.sh,
                      //             width: 0.45.sw,
                      //             padding: EdgeInsets.all(10.r),
                      //             child: Column(
                      //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //               children: [
                      //                 ScreenUtils.customLabel(
                      //                     labelType: LabelType.body,
                      //                     isCenterAligned: true,
                      //                     isBold: true,
                      //                     text: 'Education'),
                      //                 Image.asset(
                      //                   "assets/education.png",
                      //                   fit: BoxFit.cover,
                      //                   width: 0.35.sw,
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     Row(
                      //       children: [
                      //         Card(
                      //           color: categories[3],
                      //           child: Container(
                      //             height: 0.4.sh,
                      //             width: 0.45.sw,
                      //             padding: EdgeInsets.all(10.r),
                      //             child: Column(
                      //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //               children: [
                      //                 ScreenUtils.customLabel(
                      //                     labelType: LabelType.body,
                      //                     isCenterAligned: true,
                      //                     isBold: true,
                      //                     text: 'Entertainment Sector'),
                      //                 Image.asset(
                      //                   "assets/entertainment.png",
                      //                   fit: BoxFit.cover,
                      //                   width: 0.35.sw,
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //         Card(
                      //           color: categories[0],
                      //           child: Container(
                      //             height: 0.4.sh,
                      //             width: 0.45.sw,
                      //             padding: EdgeInsets.all(10.r),
                      //             child: Column(
                      //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //               children: [
                      //                 ScreenUtils.customLabel(
                      //                     labelType: LabelType.body,
                      //                     isCenterAligned: true,
                      //                     isBold: true,
                      //                     text: 'Financial Sector'),
                      //                 Image.asset(
                      //                   "assets/finance.png",
                      //                   fit: BoxFit.cover,
                      //                   width: 0.35.sw,
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //     Row(
                      //       children: [
                      //         Card(
                      //           color: categories[1],
                      //           child: Container(
                      //             height: 0.4.sh,
                      //             width: 0.45.sw,
                      //             padding: EdgeInsets.all(10.r),
                      //             child: Column(
                      //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //               children: [
                      //                 ScreenUtils.customLabel(
                      //                     labelType: LabelType.body,
                      //                     isCenterAligned: true,
                      //                     isBold: true,
                      //                     text: 'Medical Sector'),
                      //                 Image.asset(
                      //                   "assets/medical.png",
                      //                   fit: BoxFit.cover,
                      //                   width: 0.35.sw,
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //         Card(
                      //           color: categories[2],
                      //           child: Container(
                      //             height: 0.4.sh,
                      //             width: 0.45.sw,
                      //             padding: EdgeInsets.all(10.r),
                      //             child: Column(
                      //               mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //               children: [
                      //                 ScreenUtils.customLabel(
                      //                     labelType: LabelType.body,
                      //                     isCenterAligned: true,
                      //                     isBold: true,
                      //                     text: 'Marketing Sector'),
                      //                 Image.asset(
                      //                   "assets/marketting.png",
                      //                   fit: BoxFit.cover,
                      //                   width: 0.35.sw,
                      //                 ),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
