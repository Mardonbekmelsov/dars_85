import 'package:dars_85/controllers/camera_controller.dart';
import 'package:dars_85/controllers/page_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  CustomPageController? pageController;
  CameraController? cameraController;

  @override
  void initState() {
    super.initState();
    cameraController = context.read<CameraController>();
    pageController = context.read<CustomPageController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CustomPageController>(
        builder: (context, value, child) =>
            pageController!.pages[pageController!.curIndex],
      ),
      bottomSheet: Consumer<CustomPageController>(
        builder: (context, controller, child) => Container(
          height: 110,
          width: 300,
          decoration: BoxDecoration(
            color: Color(0xff525252),
            boxShadow: [
              BoxShadow(color: Color(0xff525252), spreadRadius: 2),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: 300,
                  height: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(color: Colors.black, blurRadius: 8),
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          pageController!.changeIndex(0);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.qr_code_2,
                              color: pageController!.curIndex == 0
                                  ? Colors.amber
                                  : Colors.white,
                            ),
                            Text(
                              "Generate",
                              style: TextStyle(
                                  color: pageController!.curIndex == 0
                                      ? Colors.amber
                                      : Colors.white),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          pageController!.changeIndex(2);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.history,
                                color: pageController!.curIndex == 2
                                    ? Colors.amber
                                    : Colors.white),
                            Text(
                              "History",
                              style: TextStyle(
                                  color: pageController!.curIndex == 2
                                      ? Colors.amber
                                      : Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 115,
                bottom: 35,
                child: InkWell(
                  onTap: () {
                    pageController!.changeIndex(1);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 70,
                    width: 70,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(color: Colors.amber, blurRadius: 8)
                    ], shape: BoxShape.circle, color: Colors.amber),
                    child: Image.asset(
                      "images/splash_image.png",
                      fit: BoxFit.contain,
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
