// ignore_for_file: constant_identifier_names

import 'dart:ui';

class Constants {
  static const String BASE_URL_CDN = 'https://cdn.hsse-rewulu.com/';
  static const String BASE_URL = 'https://reqres.in/api/';

  static const String METHOD_TYPE_POST = "POST";
  static const String METHOD_TYPE_GET = "GET";

  static const String TOKEN = "TOKEN";

  static const String NO_CONNECTION = 'Koneksi Internet Tidak Tersedia';
  static const String TIMEOUT = 'Timeout Request';
  static const String NODATA = "Tidak ada data yang ditampilkan";
  static const String ERROR_SERVER =
      'Maaf, sistem tidak memberikan respon. Silakan ulangi sekali lagi';

  static const ERROR_CONNECTION = "ERROR_CONNECTION";
  static const ERROR_SERVER_API = "ERROR_SERVER_API";
  static const ERROR_TIMEOUT = "ERROR_TIMEOUT";
  static const ERROR_NOT_FOUND = "ERROR_NOT_FOUND";

  static const Color PRIMARI_COLOR = Color(0xFF754A28);
  static const Color STATUS_BAR_COLOR = Color(0x4D000000);
  static const Color BACKGROUND_COLOR = Color(0xFFFAFAFA);
}
