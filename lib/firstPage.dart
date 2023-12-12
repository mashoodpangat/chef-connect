import 'package:chef_connect_project/FadeAnimation/FadeAnimation.dart';
import 'package:chef_connect_project/kitchenOrderlogin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 2, 35, 70),
        body: SingleChildScrollView(
            child: FadeAnimation(
          1,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2 - 10,
                color: Colors.transparent,
                child: Center(
                    child: const Image(
                  image: AssetImage(
                    'assets/Voxo chef connect PNG.png',
                  ),
                  height: 90,
                )),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 35, top: 10),
                child: Text(
                  "Quickstart Your Food ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w600),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 35),
                child: Text(
                  "store Journey With Us",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 40,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(13), // <-- Radius
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 51, 138, 254)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => KitchenOrder(),
                              ));
                        },
                        child: const Text(
                          "Kitchen Order",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ))),
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 45,
                    width: Adaptive.w(40),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(13), // <-- Radius
                            ),
                            backgroundColor: const Color.fromARGB(
                              255,
                              4,
                              80,
                              156,
                            )),
                        onPressed: () {},
                        child: const Text(
                          "Kitchen display",
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        )),
                  ),
                  SizedBox(
                    height: 45,
                    width: Adaptive.w(40),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(13), // <-- Radius
                            ),
                            backgroundColor:
                                const Color.fromARGB(255, 232, 60, 48)),
                        onPressed: () {},
                        child: const Text(
                          "Settlement",
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const Center(
                  child: Text(
                "How was your experience",
                style: TextStyle(color: Colors.blue),
              )),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  height: 40,
                  width: 130,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(13), // <-- Radius
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 0, 165, 81)),
                      onPressed: () {},
                      child: const Text(
                        "Rate Now !",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Center(
                  child: Align(
                child: Text(
                  "Powered By",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              )),
              SizedBox(
                height: 33,
                child: TextButton(
                  onPressed: () {},
                  child: const Center(
                    child: Text(
                      "voxpro technologies",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 15.0,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                          color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
