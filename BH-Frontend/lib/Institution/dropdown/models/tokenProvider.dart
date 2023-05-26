import 'package:flutter/foundation.dart';

import '../services/login_service.dart';
import 'package:provider/provider.dart';


class TokenProvider extends ChangeNotifier {
   String _token = '';

  static TokenProvider? _instance;

  factory TokenProvider() {
    _instance ??= TokenProvider._internal();
    return _instance!;
  }

  TokenProvider._internal();

  String get token => _token;

  void setToken(String value) {
    _token = value;
    print("in clasa provider: $_token");
    notifyListeners();
  }

   @override
  String toString() {
    return 'TokenProvider{_token: $_token}';
  }
}
