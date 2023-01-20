import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Se canceló la solicitud al servidor API"; //Request to API server was cancelled
        break;
      case DioErrorType.connectTimeout:
        message = "Tiempo de espera de conexión con el servidor API";//Connection timeout with API server
        break;
      case DioErrorType.receiveTimeout:
        message = "Tiempo de espera de recepción en conexión con el servidor API"; //Receive timeout in connection with API server
        break;
      case DioErrorType.response:
        message = _handleError(
          dioError.response!.statusCode,
          dioError.response!.data,
        );
        break;
      case DioErrorType.sendTimeout:
        message = "Enviar tiempo de espera en conexión con el servidor API";//Send timeout in connection with API server
        break;
      case DioErrorType.other:
        if (dioError.message.contains("SocketException")) {
          message = 'Sin internet';//No Internet
          break;
        }
        message = "Ocurrió un error inesperado";//Unexpected error occurred
        break;
      default:
        message = "Algo salió mal";//Something went wrong
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Solicitud incorrecta';//Bad request
      case 401:
        return 'No autorizado';//Unauthorized
      case 403:
        return 'Prohibido';//Forbidden
      case 404:
        try{
          return error["message"];
        }catch(e) {
          return error;
        }
      case 500:
        return 'Error de servidor interno';//Internal server error
      case 502:
        return 'Bad gateway';//Bad gateway
      default:
        return 'Huy! Algo salió mal';//Oops something went wrong
    }
  }

  @override
  String toString() => message;
}