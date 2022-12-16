import 'package:flutter/material.dart';

class ScrollManager {
  scrollToTopPosition(ScrollController controller) {
    controller.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 100),
    );
  }

  scrollToBottomPosition(ScrollController controller) {
    controller.animateTo(
      controller.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 100),
    );
  }
}
