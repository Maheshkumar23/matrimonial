import 'dart:convert';

import 'package:active_matrimonial_flutter_app/app_config.dart';
import 'package:active_matrimonial_flutter_app/helpers/aiz_api_request.dart';
import 'package:active_matrimonial_flutter_app/helpers/main_helpers.dart';
import 'package:active_matrimonial_flutter_app/models_response/auth/signin_response.dart';
import 'package:active_matrimonial_flutter_app/models_response/common_models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../helpers/shared_pref.dart';
import '../models_response/others/common_response.dart';

class AuthRepository {

  // Future<SignInResponse?> signIn(loginParameter ? loginParams) async {
  //
  //   Map<String, dynamic> map = {};
  //
  //   map['email_or_phone'] = loginParams?.email;
  //   map['password'] = loginParams?.password;
  //
  //   var baseUrl = "${AppConfig.BASE_URL}/signin";
  //
  //   var response = await http.post(Uri.parse(baseUrl),
  //      headers: {
  //       "Accept": "application/json",
  //       "Content-Type": "application/json",
  //       },
  //       body: ApiHelperMethod.serialize(map));
  //
  //   try {
  //     if (response.statusCode == 200) {
  //       return SignInResponse.fromJson(jsonDecode(response.body));
  //     }
  //   } catch (e) {
  //     throw Exception('failed to load');
  //   }
  //
  //   return SignInResponse();
  // }

  Future<SignInResponse?> signIn({email, password}) async {
    var baseUrl = "${AppConfig.BASE_URL}/signin";
    var postBody = jsonEncode({
      "email_or_phone": email,
      "password": password,
      "identity_matrix": AppConfig.purshase_code
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: postBody);
    return signInResponseFromJson(response.body);
  }

  Future<CommonResponse> changePassword({old, new_, confirm}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/change/password";
    var accessToken = SharedPref().accessToken;

    var postBody = jsonEncode({
      "old_password": old,
      "password": new_,
      "password_confirmation": confirm
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);
    return data;
  }

  Future<CommonResponse> deactivate({deactivate_status}) async {
    var baseUrl = "${AppConfig.BASE_URL}/member/account/deactivate";
    var accessToken = SharedPref().accessToken;
    var postBody = jsonEncode({"deacticvation_status": deactivate_status});

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);
    return data;
  }

  Future<CommonResponse> resetPassword(
      {required String sendBy,
      required String emailOrPhone,
      password,
      confirm_password,
      required String otp}) async {
    var baseUrl = "${AppConfig.BASE_URL}/reset/password";

    var postBody = jsonEncode({
      "send_code_by": sendBy,
      "email_or_phone": emailOrPhone,
      "verification_code": otp,
      "password": password,
      "password_confirmation": confirm_password
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);
    return data;
  }

  Future<CommonResponse> logout() async {
    var baseUrl = "${AppConfig.BASE_URL}/logout";

    var accessToken = SharedPref().accessToken;

    var response = await http.post(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = commonResponseFromJson(response.body);
    return data;
  }

  Future<CommonResponse> accountDelete() async {
    var baseUrl = "${AppConfig.BASE_URL}/member/account/delete";

    var accessToken = SharedPref().accessToken;

    var response = await http.post(Uri.parse(baseUrl), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $accessToken"
    });

    var data = commonResponseFromJson(response.body);
    return data;
  }

  Future<SignInResponse> postSignUp(
      {firstName,
      lastName,
      emailOrPhone,
      emailOrPhoneText,
      onBehalf,
      gender,
      dateOfBirth,
      password,
      passwordConfirmation,
      recapthca,
      referral}) async {
    var baseUrl = "${AppConfig.BASE_URL}/signup";
    var postBody = jsonEncode({
      'first_name': firstName,
      'last_name': lastName,
      '${emailOrPhoneText}': emailOrPhone,
      'on_behalf': onBehalf,
      'gender': gender,
      'date_of_birth': dateOfBirth,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'referral_code': referral,
      'g-recaptcha-response': recapthca
    });
    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: postBody);

    return signInResponseFromJson(response.body);
  }

  Future<CommonResponse> verify({code}) async {
    var baseUrl = "${AppConfig.BASE_URL}/verify/code";
    var postBody = jsonEncode({"verification_code": code});

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer $getToken"
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);
    return data;
  }

