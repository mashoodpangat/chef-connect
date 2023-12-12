import 'dart:convert';

import 'package:chef_connect_project/FadeAnimation/FadeAnimation.dart';
import 'package:chef_connect_project/homepage/homepage.dart';
import 'package:chef_connect_project/splashscreen.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:pelaicons/pelaicons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KitchenOrder extends StatefulWidget {
  KitchenOrder({super.key});

  @override
  State<KitchenOrder> createState() => _KitchenOrderState();
}

late SharedPreferences prefs;

String apikey = "";
String username = "";
String password = "";

Future<void> storeApiKey() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("api_key", apikey);
  await prefs.setString("UserName", username);
  print('API Key stored successfully!');
  print("STORED:" + apikey);
}

class _KitchenOrderState extends State<KitchenOrder> {
  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passcontroller = TextEditingController();

  bool _isLoading = false;

  Future<void> login() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    // final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    if (passcontroller.text.isNotEmpty && emailcontroller.text.isNotEmpty) {
      var response = await http.post(Uri.parse(apidomine + "user_login"),
          body: ({'username': username, 'password': password}));
      if (mounted) {
        if (response.statusCode == 200) {
          print(response);
          print(username);
          print(password);
          print(response.statusCode);
          print(response.body);
          final data = json.decode(response.body);
          print(data["error"]);
          // print(data["data"]["api_key"]);
          apikey = data["data"]["api_key"];
          print('my:' + apikey);
          // data(["data"]);
          if (data["error"] == false) {
            storeApiKey();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => homepage(),
                ));
          } else {
            // print('ooooooooooooo');
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text("Invalid username or password"),
            //   duration: Duration(seconds: 1),
            //   backgroundColor: Colors.red,
            // ));

            showDialog(
                context: context,
                builder: (context) {
                  Future.delayed(
                    Duration(seconds: 2),
                    () {
                      Navigator.of(context).pop(true);
                    },
                  );
                  return Dialog(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Lottie.asset(
                              frameRate: FrameRate(60),
                              height: 100,
                              "assetslottie/Animation - 1696414804264.json"),
                          Text(
                            "Invalid username or password",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  );
                });
          }
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("empty"),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.red,
      ));
    }
    if (mounted) {
      setState(() {
        _isLoading = false; // Stop loading
      });
    }
  }

  @override
  void dispose() {
    passcontroller.dispose();
    emailcontroller.dispose();
    // emailcontroller.clear();
    // passcontroller.clear();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 2, 35, 70),
      body: SingleChildScrollView(
          child: FadeAnimation(
        1.5,
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.8,
              color: Colors.transparent,
              child: Center(
                  child: const Image(
                image: AssetImage(
                  'assets/Voxo chef connect PNG.png',
                ),
                height: 90,
              )),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width - 30,
              height: MediaQuery.of(context).size.height / 2.2,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      blurStyle: BlurStyle.normal,
                      color: Colors.black54)
                ],
                color: Color.fromARGB(255, 18, 38, 62),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 25),
                    child: Text(
                      "Kitchen Order  >>",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, top: 4),
                    child: Text(
                      "Welcome Back",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25,
                    ),
                    child: Text("Login back into your account",
                        style: TextStyle(
                          color: Colors.white60,
                        )),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 80,
                      child: TextField(
                          controller: emailcontroller,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixIconColor: Colors.white,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white54),
                            ),
                            prefixIcon:
                                Icon(Pelaicons.user_added_light_outline),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 80,
                      child: TextField(
                          controller: passcontroller,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixIconColor: Colors.white,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white54),
                            ),
                            prefixIcon: Icon(Pelaicons.key_light_outline),
                          )),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width - 80,
                      height: MediaQuery.of(context).size.height / 9.5,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            backgroundColor: Color.fromARGB(255, 0, 165, 81),
                          ),
                          onPressed: _isLoading
                              ? null
                              : () {
                                  username = emailcontroller.text;
                                  password = passcontroller.text;
                                  print(apidomine);
                                  login();
                                },
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Text(
                                  "Log In",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.3,
                        height: MediaQuery.of(context).size.height / 18,
                        color: Colors.transparent,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.6,
                        height: MediaQuery.of(context).size.height / 19,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  blurStyle: BlurStyle.normal,
                                  color: Colors.black54)
                            ],
                            color: Color.fromARGB(255, 18, 38, 62),
                            borderRadius: BorderRadius.circular(6)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 25,
                            top: 12,
                          ),
                          child: Text(
                            "how was your experience",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                      Positioned(
                          left: MediaQuery.of(context).size.width / 2.1 + 3,
                          child: SizedBox(
                              height: 38,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 6),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Rate Now!",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 0, 165, 81),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              )))
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "A initiative of",
              style: TextStyle(color: Colors.white, fontSize: 10),
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
      )),
    );
  }
}
