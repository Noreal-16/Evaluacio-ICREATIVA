

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:notes_app/data/repository/dio_exceptions.dart';
import 'package:notes_app/data/repository/local_repository.dart';
import 'package:notes_app/data/responses/response_login.dart';
import 'package:notes_app/models/model_notes.dart';



class ApiRepository {

  Dio dio = Dio(BaseOptions(
    baseUrl: "https://030d-190-96-101-114.sa.ngrok.io/",
    connectTimeout: 15000,
    receiveTimeout: 15000,
  ));


  Future login(String email, String password, VoidCallback? Function(int code, dynamic data) callback) async {
    final data = {"email": email, "password": password};
    try {
      final response = await dio.post("auth/login", data: data);
      print('logion response>>>> $response');
      if (response.data == null) return callback(-1, "Error al obtener datos");
      callback(1, ResponseLogin.fromMap(response.data));
    } catch (e) {
      callback(-1, "Error $e");
    }
  }

  Future getAllNotes( VoidCallback? Function(int code, dynamic data) callback) async {
    var token= await LocalRepository().getToken();
    try {
      final response = await dio.get("notes", options: Options(headers: {"Authorization": "Bearer ${token}"}));
      print(' response>>>> $response');
      if (response.data == null) return callback(-1, "Error al obtener datos");
      callback(1, response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print('++++++++++++++ $errorMessage');
      callback(-1, "Error $errorMessage");
    }
  }

  Future addNote(String description, VoidCallback? Function(int code, dynamic data) callback) async {
    var token= await LocalRepository().getToken();
    var data={
      "description":description
    };
    try {
      final response = await dio.post("notes",data: data, options: Options(headers: {"Authorization": "Bearer ${token}"}));
      print(' response>>>> $response');
      if (response.data == null) return callback(-1, "Error al obtener datos");
      callback(1, Notes.fromMap(response.data));
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print('++++++++++++++ $errorMessage');
      callback(-1, "Error $errorMessage");
    }
  }

  Future updateNote(String description,bool completed,int id, VoidCallback? Function(int code, dynamic data) callback) async {
    var token= await LocalRepository().getToken();
    var data={
      "description":description,
      "completed":completed
    };
    try {
      final response = await dio.patch("notes/$id",data: data, options: Options(headers: {"Authorization": "Bearer ${token}"}));
      print(' response>>>> $response');
      if (response.data == null) return callback(-1, "Error al obtener datos");
      callback(1, Notes.fromMap(response.data));
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print('++++++++++++++ $errorMessage');
      callback(-1, "Error $errorMessage");
    }
  }

  Future deleteNote(int id, VoidCallback? Function(int code, dynamic data) callback) async {
    var token= await LocalRepository().getToken();
    try {
      final response = await dio.delete("notes/$id",options: Options(headers: {"Authorization": "Bearer ${token}"}));
      print(' response>>>> $response');
      if (response.data == null) return callback(-1, "Error al obtener datos");
      callback(1, response.data);
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      print('++++++++++++++ $errorMessage');
      callback(-1, "Error $errorMessage");
    }
  }

}