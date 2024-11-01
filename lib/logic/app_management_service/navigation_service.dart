import 'package:flutter/material.dart';

class NavigationService {
  var currentPageIndex = ValueNotifier<int>(1);
  final isLoadingNotifier = ValueNotifier<bool>(false);

  void setCurrentPageIndex(int index) {
    currentPageIndex.value = index;
  }
}
