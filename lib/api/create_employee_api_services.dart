import 'dart:collection';
import 'package:transisi/helper/api_service_helper.dart';
import 'package:transisi/helper/constants.dart';
import 'create_employee_api_listener.dart';

class CreateEmployeeApiServices {
  CreateEmployeeApiListener mApiListener;
  CreateEmployeeApiServices(this.mApiListener);

  void onApiSuccess(responseBody, statusCode) {
    mApiListener.onCreateEmployeeSuccess(
      responseBody,
      statusCode,
    );
  }

  void onApiFailure(responseBody, statusCode) {
    mApiListener.onCreateEmployeeFailure(
      responseBody,
      statusCode,
    );
  }

  void onNoInternetConnection() {
    mApiListener.onNoInternetConnection();
  }

  postCreateEmployee(
    String avatar,
    String name,
    String job,
    String phonenumber,
    String email,
  ) async {
    HashMap data = HashMap<String, dynamic>();
    data['name'] = name;
    data['job'] = job;
    data['avatar'] = avatar;
    data['phonenumber'] = phonenumber;
    data['email'] = email;
    ApiServiceHelper().service(
      data,
      Constants.METHOD_TYPE_POST,
      "users",
      onApiSuccess,
      onApiFailure,
      onNoInternetConnection,
    );
  }
}
