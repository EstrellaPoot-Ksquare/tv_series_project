import 'package:flutter/material.dart';

class SnackbarManager {
  static displaySnackbar(context, text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          alignment: Alignment.center,
          height: 35,
          child: Text(
            '$text',
          ),
        ),
        duration: const Duration(milliseconds: 1500),
        width:
            MediaQuery.of(context).size.width * 0.9, // Width of the SnackBar.
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0, // Inner padding for SnackBar content.
        ),
      ),
    );
  }
}
