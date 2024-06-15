import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prep_pro/controllers/categories_controller.dart';
import 'package:prep_pro/controllers/organizations_controller.dart';
import 'package:prep_pro/controllers/subjects_controller.dart';
import 'package:prep_pro/ui/home/Filter/widgets/sort_by_list.dart';

import 'widgets/categories_list.dart';
import 'widgets/organizations_list.dart';
import 'widgets/subjects_list.dart';

class FilterUIController extends GetxController {
  FilterUIController get to => Get.find();

  final filterCategories = [
    "Categories",
    "Subjects",
    "Organizations",
    "Sort by"
  ];

  RxList<String> sortOptions = [
    "Featured",
    "Price:High to Low",
    "Price:Low to High",
    "Latest",
  ].obs;

  RxString selectedSortOption = "".obs;

  @override
  void onReady() {
    selectedSortOption.value = sortOptions.first;
    super.onReady();
  }

  final RxString selectedCategory = "Categories".obs;

  changeCategory(String newCategory) {
    selectedCategory.value = newCategory;
    log("change category: $newCategory");
  }

  changeSortOption(String newData) {
    selectedSortOption.value = newData;
    log("change sort option: $newData");
  }

  Color isSelected(String cardValue) {
    if (cardValue.toLowerCase() == selectedCategory.value.toLowerCase()) {
      return Colors.blue[50]!;
    } else {
      return Colors.white;
    }
  }

  bool isSortSelected(String cardValue) {
    return (cardValue.toLowerCase() == selectedSortOption.value.toLowerCase());
  }

  void clearFilter() {
    for (var element in CategoriesController().to.categories) {
      element.isSelected = false;
    }
    CategoriesController().to.categories.refresh();
    for (var element in SubjectsController().to.subjects) {
      element.isSelected = false;
    }
    SubjectsController().to.subjects.refresh();
    for (var element in OrganizationsController().to.organizations) {
      element.isSelected = false;
    }
    OrganizationsController().to.organizations.refresh();
    selectedSortOption.value = sortOptions.first;
  }

  Map<String, dynamic> submitSort() {
    List<int> selectedCategoryIds = CategoriesController()
        .to
        .categories
        .where((option) => option.isSelected)
        .map((option) => option.id)
        .toList();
    List<int> selectedSubjectIds = SubjectsController()
        .to
        .subjects
        .where((option) => option.isSelected)
        .map((option) => option.id)
        .toList();
    List<int> selectedOrganizationsIds = OrganizationsController()
        .to
        .organizations
        .where((option) => option.isSelected)
        .map((option) => option.id)
        .toList();
    final data = {
      "categories": selectedCategoryIds,
      "subjects": selectedSubjectIds,
      "organizations": selectedOrganizationsIds,
      "sort": selectedSortOption.value,
    };
    return data;
  }

  Widget getFilterUI() {
    switch (selectedCategory.value) {
      case "Categories":
        {
          return const CategoriesSheetList();
        }
      case "Subjects":
        {
          return const SubjectsSheetList();
        }
      case "Organizations":
        {
          return const OrganizationsSheetList();
        }
      case "Sort by":
        {
          return SortOptionsSheetList();
        }
      default:
        {
          return const CategoriesSheetList();
        }
    }
  }
}
