import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:formula/data/app_exceptions.dart';
import 'package:formula/data/local/pref_service.dart';
import 'package:http/http.dart';
import 'base_api_service.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {

  /// Get data from the server ///
  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;

    try {
      var token = PrefService().getToken();
      if (kDebugMode) {
        print("Url : $url");
      }
      final response = await http
          .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  /// Post Data from the server ///
  @override
  Future postApiResponse(String url, Map<String, dynamic> mData) async {
    dynamic responseJson;
    try {
      if (kDebugMode) {
        print("Url : $url");
      }
      var token = PrefService().getToken();
      if (kDebugMode) {
        print("mData : $mData");
      }

      Response response = await http.post(Uri.parse(url),
          body: mData, headers: {'Authorization': 'Bearer $token'});

      if (kDebugMode) {
        print("Response body : ${response.body}");
      }
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  /// Delete data from the server ///
  @override
  Future<dynamic> deleteApiResponse(String url) async {
    if (kDebugMode) {
      print("url : $url");
    }
    dynamic responseJson;
    var token = PrefService().getToken();
    try {
      final response = await http
          .delete(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  /// Post Data with image  from the server ///
  @override
  Future filePostApiResponseWithImage(String url, method,
      Map<String, dynamic> formData, List<MultipartFile> file) async {
    try {
      final request = http.MultipartRequest(
        method,
        Uri.parse(url),
      );

      if (kDebugMode) {
        print("URL  : $url");
      }
      if (kDebugMode) {
        print("method : $method");
      }
      if (kDebugMode) {
        print("formData : $formData");
      }

      var token = PrefService().getToken();
      request.headers.addAll({
        'Authorization': 'Bearer $token', // Replace with your actual token
        'Content-Type': 'multipart/form-data',
      });

      // Add form fields
      formData.forEach((key, value) {
        request.fields[key.toString().trim()] = value.toString().trim();
      });

      // Add image files
      if (file.isNotEmpty) {
        for (var f in file) {
          if (kDebugMode) {
            print("Image Url: $f");
          }
          request.files.add(f);
        }
      }

      if (kDebugMode) {
        print('request.fields :${request.fields}');
        for (var f in request.files) {
          print('request.files ${f.field} : ${f.filename}');
        }

      }
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (kDebugMode) {
        print("response body :${response.body}");
      }

      if (kDebugMode) {
        print("Res registration data : ${jsonDecode(response.body)}");
      }

      return returnResponse(response);
    } catch (e) {
      if (kDebugMode) {
        print("Error : ${e.runtimeType}");
      }
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 201:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error Accrued While communication with serverWith status code ${response.statusCode}');
    }
  }
}