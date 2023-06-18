import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class InvalidProxyFormatException implements Exception {
  final String message;

  InvalidProxyFormatException(this.message);

  @override
  String toString() {
    return 'InvalidProxyFormatException: $message';
  }
}

class CustomProxy {
  final String ipAddress;
  final int? port;
  bool allowBadCertificates;

  CustomProxy({
    required this.ipAddress,
    this.port,
    this.allowBadCertificates = true,
  });

  static CustomProxy fromString(String proxy) {
    if (!_isValidProxy(proxy)) {
      throw InvalidProxyFormatException('Invalid proxy string format');
    }

    final proxyParts = proxy.split(':');
    final ipAddress = proxyParts[0];
    final port = proxyParts.length > 1 ? int.tryParse(proxyParts[1]) : null;

    return CustomProxy(
      ipAddress: ipAddress,
      port: port,
    );
  }

  static bool _isValidProxy(String proxy) {
    final RegExp proxyExp = RegExp(
        r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?))|localhost:([0-9]|[1-9][0-9]{1,3}|[1-5][0-9]{4}|6[0-5]{2}[0-3][0-5])$');
    return proxyExp.hasMatch(proxy);
  }

  @override
  String toString() => port == null ? '$ipAddress:8888' : '$ipAddress:$port';
}

extension DioProxyExtension on Dio {
  void setProxy(CustomProxy proxy) {
    (httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (client) {
      // Hook into the findProxy callback to set the client's proxy.
      client
        ..findProxy = (url) {
          return 'PROXY $proxy';
        }

        // This is a workaround to allow Proxyman to receive
        // SSL payloads when your app is running on Android.
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => Platform.isAndroid;
    };
  }

  void removeProxy() {
    (httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = null;
  }
}
