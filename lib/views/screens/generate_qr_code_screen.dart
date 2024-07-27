import 'package:dars_85/views/screens/text_qr_screen.dart';
import 'package:flutter/material.dart';

class GenerateQrCodeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Generate QR"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Wrap(
          spacing: 40,
          children: [
            SizedBox(
              height: 100,
              width: 86,
              child: Stack(
                children: [
                  Positioned(
                    top: 11,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TextQrScreen()));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        height: 86,
                        width: 86,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: Colors.amber),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Image.asset("images/text_icon.png"),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 24,
                    child: Container(
                      height: 22,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.amber,
                      ),
                      child: const Center(
                        child: Text(
                          "Text",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
              width: 86,
              child: Stack(
                children: [
                  Positioned(
                    top: 11,
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      height: 86,
                      width: 86,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.amber),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.asset("images/website_icon.png"),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 12,
                    child: Container(
                      height: 22,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.amber,
                      ),
                      child: const Center(
                        child: Text(
                          "Website",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
              width: 86,
              child: Stack(
                children: [
                  Positioned(
                    top: 11,
                    child: Container(
                      padding: const EdgeInsets.all(25),
                      height: 86,
                      width: 86,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        border: Border.all(color: Colors.amber),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.asset("images/instagram.png"),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 5,
                    child: Container(
                      height: 22,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.amber,
                      ),
                      child: const Center(
                        child: Text(
                          "Instagram",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
