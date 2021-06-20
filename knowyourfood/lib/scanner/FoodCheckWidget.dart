import 'package:flutter/material.dart';
import 'package:knowyourfood/stores/Food.dart';

class FoodCheckWidget extends StatelessWidget {
  Food? food;

  FoodCheckWidget({required this.food});
  @override
  Widget build(BuildContext context) {
    return food == null
        ? Center(
            child: Text("Please Scan QR code"),
          )
        : Container();
  }
}
