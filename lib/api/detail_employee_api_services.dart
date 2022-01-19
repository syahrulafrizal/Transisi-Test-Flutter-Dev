import 'dart:collection';
import 'package:transisi/helper/api_service_helper.dart';
import 'package:transisi/helper/constants.dart';
import 'detail_employee_api_listener.dart';

class DetailEmployeeApiServices {
  DetailEmployeeApiListener mApiListener;
  DetailEmployeeApiServices(this.mApiListener);

  void onApiSuccess(responseBody, statusCode) {
    mApiListener.onDetailEmployeeSuccess(
      responseBody,
      statusCode,
    );
  }

  void onApiFailure(responseBody, statusCode) {
    mApiListener.onDetailEmployeeFailure(
      responseBody,
      statusCode,
    );
  }

  void onNoInternetConnection() {
    mApiListener.onNoInternetConnection();
  }

  getDetailEmployee(id) async {
    HashMap data = HashMap<String, dynamic>();
    ApiServiceHelper().service(
      data,
      Constants.METHOD_TYPE_GET,
      "users/$id",
      onApiSuccess,
      onApiFailure,
      onNoInternetConnection,
    );
  }
}
