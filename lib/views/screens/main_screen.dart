import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool flashOn = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void toggleFlashIcon() async {
    await controller!.toggleFlash();
    setState(() {
      flashOn = !flashOn;
    });
  }

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      if (defaultTargetPlatform == TargetPlatform.android) {
        controller!.pauseCamera();
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        controller!.resumeCamera();
      }
    }
  }

  Future<void> launchLinks(String _link,
      {LaunchMode launchMode = LaunchMode.platformDefault}) async {
    if (await canLaunchUrl(Uri.parse(_link))) {
      await launchUrl(Uri.parse(_link), mode: launchMode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              left: 75,
              top: 60,
              child: Container(
                width: 250,
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        controller!.flipCamera();
                      },
                      icon: Icon(
                        CupertinoIcons.camera_rotate,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          toggleFlashIcon();
                        },
                        icon: flashOn
                            ? Icon(
                                Icons.flash_on,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.flash_off,
                                color: Colors.white,
                              )),
                  ],
                ),
              )),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 300,
              width: 300,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: 300,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      // Handle generate action
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.qr_code_2,
                          color: Colors.white,
                        ),
                        Text(
                          "Generate",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      // Handle history action
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.history,
                          color: Colors.white,
                        ),
                        Text(
                          "History",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 35,
            bottom: 50,
            child: InkWell(
              onTap: result == null
                  ? null
                  : () async {
                      await launchLinks(result!.code.toString());
                    },
              child: Container(
                padding: EdgeInsets.all(10),
                height: 70,
                width: 70,
                clipBehavior: Clip.hardEdge,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.amber),
                child: Image.asset(
                  "images/splash_image.png",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Positioned(
            left: 70,
            bottom: 150,
            child: result == null
                ? Text("Not scanned yet")
                : InkWell(
                    onTap: () {
                      launchLinks(result!.code.toString());
                    },
                    child: Text(
                      "${result!.code}",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
