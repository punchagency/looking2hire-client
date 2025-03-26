import 'package:flutter/material.dart';

extension ScrollControllerExtensions on ScrollController {
  void Function() addOnScrollEndListener(void Function() onScrollEnd) {
    void onScroll() {
      if (position.pixels >= position.maxScrollExtent - 200) {
        onScrollEnd();
      }
    }

    addListener(onScroll);
    return onScroll;
  }

  void Function() addOnScrollStarListener(void Function() onScrollStart) {
    void onScroll() {
      if (position.pixels <= 200) {
        onScrollStart();
      }
    }

    addListener(onScroll);
    return onScroll;
  }
}
