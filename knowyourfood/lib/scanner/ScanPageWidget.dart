import 'package:flutter/material.dart';
import 'package:knowyourfood/scanner/FoodCheckWidget.dart';
import 'package:knowyourfood/stores/Food.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';

class ScanPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPageWidget> {
  bool _isScanning = false;

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
      setState(() {
        _isScanning = true;
      });
      String cameraScanResult = await scanner.scan();
      print("SCANNED: " + cameraScanResult);
      setState(() {
        _isScanning = false;
      });
    }

    return Stack(
      children: [
        FoodCheckWidget(food: this.scannedFood),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: () => _onScanStart(),
              child: Icon(Icons.photo_camera),
            ),
          ),
        )
      ],
    );
  }
}