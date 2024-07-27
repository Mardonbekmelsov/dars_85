import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CameraController extends ChangeNotifier {
  Barcode? _result;
  QRViewController? _controller;
  bool _flashOn = false;

  Barcode? get result => _result;
  QRViewController? get controller => _controller;
  bool get flashOn => _flashOn;

  Future<void> checkPermissions() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
    var statusStorage = await Permission.storage.status;
    print(statusStorage);
    if (!statusStorage.isGranted || statusStorage.isDenied) {
      await Permission.storage.request();
    }
  }

  void setController(QRViewController controller) {
    _controller = controller;
    notifyListeners();
  }

  void setResult(Barcode result) {
    _result = result;
  }

  void toggleFlashIcon() async {
    await _controller!.toggleFlash();

    _flashOn = !_flashOn;
    notifyListeners();
  }

  void flipCamera() {
    _controller!.flipCamera();
  }

  void resumeCamera() {
    _controller!.resumeCamera();
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
