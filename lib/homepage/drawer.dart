import 'package:chef_connect_project/API/ApiProvider.dart';
import 'package:chef_connect_project/homepage/homepage.dart';
import 'package:chef_connect_project/itemOrder/Ordermanagement.dart';
import 'package:chef_connect_project/splashscreen.dart';
import 'package:chef_connect_project/styleUtils.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pelaicons/pelaicons.dart';
import 'package:provider/provider.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Consumer<DataProvider>(
          builder: (context, value, child) {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Color.fromARGB(255, 5, 35, 69),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 250),
                    child: IconButton(
                      color: Colors.white,
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Icon(
                        Icons.close,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(
                      value.data2.data.user_details.user_name,
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "ID :",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Update my voxpro',
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InkWell(
                    child: ListTile(
                      iconColor: Colors.blue[200],
                      leading: Icon(
                        Pelaicons.cart_3_light_outline,
                        size: 30,
                      ),
                      title: Text(
                        "Orders",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await Get.to(() => OrderManagementPage(),
                          transition: Transition.fade);
                      Navigator.of(context).pop();
                    },
                    child: ListTile(
                      iconColor: Colors.blue[200],
                      leading: Icon(
                        Pelaicons.cart_2_light_outline,
                        size: 30,
                      ),
                      title: Text(
                        "Orders Managment",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13),
                    child: DottedLine(
                      dashColor: Colors.white,
                      lineLength: double.infinity,
                      lineThickness: 1.5,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, left: 20, right: 20),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.width / 6,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 4, 28, 52),
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: Icon(
                          Pelaicons.message_align_left_light_outline,
                          color: Colors.white,
                          size: 30,
                        ),
                        title: Text("Pass enquiry to the chef?",
                            style:
                                TextStyle(color: Colors.white, fontSize: 14)),
                        subtitle: Text(
                          "Chat Now  >>",
                          style: TextStyle(
                              color: Colors.blue[300],
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 237,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(13),
                    child: DottedLine(
                      dashColor: Colors.white,
                      lineLength: double.infinity,
                      lineThickness: 1.5,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Pelaicons.equalizer_settings_light_outline,
                      size: 30,
                      color: Colors.blue[200],
                    ),
                    title: Text(
                      "Settings  ",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Pelaicons.close_light_outline,
                      size: 30,
                      color: Colors.blue[200],
                    ),
                    title: Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () async {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 16),
                              decoration: BoxDecoration(
                                color: wcolor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 100,
                                    width: 100,
                                    color: Colors.transparent,
                                    child: Lottie.asset(
                                      "assetslottie/log out 3.json",
                                    ),
                                  ),
                                  Text(
                                    "Are you Sure ?",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey[600],
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                          ),
                                          child: Text(
                                            "No",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        height: 40,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            // logout();
                                            await clearApiKey();
                                            Get.to(
                                              () => splashscreen(),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: maincolor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                          ),
                                          child: Text(
                                            "Yes",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// void logout() {
//   apidomine = "";
// }
