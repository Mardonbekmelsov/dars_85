import 'package:dars_85/controllers/camera_controller.dart';
import 'package:dars_85/controllers/page_controller.dart';
import 'package:dars_85/controllers/qr_controller.dart';
import 'package:dars_85/views/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? user;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CameraController()),
          ChangeNotifierProvider(create: (context) => CustomPageController()),
          ChangeNotifierProvider(create: (context) => QrController()),
        ],
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        });
  }
}
