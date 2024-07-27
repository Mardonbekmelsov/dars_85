import 'package:dars_85/controllers/camera_controller.dart';
import 'package:dars_85/views/screens/url_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrScreen extends StatefulWidget {
  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  CameraController? cameraController;

  void _onQRViewCreated(QRViewController controller) {
    cameraController!.setController(controller);
    cameraController!.controller!.scannedDataStream.listen((scanData) {
      cameraController!.setResult(scanData);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  UrlScreen(url: cameraController!.result!.code.toString())));
      cameraController!.controller!.stopCamera();
    });
  }

  @override
  void initState() {
    super.initState();

    cameraController = context.read<CameraController>();

    cameraController!.checkPermissions();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (cameraController!.controller != null) {
      if (defaultTargetPlatform == TargetPlatform.android) {
        cameraController!.controller!.pauseCamera();
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        cameraController!.controller!.resumeCamera();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff525252),
      body: Stack(
        children: [
          Positioned(
              left: 75,
              top: 60,
              child: Container(
                width: 250,
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 15,
                ),
                decoration:
                    const BoxDecoration(color: Colors.black, boxShadow: [
                  BoxShadow(color: Colors.black, blurRadius: 8),
                ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        cameraController!.flipCamera();
                      },
                      icon: const Icon(
                        CupertinoIcons.camera_rotate,
                        color: Colors.white,
                      ),
                    ),
                    Consumer<CameraController>(
                      builder: (context, controller, child) => IconButton(
                          onPressed: () {
                            cameraController!.toggleFlashIcon();
                          },
                          icon: cameraController!.flashOn
                              ? Icon(
                                  Icons.flash_on,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.flash_off,
                                  color: Colors.white,
                                )),
                    ),
                  ],
                ),
              )),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 300,
              width: 300,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }
}
