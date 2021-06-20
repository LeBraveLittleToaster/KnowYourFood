import 'package:flutter/material.dart';
import 'package:knowyourfood/scanner/ScanPageWidget.dart';
import 'package:knowyourfood/stores/LoginStore.dart';
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

  @override
  Widget build(BuildContext context) {
    LoginStore loginStore = Provider.of<LoginStore>(context, listen: false);
    return Scaffold(
      appBar: getAppBar(loginStore),
      body: Center(
        child: _selectedIndex == 0 ? ScanPageWidget() : Text("Logged in"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.qr_code_2), label: "Scan"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Pref"),
          BottomNavigationBarItem(icon: Icon(Icons.share), label: "Share"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.accents[0],
        onTap: _onItemTapped,
      ),
    );
  }

  logout(LoginStore loginStore) {
    loginStore.logout();
  }

  AppBar getAppBar(LoginStore loginStore) {
    return AppBar(
      title: Text("Home"),
      actions: [
        IconButton(
            onPressed: () => logout(loginStore), icon: Icon(Icons.logout))
      ],
    );
  }
}