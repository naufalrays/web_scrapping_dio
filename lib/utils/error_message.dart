import 'package:flutter/material.dart';

mixin ErrorMessage on ChangeNotifier {
  String? errorMessage;

  void setErrorMessage(String? message) {
    errorMessage = message;
    notifyListeners();
  }
}
