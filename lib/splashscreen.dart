import 'dart:async';

import 'package:chef_connect_project/API/Stateprovider.dart';
import 'package:chef_connect_project/FadeAnimation/FadeAnimation.dart';
import 'package:chef_connect_project/FoodItemCategories/SubCategories.dart';
import 'package:chef_connect_project/firstPage.dart';
import 'package:chef_connect_project/homepage/homepage.dart';
import 'package:chef_connect_project/kitchenOrderlogin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splashscreen extends StatefulWidget {
  splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

String apidomine = "";

class _splashscreenState extends State<splashscreen> {
  TextEditingController domaincontroller = TextEditingController();

  @override
  void dispose() {
    domaincontroller.dispose();

    super.dispose();
  }

  void savetextfield() {
    Provider.of<Stateprovider>(context, listen: false)
        .setApidomine(domaincontroller.text);
    // setState(() {
    //   apidomine = domaincontroller.text;
    // });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});

    loadSharedPrefs().then((_) {
      if (mounted) {
        if (apidomine.isEmpty) {
          domaincontroller.text = apidomine;
          domaincontroller.addListener(savetextfield);
          Timer(const Duration(seconds: 3), () {
            if (mounted) {
              _showDialog();
            }
          });
        } else {
          Stateprovider().getApiKey().then((value) {
            if (mounted) {
              // Check if the widget is still mounted
              if (apidomine.isNotEmpty &&
                  apikey.isNotEmpty &&
                  username.isNotEmpty) {
                Future.delayed(const Duration(seconds: 2), () {
                  if (mounted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => homepage()),
                    );
                  }
                });
              } else if (apikey.isEmpty && username.isEmpty) {
                Future.delayed(const Duration(seconds: 2), () {
                  if (mounted) {
                    Get.to(() => FirstPage());
                  } else {
                    return null;
                  }
                });
              }
            }
          });
        }
      } else {
        return null;
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 5, 35, 69),
      body: Column(
        children: [
          Expanded(
            child: FadeAnimation(
              1,
              Center(
                child: const Image(
                  image: AssetImage('assets/Voxo chef connect PNG.png'),
                  height: 90,
                ),
              ),
            ),
          ),
          Text(
            "Powered By",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: const Image(
              image: AssetImage('assets/voxprotechnologypng.png'),
              height: 30,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loadSharedPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedApidomine = prefs.getString('apidomine') ?? "";
    Provider.of<Stateprovider>(context, listen: false)
        .setApidomine(savedApidomine);
    domaincontroller.text = savedApidomine;
  }

  Future<void> saveapidomineSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('apidomine', domaincontroller.text);
  }

  _showDialog() async {
    await showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              contentPadding: const EdgeInsets.only(left: 8, right: 8),
              title: const Center(
                child: Text(
                  "Setup domain",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              content: TextField(
                controller: domaincontroller,
              ),
              actions: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                        child: const Text('setup'),
                        onPressed: () async {
                          String inputDomain = domaincontroller.text;
                          if (inputDomain.isNotEmpty) {
                            print(apidomine);
                            savetextfield();

                            await saveapidomineSF();
                            print("myapi" + apidomine);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FirstPage()));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                elevation: 10,
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.red,
                                content: Text('Domain field is empty'),
                              ),
                            );
                          }
                        }),
                  ),
                )
              ],
            ));
  }
}
