import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roj_gaar_app/controllers/clients/job_controller.dart';
import 'package:roj_gaar_app/utils/api_endpoints.dart';
import 'package:roj_gaar_app/views/jobs/job_detail.dart';
import 'package:roj_gaar_app/views/profile/category_detail_screen.dart';
import 'package:roj_gaar_app/views/profile/company_detail_screen.dart';
import 'package:roj_gaar_app/views/profile/employee_detail_screen.dart';
import '../../controllers/clients/app_controller.dart';
import '../../controllers/clients/dashboard_controller.dart';
import '../../utils/constants.dart';
import '../utils/screen_utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  DashboardController dashboardController = Get.find<DashboardController>();
  JobController jobController = Get.find<JobController>();
  AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(
              children: [
                ScreenUtils.customLabel(
                  labelType: LabelType.heading2,
                  text: 'Search',
                  isBold: true,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0.h),
              child: Obx(
                () => TextField(
                  controller: dashboardController.searchController.value,
                  onChanged: (searchText) async {
                    await jobController.search(searchTxt: searchText);
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      prefixIcon: IconButton(
                          onPressed: () async {
                            await jobController.search(
                                searchTxt: dashboardController
                                    .searchController.value.text);
                            setState(() {});
                          },
                          icon: const Icon(
                            Icons.search,
                            color: primaryColor,
                          )),
                      suffixIcon: IconButton(
                          onPressed: () {
                            Get.defaultDialog(
                                titlePadding: EdgeInsets.only(top: 20.h),
                                title: 'Search filter:',
                                content: SizedBox(
                                  width: 0.8.sw,
                                  child: Obx(
                                    () => Column(
                                      children: [
                                        RadioListTile(
                                          title: const Text("Jobs"),
                                          value: searchJobs,
                                          groupValue:
                                              jobController.searchFilter.value,
                                          onChanged: (value) {
                                            jobController.searchFilter.value =
                                                value.toString();

                                            dashboardController
                                                .searchController.value
                                                .clear();
                                          },
                                        ),
                                        SizedBox(
                                          height: 5.h,
                                        ),
                                        RadioListTile(
                                          title: const Text("Categories"),
                                          value: searchCategories,
                                          groupValue:
                                              jobController.searchFilter.value,
                                          onChanged: (value) {
                                            jobController.searchFilter.value =
                                                value.toString();

                                            dashboardController
                                                .searchController.value
                                                .clear();
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
                                                Get.back();
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                          },
                          icon: const Icon(Icons.filter_alt_outlined,
                              color: primaryColor)),
                      border: InputBorder.none,
                      hintText:
                          'Search for ${jobController.searchFilter.value}...',
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Obx(
              () => (dashboardController.searchController.value.text.isEmpty)
                  ? const SizedBox.shrink()
                  : ListView.builder(
                      padding: EdgeInsets.only(bottom: 10.h),
                      itemCount: jobController.searchFilter.value == searchJobs
                          ? jobController.searchedJobs.length
                          : jobController.searchedCategories.length,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        if (jobController.searchFilter.value == searchJobs) {
                          return SizedBox(
                            height: .24.sh,
                            child: Card(
                              color: Colors.white,
                              child: Stack(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                              Colors.white.withOpacity(0.9),
                                              BlendMode.srcOver),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.r),
                                            child: CachedNetworkImage(
                                              fadeInCurve: Curves.easeIn,
                                              fadeOutCurve: Curves.easeOut,
                                              imageUrl: (dashboardController
                                                          .categories
                                                          .indexWhere((p0) =>
                                                              p0.title ==
                                                              jobController
                                                                  .searchedJobs[
                                                                      index]
                                                                  .category) ==
                                                      -1)
                                                  ? jobsImageUrl
                                                  : '${APIEndpoints.baseUrl}/${dashboardController.categories.firstWhere((p0) => p0.title == jobController.searchedJobs[index].category).image.replaceAll('\\', '/')}',
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const CircularProgressIndicator(),
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                Icons.error,
                                                size: 40.h,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ListTile(
                                    // trailing: Column(
                                    //   children: [
                                    //     Expanded(
                                    //       child: Opacity(
                                    //         opacity: 0.4,
                                    //         child: CachedNetworkImage(
                                    //           fadeInCurve: Curves.easeIn,
                                    //           fadeOutCurve: Curves.easeOut,
                                    //           imageUrl: (dashboardController
                                    //                       .categories
                                    //                       .indexWhere((p0) =>
                                    //                           p0.title ==
                                    //                           jobController
                                    //                               .searchedJobs[index]
                                    //                               .category) ==
                                    //                   -1)
                                    //               ? jobsImageUrl
                                    //               : '${APIEndpoints.baseUrl}/${dashboardController.categories
                                    //                       .firstWhere((p0) =>
                                    //                           p0.title ==
                                    //                           jobController
                                    //                               .searchedJobs[index]
                                    //                               .category)
                                    //                       .image
                                    //                       .replaceAll('\\', '/')}',
                                    //           fit: BoxFit.contain,
                                    //           placeholder: (context, url) =>
                                    //               const CircularProgressIndicator(),
                                    //           errorWidget: (context, url, error) =>
                                    //               Icon(
                                    //             Icons.error,
                                    //             size: 40.h,
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    onTap: () {
                                      jobController.currentJob =
                                          jobController.searchedJobs[index].obs;
                                      Get.to(() => JobDetailScreen());
                                    },
                                    title: ScreenUtils.customLabel(
                                        labelType: LabelType.body,
                                        isBold: true,
                                        text: jobController
                                            .searchedJobs[index].title),
                                    subtitle: ScreenUtils.customLabel(
                                        labelType: LabelType.small,
                                        maxLines: 3,
                                        hasEllipsis: true,
                                        text:
                                            '${jobController.searchedJobs[index].category}\n${jobController.searchedJobs[index].description}'),
                                    isThreeLine: true,
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (jobController.searchFilter.value ==
                            searchCategories) {
                          return SizedBox(
                            height: .24.sh,
                            child: Card(
                              color: Colors.white,
                              child: ListTile(
                                onTap: () {
                                  appController.currentCategory = jobController
                                      .searchedCategories[index].obs;
                                  Get.to(() => const CategoryDetailScreen());
                                },
                                // trailing: Column(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Opacity(
                                //       opacity: 0.4,
                                //       child: CachedNetworkImage(
                                //         fadeInCurve: Curves.easeIn,
                                //         fadeOutCurve: Curves.easeOut,
                                //         imageUrl:
                                //             '${APIEndpoints.baseUrl}/${jobController.searchedCategories[index].image.replaceAll('\\', '/')}',
                                //         fit: BoxFit.contain,
                                //         placeholder: (context, url) =>
                                //             const CircularProgressIndicator(),
                                //         errorWidget: (context, url, error) =>
                                //             Icon(
                                //           Icons.error,
                                //           size: 40.h,
                                //         ),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                title: ScreenUtils.customLabel(
                                    labelType: LabelType.body,
                                    isBold: true,
                                    text: jobController
                                        .searchedCategories[index].title),
                                subtitle: ScreenUtils.customLabel(
                                    labelType: LabelType.small,
                                    maxLines: 3,
                                    hasEllipsis: true,
                                    text: jobController
                                        .searchedCategories[index].description),
                                isThreeLine: true,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      }),
            )
          ],
        ),
      ),
    );
  }
}
