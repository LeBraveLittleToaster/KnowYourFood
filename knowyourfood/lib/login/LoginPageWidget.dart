import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:knowyourfood/stores/LoginStore.dart';
import 'package:provider/provider.dart';

class LoginPageWidget extends StatefulWidget {
  LoginStore loginStore;
  LoginPageWidget({required this.loginStore});

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageWidget> {
  late TextEditingController _unameController;
  late TextEditingController _pwController;

  @override
  void initState() {
    super.initState();
    _unameController = TextEditingController(text: "consumer@email.com");
    _pwController = TextEditingController(text: "123456");
  }

  @override
  void dispose() {
    _unameController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  void _login() {
    widget.loginStore
        .login(this._unameController.text, this._pwController.text);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Some title"),
      ),
      body: widget.loginStore.isLoading
          ? SpinKitChasingDots(
              color: Colors.blueGrey,
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _unameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Username"),
                  ),
                  TextField(
                    controller: _pwController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Password"),
                  ),
                ],
              ),
            ),
      floatingActionButton: Stack(children: [
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: () => _login(),
            tooltip: 'Login',
            child: Icon(Icons.login),
          ),
        )
      ]),
    );
  }
}
