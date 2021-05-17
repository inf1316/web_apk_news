import 'dart:io';

// See more: https://pub.dev/packages/dio - Https certificate verification
// See more: https://www.gitmemory.com/issue/flutter/flutter/19588/531491751
class CustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host,
          int port) => true;
  }
}