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
        body: widget.loginStore.isLoading
            ? SpinKitChasingDots(
                color: Colors.blueGrey,
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Image.asset("assets/brain.png")),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 48),
                        child: Text(
                          "KnowYourFood",
                          style: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _unameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Username"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _pwController,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Password"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        floatingActionButton: Stack(children: [
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              foregroundColor: Colors.yellow[700],
              backgroundColor: Colors.grey[800],
              onPressed: () => _login(),
              tooltip: 'Login',
              child: Icon(Icons.login),
            ),
          )
        ]),
      ),
    );
  }
}