  Future<CommonResponse> resendVerifyCode() async {
    var baseUrl = "${AppConfig.BASE_URL}/resend-verify/code";

    var response = await AizApi.get(
      Uri.parse(baseUrl),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json",
        "Authorization": "Bearer $getToken"
      },
    );

    var data = commonResponseFromJson(response.body);
    return data;
  }

  Future<CommonResponse> forgetPassword({send_by, email}) async {
    var baseUrl = "${AppConfig.BASE_URL}/forgot/password";

    var postBody =
        jsonEncode({"send_code_by": send_by, "email_or_phone": email});

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: postBody);

    var data = commonResponseFromJson(response.body);
    return data;
  }

  Future<SignInResponse> socialLogin({
    email,
    name,
    provider,
    secret_token = "",
    social_provider,
    access_token = "",
  }) async {
    var baseUrl = "${AppConfig.BASE_URL}/social-login";

    var postBody = jsonEncode({
      "email": email,
      "name": name,
      "provider": provider,
      "social_provider": social_provider,
      "secret_token": secret_token,
      "access_token": access_token
    });

    var response = await http.post(Uri.parse(baseUrl),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
        body: postBody);

    var data = signInResponseFromJson(response.body);
    return data;
  }

  Future<User> getAuthData() async {
    var baseUrl = "${AppConfig.BASE_URL}/user-by-token";
    var accessToken = SharedPref().accessToken;

    var response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $accessToken",
      },
    );

    print(response.body);
    // print(response.body);
    var data = userFromJson(response.body);
    return data;
  }
}


class ApiHelperMethod {
  @protected
  static String serialize(Object? obj) {
    String serialized = '';
    if (obj == null) {
      serialized = '';
    } else {
      serialized = json.encode(obj);
    }
    return serialized;
  }

  @protected
  ErrorResponse handleConnectionError() {
    var result = ErrorResponse();
    result.statusCode = 502;
    result.message = "There is a problem connecting to the server.";
    return result;
  }

  @protected
  Future<ErrorResponse?> handleApiError(
      http.Response response, bool tokenError) async {
    if ((tokenError && response.statusCode == 400) ||
        response.statusCode == 401) {
      return null;
    }

    Map<String, dynamic>? responseJObject;
    if (_isJsonResponse(response)) {
      responseJObject = json.decode(response.body);
    }
    return ErrorResponse.fromResponse(
        responseJObject, response.statusCode, tokenError);
  }

  bool _isJsonResponse(http.Response response) {
    return (response.headers["content-type"]?.contains("json")) == true;
  }
}

class ErrorResponse {

  String? message;
  Map<String, List<String>>? validationErrors;
  int? statusCode;

  ErrorResponse();

  ErrorResponse.fromResponse(Map<String, dynamic>? response, int statusCode, [bool identityResponse = false]) {
    var errorModel;
    if (response != null) {
      if (response.containsKey("error")) {
        errorModel = _ErrorModel.fromJson(response["error"]);
      }
      else {
        print("dfsssfsfs");
        errorModel = _ErrorModel.fromJson(response);
      }
    }
    if (errorModel != null) {
      message = errorModel.message;
      validationErrors = errorModel.errors;
    }
    statusCode = statusCode;
  }

  String getSingleMessage() {
    print(message);
    if (validationErrors == null) {
      return message ?? '';
    }
    return message ?? '';
  }
  @override
  String toString() {
    return message ?? '' + getSingleMessage();
  }
}

class _ErrorModel {

  String? message;
  Map<String, List<String>>? errors;

  _ErrorModel.fromJson(Map<String, dynamic> json) {
    errors =  Map<String, List<String>>();

    /* if (json['message'] is List) {
      message = (json['message'] as List)?.first ?? "No Message";
    }*/
    if (json["message"] is List<dynamic>) {
      List data = json["message"] as List<dynamic>;
      message = data[0].toString();
    }
    else if (json['message'] is String) {
      message = json['message'];
    }

    if (json['error']!=null){
      for (var key in json['error'].keys) {
        errors?[key] = List<String>.from(json['error'][key]);
      }
    }

  }
}