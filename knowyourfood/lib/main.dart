import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:knowyourfood/HomePageWidget.dart';
import 'package:knowyourfood/login/LoginPageWidget.dart';
import 'package:knowyourfood/stores/PreferenceStore.dart';
import 'package:provider/provider.dart';

import 'stores/LoginStore.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Client client = new Client();
    client
        .setEndpoint("https://192.168.0.103/v1")
        .setProject("60cf200213d70")
        .setSelfSigned();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginStore>(
          create: (_) => LoginStore(client: client).setupClient(),
        ),
      ],
      builder: (context, child) => MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page', client: client),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title, required this.client})
      : super(key: key);

  final Client client;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(builder: (context, loginStore, child) {
      print("Is Loading: " + loginStore.isLoading.toString());
      print("Is Logged in: " + loginStore.isLoggedIn.toString());
      if (loginStore.isLoading) {
        return Scaffold(
          body: SpinKitChasingDots(
            color: Colors.orange,
          ),
        );
      }
      if (!loginStore.isLoggedIn) {
        return LoginPageWidget(loginStore: loginStore);
      }
      return ChangeNotifierProvider<PreferenceStore>(
        create: (_) => PreferenceStore(client: widget.client).initPreferences(),
        child: HomePageWidget(),
      );
    });
  }
}
