import 'package:flutter/material.dart';
import 'package:knowyourfood/PrefPageWidget.dart';
import 'package:knowyourfood/scanner/ScanPageWidget.dart';
import 'package:knowyourfood/shopview/RegisterFoodList.dart';
import 'package:knowyourfood/shopview/RegisterFoodWidget.dart';
import 'package:knowyourfood/stores/LoginStore.dart';
import 'package:knowyourfood/stores/PreferenceStore.dart';
import 'package:provider/provider.dart';

class HomePageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageWidget> {
  var _selectedIndex = 0;

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return ScanPageWidget();
      case 1:
        return PrefPageWidget();
      case 2:
        return RegisterFoodList();
      default:
        return Consumer<PreferenceStore>(
            builder: (context, prefStore, child) =>
                RegisterFoodWidget(prefStore.prefs));
    }
  }

  @override
  Widget build(BuildContext context) {
    LoginStore loginStore = Provider.of<LoginStore>(context, listen: false);
    return Container(
      decoration: BoxDecoration(gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            Colors.green[800]!,
            Colors.green[700]!,
            Colors.green[600]!,
            Colors.green[400]!,
          ],
        ),),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: getAppBar(loginStore),
        body: Center(child: getPage(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.qr_code_2), label: "Scan"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Pref"),
            BottomNavigationBarItem(icon: Icon(Icons.share), label: "Share"),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.yellow[700],
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  logout(LoginStore loginStore) {
    loginStore.logout();
  }

  AppBar getAppBar(LoginStore loginStore) {
    return AppBar(
      title: Text("KnowYourFood",style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 20
                  ,fontWeight: FontWeight.bold),),
      actions: [
        IconButton(
            onPressed: () => logout(loginStore), icon: Icon(Icons.logout))
      ],
    );
  }
}
