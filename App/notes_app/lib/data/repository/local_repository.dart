
import 'dart:convert';

import 'package:notes_app/models/model_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository {
  static const usershare=  "user";
  static const userToken=  "token";


  Future saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    JsonEncoder encoder = const JsonEncoder();
    prefs.setString(usershare, encoder.convert(user.toMap()));
  }


  Future<User?> getUser() async {
    JsonDecoder decoder = const JsonDecoder();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString(usershare) ?? "";
    if (user.isEmpty) {
      return null;
    }
    return User.map(decoder.convert(user));
  }

  Future deleteUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(usershare);
  }


  Future deleteToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(userToken);
  }


  Future<String?> getToken() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? status = prefs.getString(userToken);
    return status;
  }


  Future saveToken(String token) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(userToken, token);
  }

}