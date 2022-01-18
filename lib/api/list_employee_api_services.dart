import 'dart:collection';
import 'package:transisi/helper/api_service_helper.dart';
import 'package:transisi/helper/constants.dart';
import 'list_employee_api_listener.dart';

class ListEmployeeApiServices {
  ListEmployeeApiListener mApiListener;
  ListEmployeeApiServices(this.mApiListener);

  void onApiSuccess(responseBody, statusCode) {
    mApiListener.onListEmployeeSuccess(
      responseBody,
      statusCode,
    );
  }

  void onApiFailure(responseBody, statusCode) {
    mApiListener.onListEmployeeFailure(
      responseBody,
      statusCode,
    );
  }

  void onNoInternetConnection() {
    mApiListener.onNoInternetConnection();
  }

  getListEmployee(page) async {
    HashMap data = HashMap<String, dynamic>();
    data['page'] = page;
    ApiServiceHelper().service(
      data,
      Constants.METHOD_TYPE_GET,
      "users",
      onApiSuccess,
      onApiFailure,
      onNoInternetConnection,
    );
  }
}
