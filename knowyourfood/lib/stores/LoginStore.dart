import 'dart:async';
import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowyourfood/login/Session.dart';

class LoginStore extends ChangeNotifier {
  Client client;
  bool _isLoggedIn = false;
  bool _isLoading = true;
  Session? user;

  LoginStore({required this.client});

  bool get isLoggedIn {
    return _isLoggedIn;
  }

  bool get isLoading {
    return _isLoading;
  }

  LoginStore setupClient() {
    _checkIsLoggedIn();
    return this;
  }

  login(String email, String password) async {
    this._isLoading = true;
    this.notifyListeners();
    new Account(client)
        .createSession(email: email, password: password)
        .then((Response<dynamic> resp) {
      this._isLoggedIn = true;
      print(resp);
      this.user = Session.fromJson(json.decode(resp.toString()));
    }).onError((AppwriteException error, stackTrace) {
      this._isLoggedIn = false;
      print(error.message);
    }).whenComplete(() {
      this._isLoading = false;
      this.notifyListeners();
    });
  }

  _checkIsLoggedIn() async {
    Account account = new Account(client);
    account
        .get()
        .then((value) => this._isLoggedIn = true)
        .catchError((_) => this._isLoggedIn = false)
        .whenComplete(() {
      this._isLoading = false;
      this.notifyListeners();
    });
  }

  logout() {
    this._isLoading = true;
    print("Logging out");
    new Account(client)
        .deleteSessions()
        .then((_) => this._isLoggedIn = false)
        .catchError((_) {})
        .whenComplete(() {
      this._isLoading = false;
      this.notifyListeners();
    });
  }
}
