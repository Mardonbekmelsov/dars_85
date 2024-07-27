import 'package:dars_85/views/screens/generate_qr_code_screen.dart';
import 'package:dars_85/views/screens/history_screen.dart';
import 'package:dars_85/views/screens/scan_qr_screen.dart';
import 'package:flutter/cupertino.dart';

class CustomPageController extends ChangeNotifier {
  final List<Widget> _pages = [
    GenerateQrCodeScreen(),
    ScanQrScreen(),
    HistoryScreen()
  ];
  int _curIndex = 1;

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  void changeIndex(int index) {
    _curIndex = index;
    notifyListeners();
  }

  int get curIndex => _curIndex;
  List<Widget> get pages => _pages;
}
