import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:roj_gaar_app/controllers/clients/dio_client.dart';
import 'package:roj_gaar_app/models/category_model.dart';
import 'package:roj_gaar_app/models/company_model.dart';
import 'package:roj_gaar_app/models/user_model.dart';
import 'package:roj_gaar_app/utils/api_endpoints.dart';
import 'package:roj_gaar_app/views/dashboard/categories_screen.dart';
import 'package:roj_gaar_app/views/dashboard/dashboard_screen.dart';
import 'package:roj_gaar_app/views/dashboard/search_screen.dart';
import 'package:roj_gaar_app/views/dashboard/settings_screen.dart';
import 'package:roj_gaar_app/views/dashboard/setup_incomplete_screen.dart';
class DashboardController extends GetxController {
  final _dioClient = DioClient();
  Rx<DashboardPages> currentPage = DashboardPages.dashboard.obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxList<UserModel> availableEmployees = <UserModel>[].obs;
  RxList<CompanyModel> availableCompanies = <CompanyModel>[].obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;
  RxBool categoryLoading = true.obs;

  getCategories() async {
    categoryLoading(true);
    try {
      var catReq = await _dioClient.get(url: APIEndpoints.getAllCategories);

      categories.clear();
      if (_dioClient.checkResponse(request: catReq)) {
        // debugPrint('>> get all category response: ${catReq.data.toString()}');
        if (catReq.data['data'] == null) {
          categories.clear();
        } else {
          var responseList = catReq.data['data'];
          var tempList = <CategoryModel>[];
          responseList.forEach((category) {
            tempList.add(CategoryModel.fromJson(category));
          });
          categories.value = tempList;
        }
      }
    } catch (e) {
      debugPrint('>> error getting jobs: ${e.toString()}');
    } finally {
      categoryLoading(false);
      categories.refresh();
      debugPrint(
          '>> available categories count: ${categories.length}');
    }
  }


  Widget navigate({required DashboardPages page}) {
    currentPage.value = page;
    debugPrint(currentPage.value.toString());
    switch (page) {
      case DashboardPages.dashboard:
        return const DashboardScreen();
      case DashboardPages.search:
        return const SearchScreen();
      case DashboardPages.categories:
        return const CategoriesScreen();
      case DashboardPages.settings:
        return const SettingScreen();
      case DashboardPages.setup:
        return const SetupPromptScreen();
      default:
        return const DashboardScreen();
    }
  }
}

enum DashboardPages { home, dashboard, search, categories, settings, setup }
