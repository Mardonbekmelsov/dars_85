import 'package:flutter/material.dart';

class QrController extends ChangeNotifier{
  String? _qrText;

  String? get qrText=>_qrText;

  void changeQR(String text){
    _qrText=text;
    notifyListeners();
  } 
}