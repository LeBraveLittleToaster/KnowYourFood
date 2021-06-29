import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:knowyourfood/scanner/FoodCheckWidget.dart';
import 'package:knowyourfood/stores/Food.dart';
import 'package:knowyourfood/stores/FoodStore.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';

class ScanPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPageWidget> {
  Food? scannedFood = null;

  @override
  Widget build(BuildContext context) {
    _checkPermissions() async {
      var status = await Permission.camera;
      if (await status.isDenied) {
        print("Is denied");
        Map<Permission, PermissionStatus> statuses =
            await [Permission.camera, Permission.storage].request();
        print(statuses[Permission.camera]);
      } else {
        print("Granted");
      }
    }

    _onScanStart() async {
      _checkPermissions();
      String scannedFoodId = await scanner.scan();
      print("SCANNED: " + scannedFoodId);
      Food? food =
          await Provider.of<FoodStore>(context, listen: false).loadFoodFromId(scannedFoodId);
          print("FOOD: " + food.toJson().toString());
      setState(() {
        scannedFood = food;
      });
      print(food.description);
    }

    return Stack(
      children: [
        FoodCheckWidget(food: this.scannedFood),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FloatingActionButton(
              foregroundColor: Colors.yellow[700],
              backgroundColor: Colors.grey[850],
              onPressed: () => _onScanStart(),
              child: Icon(Icons.photo_camera),
            ),
          ),
        )
      ],
    );
  }
}
