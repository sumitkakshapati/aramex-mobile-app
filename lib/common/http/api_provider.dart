import 'dart:async';
import 'dart:io';

import 'package:aramex/common/navigation/navigation_service.dart';
import 'package:aramex/common/util/device_utils.dart';
import 'package:aramex/common/util/log.dart';
import 'package:aramex/common/util/snackbar_utils.dart';
import 'package:aramex/common/util/token_expire_handler.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart' as parse;
import 'package:mime/mime.dart';

import 'custom_exception.dart';

class ApiProvider {
  String token = '';

  final Dio _dioGet = Dio(
    BaseOptions(receiveDataWhenStatusError: true),
  );

  void setToken(String token) {
    this.token = token;
  }

  Future<Map<String, dynamic>> post(
    String url,
    dynamic body, {
    Map<String, dynamic>? queryParam,
    String token = '',
    bool isRefreshRequest = false,
  }) async {
    dynamic responseJson;
    final Dio _dio = Dio(
      BaseOptions(receiveDataWhenStatusError: true),
    );
    try {
      final _userAgent = await DeviceUtils.userAgent;
      final Map<String, String> header = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*',
        'user-agent': _userAgent,
      };

      if (token.isNotEmpty) {
        header['Authorization'] = 'Bearer ' + token;
      }
      final dynamic response = await _dio.post(
        url,
        data: body,
        queryParameters: queryParam,
        options: Options(headers: header),
      );
      responseJson = _response(response, url);
    } on DioError catch (e) {
      responseJson = await _handleErrorResponse(e);
    }
    return responseJson;
  }

  Future<dynamic> patch(String url, dynamic body,
      {String token = '', bool isRefreshRequest = false}) async {
    final Dio _dio = Dio(
      BaseOptions(receiveDataWhenStatusError: true),
    );
    dynamic responseJson;
    try {
      final _userAgent = await DeviceUtils.userAgent;
      final Map<String, String> header = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*',
        'user-agent': _userAgent,
      };
      if (token.isNotEmpty) {
        header['Authorization'] = 'Bearer ' + token;
      }
      final dynamic response = await _dio.patchUri(Uri.parse(url),
          data: body, options: Options(headers: header));
      responseJson = _response(response, url);
    } on DioError catch (e) {
      responseJson = await _handleErrorResponse(e);
    }
    return responseJson;
  }

  Future<dynamic> put(String url, dynamic body,
      {String token = '', bool isRefreshRequest = false}) async {
    final Dio _dio = Dio(
      BaseOptions(receiveDataWhenStatusError: true),
    );
    dynamic responseJson;
    try {
      final _userAgent = await DeviceUtils.userAgent;
      final Map<String, String> header = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*',
        'user-agent': _userAgent,
      };
      if (token.isNotEmpty) {
        header['Authorization'] = 'Bearer ' + token;
      }
      final dynamic response = await _dio.putUri(Uri.parse(url),
          data: body, options: Options(headers: header));
      responseJson = _response(response, url);
    } on DioError catch (e) {
      responseJson = await _handleErrorResponse(e);
    }
    return responseJson;
  }

  Future<dynamic> get(String url,
      {String token = '',
      bool isRefreshRequest = false,
      Map<String, dynamic>? queryParams}) async {
    dynamic responseJson;

    try {
      final _userAgent = await DeviceUtils.userAgent;
      final Map<String, String> header = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*',
        'user-agent': _userAgent,
      };
      if (token.isNotEmpty) {
        header['Authorization'] = 'Bearer ' + token;
      }
      final dynamic response = await _dioGet.get(url,
          options: Options(
            headers: header,
          ),
          queryParameters: queryParams);

      responseJson = _response(response, url, cacheResult: true);
    } on DioError catch (e, s) {
      responseJson = await _handleErrorResponse(e);
      Log.e(e);
      Log.d(s);
    }
    return responseJson;
  }

  Future<dynamic> delete(String url, {String token = '', dynamic body}) async {
    final Dio _dio = Dio(
      BaseOptions(receiveDataWhenStatusError: true),
    );
    dynamic responseJson;
    try {
      final _userAgent = await DeviceUtils.userAgent;
      final Map<String, String> header = {
        'content-type': 'application/json',
        'accept': 'application/json',
        'origin': '*',
        'user-agent': _userAgent,
      };
      if (token.isNotEmpty) {
        header['Authorization'] = 'Bearer ' + token;
      }
      final dynamic response = await _dio.deleteUri(Uri.parse(url),
          data: body, options: Options(headers: header));
      responseJson = await _response(response, url);
      responseJson['status'] = response.statusCode;
    } on DioError catch (e) {
      responseJson = await _handleErrorResponse(e);
    }
    return responseJson;
  }

  upload(String url, File file, {String token = ''}) async {
    final Dio _dio = Dio(
      BaseOptions(receiveDataWhenStatusError: true),
    );
    try {
      final _userAgent = await DeviceUtils.userAgent;
      final Map<String, String> header = {
        'accept': 'application/json',
        'origin': '*',
        'user-agent': _userAgent,
      };
      if (token.isNotEmpty) {
        header['Authorization'] = 'Bearer ' + token;
      }
      final String fileName = file.path.split('/').last;
      // final String _extention = file.path.split('.').last;
      final String type = lookupMimeType(file.path)!.split('/').first;
      print(type);

      final FormData formData = FormData.fromMap(<String, dynamic>{
        'file': await MultipartFile.fromFile(
          file.path,
          filename: fileName,
          contentType: parse.MediaType('image', file.path.split('.').last),
        ),
      });
      final Response<dynamic> response = await _dio.post<dynamic>(url,
          data: formData, options: Options(headers: header));

      print(response.data.toString());
      return _response(response, url);
    } on DioError catch (e) {
      // responseJson = await _handleErrorResponse(e);
      Log.e(e);
    } catch (e) {
      print("Hllo");
    }
  }

  download(String url, String localPath) async {
    final Dio _dio = Dio(
      BaseOptions(receiveDataWhenStatusError: true),
    );
    // dynamic responseJson = <String, dynamic>{};
    try {
      final Response<dynamic> response = await _dio.get<dynamic>(
        url,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              if (status == null) {
                return false;
              }
              return status < 500;
            }),
      );
      final File file = File(localPath);
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      final Map<String, dynamic> _res = {
        "data": file,
        "statusCode": 200,
      };
      return _res;
    } on DioError catch (e) {
      Log.e(e);
      // responseJson = await _handleErrorResponse(e);
    } catch (e) {
      Log.e("Error in downlodng");
    }
  }

  _handleErrorResponse(DioError e) async {
    if (e.response?.statusCode == 401) {
      TokenExpireHandler().handleExpire();
    }
    if (e.toString().toLowerCase().contains("socketexception")) {
      throw NoInternetException('No Internet connection');
    } else {
      if (e.response != null) {
        return await _response(e.response!, "");
      } else {
        throw FetchDataException('An error occurred while fetching data.');
      }
    }
  }

  Future<Map<String, dynamic>> _response(Response response, String url,
      {bool cacheResult = false}) async {
    final Map<String, dynamic> res = response.data is Map ? response.data : {};

    final responseJson = <String, dynamic>{};
    responseJson['data'] = res;

    responseJson['statusCode'] = response.statusCode;
    switch (response.statusCode) {
      case 200:
        if (cacheResult) {
          try {
            // await SharedPref.setRestApiData(url, json.encode(res));
          } catch (e) {
            print(e);
          }
        }

        return responseJson;
      case 204:
        return responseJson;
      case 201:
        return responseJson;
      case 400:
        throw BadRequestException(
          getErrorMessage(res),
          response.statusCode,
        );
      case 401:
      case 402:
        throw UnauthorizedException(
          getErrorMessage(res),
          response.statusCode,
        );
      case 403:
        throw ForbittenException(
          getErrorMessage(res),
          response.statusCode,
        );
      case 404:
        throw ResourceNotFoundException(
            getErrorMessage(res), response.statusCode);
      case 409:
        throw ResourceNotFoundException(
          getErrorMessage(res),
          response.statusCode,
        );
      case 422:
        responseJson['error'] = getErrorMessage(res);
        throw BadRequestException(
          getErrorMessage(res),
          response.statusCode,
        );
      case 500:
        throw InternalServerErrorException(
          getErrorMessage(res),
          response.statusCode,
        );
      default:
        throw NoInternetException(
          'Error occured while Communication with Server',
          response.statusCode,
        );
    }
  }

  String getErrorMessage(dynamic res) {
    String message = "";
    try {
      debugPrint("-------------------GET ERROR ------------------");
      if (res["message"] is List) {
        final List<dynamic> messages = res['message'][0]["messages"];
        messages.forEach((dynamic element) {
          message += (element as Map<String, dynamic>)['message'] + '\n';
        });
      } else if (res["message"] is String) {
        message = res["message"];
      } else if (res["error"] is Map) {
        if (res["error"]["message"] is String) {
          message = res["error"]["message"];
        }
      }
    } catch (e) {
      return message;
    }
    return message;
  }
}
