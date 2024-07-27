import 'dart:io';

import 'package:dars_85/controllers/qr_controller.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WebsiteQrScreen extends StatefulWidget {
  @override
  State<WebsiteQrScreen> createState() => _WebsiteQrScreenState();
}

class _WebsiteQrScreenState extends State<WebsiteQrScreen> {
  final textController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  QrController? qrController;

  @override
  void initState() {
    super.initState();
    qrController = context.read<QrController>();
  }

  Future<void> saveQrCode(String data) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        // Generate the QR code
        final qrCode = QrPainter(
          data: data,
          version: QrVersions.auto,
          gapless: false,
        );

        // Get temporary directory
        final tempDir = await getTemporaryDirectory();
        final tempPath = '${tempDir.path}/qr_code.png';

        // Save the QR code to a temporary file
        final picData = await qrCode.toImageData(300);
        final buffer = picData!.buffer.asUint8List();
        final file = await File(tempPath).writeAsBytes(buffer);

        // Save the file to the gallery
        await GallerySaver.saveImage(file.path);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('QR Code saved to gallery!')),
        );
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save QR Code')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission is denied')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff525252),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Container(
                      padding:
                          const EdgeInsets.only(left: 8, top: 4, bottom: 4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  const Text(
                    "Text",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 200,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border(
                    top: BorderSide(
                      color: Colors.amber,
                    ),
                    bottom: BorderSide(
                      color: Colors.amber,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          child: Image.asset(
                            "images/text_icon.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Text",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      controller: textController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        hintText: "Enter Text",
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Text";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: FilledButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(10),
                          backgroundColor: Colors.amber,
                        ),
                        onPressed: () {
                          qrController!.changeQR(textController.text);
                        },
                        child: Text(
                          "Generate QR Code",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    qrController!.qrText != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              QrImageView(
                                backgroundColor: Colors.white,
                                data: qrController!.qrText!,
                                size: 170,
                              ),
                            ],
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 15,
                    ),
                    qrController!.qrText != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FilledButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.all(10),
                                  backgroundColor: Colors.amber,
                                ),
                                onPressed: () async {
                                  // qrController!.changeQR(textController.text);
                                  await saveQrCode(textController.text);
                                },
                                child: Text(
                                  "Save To Gallery",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
