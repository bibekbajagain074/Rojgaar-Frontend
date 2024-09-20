import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:roj_gaar_app/controllers/clients/job_controller.dart';
import 'package:roj_gaar_app/views/jobs/new_job_screen.dart';

import '../../controllers/clients/app_controller.dart';
import '../../controllers/clients/dashboard_controller.dart';
import '../utils/screen_utils.dart';

class HomeContainer extends StatefulWidget {
  const HomeContainer({super.key});

  @override
  State<HomeContainer> createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  DashboardController dashboardController = Get.find<DashboardController>();
  JobController jobController = Get.find<JobController>();
  AppController appController = Get.find<AppController>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    await jobController.getAvailableJobs();
    await dashboardController.getCategories();
    if (appController.isUser.value) {
      await jobController.getRecommendedJobs();
    } else {
      await jobController.getCompanyJobs(
          companyId: appController.appUser.value.company!.id);
    }
  }

  @override
  void dispose() {
    super.dispose();
    dashboardController.currentPage(DashboardPages.dashboard);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ScreenUtils.navBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Obx(
        () => (!appController.isUser.value &&
                appController.appUser.value.company!.phone.isNotEmpty)
            ? GestureDetector(
                onTap: () => Get.to(() => const NewJobScreen()),
                child: Card(
                  shape: const CircleBorder(),
                  child: Padding(
                    padding: EdgeInsets.all(15.0.r),
                    child: const Icon(Icons.add),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ),
      body: SafeArea(
        child: Obx(
          () => dashboardController.navigate(
            page: dashboardController.currentPage.value,
          ),
        ),
      ),
    );
  }
}
