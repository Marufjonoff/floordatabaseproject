import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LogService {
  static final instance = LogService();

  final _logger = Logger();
  final  _isDebugMode = !kReleaseMode;

  void info(message) {
    if(_isDebugMode) _logger.i(message);
  }

  void error(message) {
    if(_isDebugMode) _logger.e(message);
  }

  void doc(message) {
    if(_isDebugMode) _logger.d(message);
  }

  void warning(message) {
    if(_isDebugMode) _logger.w(message);
  }
}