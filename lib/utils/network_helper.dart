import 'dart:io';

class NetworkHelper {
  static Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true; // يوجد إنترنت
      }
    } on SocketException catch (_) {
      return false; // لا يوجد إنترنت
    }
    return false;
  }
}
