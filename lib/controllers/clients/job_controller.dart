import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:roj_gaar_app/controllers/clients/app_controller.dart';
import 'package:roj_gaar_app/controllers/clients/dashboard_controller.dart';
import 'package:roj_gaar_app/models/applicant_model.dart';
import 'package:roj_gaar_app/models/category_model.dart';
import 'package:roj_gaar_app/models/company_model.dart';
import 'package:roj_gaar_app/models/job_application_model.dart';
import 'package:roj_gaar_app/models/job_model.dart';
import 'package:roj_gaar_app/models/user_model.dart';
import 'package:roj_gaar_app/utils/api_endpoints.dart';
import 'package:roj_gaar_app/utils/constants.dart';
import '../../utils/secure_storage_helper.dart';
import 'dio_client.dart';

class JobController extends GetxController {
  final DioClient _dioClient = DioClient();
  RxBool isProcessing = false.obs,
      jobLoading = true.obs,
      userJobsLoading = true.obs,
      applicantsLoading = false.obs;
  RxString searchFilter = searchJobs.obs;

  late Rx<JobModel> currentJob;
  late Rx<JobApplicationModel> currentCompanyJob;
  RxList<JobModel> jobList = <JobModel>[].obs,
      jobsList = <JobModel>[].obs,
      searchedJobs = <JobModel>[].obs;
  RxList<JobApplicationModel> companyJobList = <JobApplicationModel>[].obs;

  RxList<CategoryModel> searchedCategories = <CategoryModel>[].obs;
  RxList<UserModel> searchedEmployees = <UserModel>[].obs;
  RxList<CompanyModel> searchedCompanies = <CompanyModel>[].obs;

  Rx<TextEditingController> newJobTitleController = TextEditingController().obs,
      newJobAboutController = TextEditingController().obs,
      newJobDescriptionController = TextEditingController().obs,
      newJobCategoriesController = TextEditingController().obs,
      newJobSkillsController = TextEditingController().obs,
      newJobResponsibilitiesController = TextEditingController().obs,
      newJobRequirementsController = TextEditingController().obs,
      newJobSalaryController = TextEditingController().obs,
      newJobClosedTimeController = TextEditingController().obs;

  RxList<JobModel> availableJobs = <JobModel>[].obs,
      recommendedJobs = <JobModel>[].obs;
  RxList<ApplicantModel> jobApplicants = <ApplicantModel>[].obs;

// post
  Future<bool> acceptApplication({required String userId}) async {
    isProcessing(true);
    try {
      var acceptApplicationBody = {
        "job_id": currentCompanyJob.value.id,
        'user_id': userId,
        'status': 'Accepted'
      };
      var request = await _dioClient.post(
          url: APIEndpoints.acceptApplicant,
          data: acceptApplicationBody,
          requiresToken: true);

      if (_dioClient.checkResponse(request: request)) {
        return true; // success
      } else {
        throw 'error in response accepting applicant.';
      }
    } catch (e) {
      debugPrint('>> error accepting application: ${e.toString()}');
      return false;
    } finally {
      isProcessing(false);
    }
  }

  Future<bool> addJob({
    required String companyId,
  }) async {
    isProcessing(true);
    try {
      var newJobBody = {
        "title": newJobTitleController.value.text,
        'about': newJobAboutController.value.text,
        'sallary': newJobSalaryController.value.text,
        "description": newJobDescriptionController.value.text,
        "skills": newJobRequirementsController.value.text.split(',').toList(),
        "requirements":
            newJobRequirementsController.value.text.split(',').toList(),
        "responsibilities":
            newJobResponsibilitiesController.value.text.split(',').toList(),
        "closeTime": newJobClosedTimeController.value.text,
        "company": companyId
      };
      // debugPrint(
      //     '>> new job request: ${APIEndpoints.postJob}\n>> new job body: ${newJobBody.toString()}');
      var request = await _dioClient.post(
          url: APIEndpoints.postJob, data: newJobBody, requiresToken: true);

      // debugPrint('>> new job response: ${request.data.toString()}');

      if (_dioClient.checkResponse(request: request)) {
        return true; // success
      } else {
        throw 'error in response adding job.'; // error
      }
    } catch (e) {
      debugPrint('>> error adding job: ${e.toString()}');
      return false;
    } finally {
      isProcessing(false);
    }
  }

  Future<bool> checkJobApplication({required String jobId}) async {
    if (Get.find<AppController>()
            .appUser
            .value
            .appliedJobs
            .map((application) => application.jobId)
            .toList()
            .indexWhere((element) => element == jobId) !=
        -1) {
      return true;
    }
    return false;
  }

  Future<bool> applyForJob({required String jobId}) async {
    isProcessing(true);
    try {
      var newJobBody = {"job": jobId};
      var request = await _dioClient.post(
          url: APIEndpoints.applyForJob, data: newJobBody, requiresToken: true);

      if (_dioClient.checkResponse(request: request)) {
        return true; // success
      } else {
        throw 'error in response applying for job.';
      }
    } catch (e) {
      debugPrint('>> error applying for job: ${e.toString()}');
      return false;
    } finally {
      isProcessing(false);
    }
  }

// get
  getAvailableJobs() async {
    jobLoading(true);
    try {
      var jobReq = await _dioClient.get(url: APIEndpoints.getAllJobs);

      availableJobs.clear();
      if (_dioClient.checkResponse(request: jobReq)) {
        // debugPrint('>> get all jobs response: ${jobReq.data.toString()}');
        if (jobReq.data['data'] == null) {
          availableJobs.clear();
        } else {
          var responseList = jobReq.data['data'];
          var tempList = <JobModel>[];
          responseList.forEach((job) {
            tempList.add(JobModel.fromJson(job));
          });
          availableJobs = tempList.obs;
        }
      }
    } catch (e) {
      debugPrint('>> error getting jobs: ${e.toString()}');
    } finally {
      jobLoading(false);
      availableJobs.refresh();
      debugPrint('>> available jobs count: ${availableJobs.length}');
    }
  }

