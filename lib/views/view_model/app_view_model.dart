import 'package:flutter/material.dart';
import 'package:loh_ecommerce_app/utils/softkey_focus.dart';
import 'package:loh_ecommerce_app/views/view_model/base_view_model.dart';

import '../../enum/filter_criteria.dart';
import '../../enum/view_state.dart';
import '../../models/list_item.dart';
import '../../models/list_items.dart';

class AppViewModel extends BaseViewModel {
  String errorMessage = "";
  ViewState _state = ViewState.idle;
  FilterCriteria? currentFilterCriteria;
  Map<String, List<ListItem>> filteredTabItems = {};
  final searchController = TextEditingController();
  bool criteriaSelected = false;
  bool isSearch = false;

  @override
  ViewState get viewState => _state;

  void setViewState(ViewState state) {
    _state = state;
    notifyListeners();
  }

  void setError(String error) {
    errorMessage = error;
    notifyListeners();
  }

  void showSearchField() {
    isSearch = true;
    notifyListeners();
  }

  void closeSearchField(BuildContext context, String currentTab) {
    isSearch = false;
    hideKeyboard(context);
    clearSearch(currentTab);
    notifyListeners();
  }

  void searchItems(String query, String currentTab) {
    if (query.isEmpty) {
      // If the search query is empty, show all items
      clearSearch(currentTab);
      return;
    }

    // Filter items based on the search query
    List<ListItem> currentTabItems = List.from(tabItems[currentTab] ?? []);
    List<ListItem> filteredItems = currentTabItems
        .where((item) => item.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    filteredTabItems[currentTab] = filteredItems;
    notifyListeners();
  }

  void clearSearch(String currentTab) {
    // Reset the filtered items to show all items
    filteredTabItems[currentTab] = List.from(tabItems[currentTab] ?? []);
    searchController.clear();
    notifyListeners();
  }


  void applyFilter(FilterCriteria criteria, String currentTab, Map<String, List<ListItem>> tabItems) {
    criteriaSelected = true;
    currentFilterCriteria = criteria;

    // Filter or sort the items for the current tab
    List<ListItem> currentTabItems = List.from(tabItems[currentTab] ?? []);

    // Apply sorting/filtering logic based on criteria
    switch (criteria) {
      case FilterCriteria.popularity:
        currentTabItems.sort((a, b) => a.popularity.compareTo(b.popularity));
        break;
      case FilterCriteria.newest:
        currentTabItems.sort((a, b) => a.newest.compareTo(b.newest));
        break;
      case FilterCriteria.review:
        currentTabItems.sort((a, b) => a.review.compareTo(b.review));
        break;
      case FilterCriteria.lowPrice:
        currentTabItems.sort((a, b) => a.price.compareTo(b.price));
        break;
      case FilterCriteria.highPrice:
        currentTabItems.sort((a, b) => a.price.compareTo(b.price));
        break;
      default:
        clearFilter();
        break;
    }

    // Store the filtered list in the map if criteria is selected
    if (criteriaSelected) {
      filteredTabItems[currentTab] = currentTabItems;
    }

    notifyListeners();
  }

  void clearFilter() {
    criteriaSelected = false;
    currentFilterCriteria = null;
    filteredTabItems.clear();
    notifyListeners();
  }

}
