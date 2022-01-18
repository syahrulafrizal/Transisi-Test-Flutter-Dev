import 'dart:collection';
import 'package:transisi/api/login_api_listener.dart';
import 'package:transisi/helper/api_service_helper.dart';
import 'package:transisi/helper/constants.dart';

class LoginApiServices {
  LoginApiListener mApiListener;
  LoginApiServices(this.mApiListener);

  void onApiSuccess(responseBody, statusCode) {
    mApiListener.onLoginSuccess(
      responseBody,
      statusCode,
    );
  }

  void onApiFailure(responseBody, statusCode) {
    mApiListener.onLoginFailure(
      responseBody,
      statusCode,
    );
  }

  void onNoInternetConnection() {
    mApiListener.onNoInternetConnection();
  }

  postLogin(emailValue, passwordValue) async {
    HashMap data = HashMap<String, dynamic>();
    data['email'] = emailValue;
    data['password'] = passwordValue;
    ApiServiceHelper().service(
      data,
      Constants.METHOD_TYPE_POST,
      "login",
      onApiSuccess,
      onApiFailure,
      onNoInternetConnection,
    );
  }
}