  getRecommendedJobs() async {
    jobLoading(true);
    try {
      var jobReq = await _dioClient.get(
          url: APIEndpoints.getRecommendedJobs, requiresToken: true);

      recommendedJobs.clear();
      if (_dioClient.checkResponse(request: jobReq)) {
        // debugPrint('>> get recommended jobs response: ${jobReq.data.toString()}');
        if (jobReq.data['data'] == null) {
          recommendedJobs.clear();
        } else {
          var responseList = jobReq.data['data'];
          var tempList = <JobModel>[];
          responseList.forEach((job) {
            tempList.add(JobModel.fromJson(job));
          });
          recommendedJobs = tempList.obs;
        }
      }
    } catch (e) {
      debugPrint('>> error getting recommended jobs: ${e.toString()}');
    } finally {
      jobLoading(false);
      recommendedJobs.refresh();
      debugPrint('>> recommended jobs count: ${recommendedJobs.length}');
    }
  }

  getApplicants({required String companyId}) async {
    applicantsLoading(true);
    try {
      var request = await _dioClient.get(
          url: APIEndpoints.getAppliedJobsApplicants + companyId,
          requiresToken: true);

      if (_dioClient.checkResponse(request: request)) {
        // debugPrint('>> ${request.data['data'].toString()}');
        var tempList = List<JobApplicationModel>.from((request.data['data'])
            .map((model) => JobApplicationModel.fromJson(model)));
        currentCompanyJob.value.applicants = tempList
            .firstWhere((element) => element.id == currentCompanyJob.value.id)
            .applicants;
        return true; // success
      } else {
        throw 'error in response getting all jobs.';
      }
    } catch (e) {
      debugPrint('>> error getting jobs: ${e.toString()}');
      return false;
    } finally {
      currentCompanyJob.refresh();
      applicantsLoading(false);
    }
  }

  Future<bool> getAppliedJobs() async {
    userJobsLoading(true);
    try {
      var request = await _dioClient.get(
          url: APIEndpoints.getAppliedJobList, requiresToken: true);

      if (_dioClient.checkResponse(request: request)) {
        jobsList = List<JobModel>.from(
            (request.data['appliedJobs'] ?? <JobModel>[])
                .map((model) => JobModel.fromJson(model))).obs;
        return true; // success
      } else {
        throw 'error in response getting applied jobs.';
      }
    } catch (e) {
      debugPrint('>> error getting applied jobs: ${e.toString()}');
      return false;
    } finally {
      jobsList.refresh();
      debugPrint('>> applied job list count: ${jobList.length}');
      userJobsLoading(false);
    }
  }

  Future<bool> getCompanyJobs({required String companyId}) async {
    userJobsLoading(true);
    try {
      var request = await _dioClient.get(
          url: APIEndpoints.getCompanyJobDetails + companyId,
          requiresToken: true);
      if (_dioClient.checkResponse(request: request)) {
        var responseList = request.data['data'];
        var tempList = <JobApplicationModel>[];
        responseList.forEach((element) {
          tempList.add(JobApplicationModel.fromJson(element));
        });

        companyJobList = tempList.obs;
        return true; // success
      } else {
        throw 'error in response getting company jobs.';
      }
    } catch (e) {
      debugPrint('>> error getting company jobs: ${e.toString()}');
      return false;
    } finally {
      companyJobList.refresh();
      userJobsLoading(false);
    }
  }

  Future<bool> getJobDetail({required String jobId}) async {
    isProcessing(true);
    try {
      var request = await _dioClient.get(
        url: APIEndpoints.getJobDetails + jobId,
      );

      if (_dioClient.checkResponse(request: request)) {
        return true; // success
      } else {
        throw 'error in response getting job details.';
      }
    } catch (e) {
      debugPrint('>> error getting job details: ${e.toString()}');
      return false;
    } finally {
      isProcessing(false);
    }
  }

  search({required String searchTxt}) async {
    isProcessing(true);
    DashboardController dashboardController = Get.find<DashboardController>();

    try {
      if (searchFilter.value == searchJobs) {
        var temp = availableJobs
            .where((job) =>
                job.title.toLowerCase().contains(searchTxt.toLowerCase()) ||
                job.description.toLowerCase().contains(searchTxt.toLowerCase()))
            .toList();
        searchedJobs(temp);
        debugPrint(searchedJobs.length.toString());
      } else if (searchFilter.value == searchCategories) {
        var temp = dashboardController.categories
            .where((category) =>
                category.title
                    .toLowerCase()
                    .contains(searchTxt.toLowerCase()) ||
                category.description
                    .toLowerCase()
                    .contains(searchTxt.toLowerCase()))
            .toList();
        searchedCategories(temp);
        debugPrint(searchCategories.length.toString());
      }
    } catch (e) {
      debugPrint('>> error searching: ${e.toString()}');
    } finally {
      searchedJobs.refresh();
      searchedCategories.refresh();
      searchedEmployees.refresh();
      searchedCompanies.refresh();
      isProcessing(false);
    }
  }
}
