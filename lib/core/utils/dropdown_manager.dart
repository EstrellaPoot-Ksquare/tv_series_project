import 'package:flutter/material.dart';

class DropDownManager {
  List<DropdownMenuItem<int>> dropdownItems(items) {
    List<DropdownMenuItem<int>> menuItems = [];
    for (var item in items) {
      menuItems
          .add(DropdownMenuItem(value: item, child: Text('Season - $item')));
    }
    return menuItems;
  }
}
