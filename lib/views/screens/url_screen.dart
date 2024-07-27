import 'package:dars_85/controllers/camera_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlScreen extends StatefulWidget {
  String url;
  UrlScreen({required this.url});

  @override
  State<UrlScreen> createState() => _UrlScreenState();
}

class _UrlScreenState extends State<UrlScreen> {
  Future<void> launchLinks(String link,
      {LaunchMode launchMode = LaunchMode.platformDefault}) async {
    if (await canLaunchUrl(Uri.parse(link))) {
      await launchUrl(Uri.parse(link), mode: launchMode);
    }
  }

  CameraController? cameraController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cameraController = context.read<CameraController>();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        cameraController!.resumeCamera();
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 300,
                  child: Text(
                    widget.url,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 100,
                left: 40,
                child: InkWell(
                  onTap: () {
                    launchLinks(widget.url);
                  },
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade300),
                    child: Center(
                      child: Text(
                        "Launch This URL",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 40,
                left: 40,
                child: InkWell(
                  onTap: () async {
                    await Clipboard.setData(ClipboardData(text: widget.url));
                  },
                  child: Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade300),
                    child: Center(
                      child: Text(
                        "Copy To Clipboard",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
