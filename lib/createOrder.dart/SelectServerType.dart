import 'package:chef_connect_project/API/ApiProvider.dart';

import 'package:chef_connect_project/SelectTables.dart/selectTables.dart';

import 'package:chef_connect_project/styleUtils.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

String deliveryTtype = "";

late DataProvider serverprovider;

class ServerSelect extends StatefulWidget {
  const ServerSelect({super.key});

  @override
  State<ServerSelect> createState() => _ServerSelectState();
}

class _ServerSelectState extends State<ServerSelect> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});

    final serverprovider = Provider.of<DataProvider>(context, listen: false);
    serverprovider.getserverApi();
  }

  List indexnumber = [1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 5, 35, 69),
        body: Consumer<DataProvider>(builder: (context, value, child) {
          if (value.isLoading) {
            return Center(
              child: Lottie.asset(
                frameRate: FrameRate(60),
                height: 120,
                "assetslottie/Animation - 1697009692722.json",
              ),
            );
          } else {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 100,
                  color: Colors.transparent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.navigate_before,
                          size: 40,
                          color: Colors.white,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      // IconButton(
                      //     icon: Icon(
                      //       Icons.more_vert,
                      //       size: 30,
                      //       color: Colors.white,
                      //     ),
                      //     onPressed: () {
                      //       print(myLocation);
                      //       print(selectedIndex);
                      //     }),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    "SELECT SERVER TYPE",
                    style: TextStyle(
                        color: wcolor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: MediaQuery.of(context).size.height / 13,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 1),
                      color: Color.fromARGB(255, 24, 53, 85),
                      borderRadius: BorderRadius.circular(15)),
                  child: Row(
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Serving Time",
                                style: TextStyle(color: wcolor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                value.serverdata.serveTime,
                                style:
                                    TextStyle(color: Colors.blue, fontSize: 17),
                              ),
                            ),
                          ]),
                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        width: 200,
                        height: 50,
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 16, 37, 54),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 1,
                                  )),
                              child: Center(
                                  child: Text(
                                "Edit",
                                style: TextStyle(color: wcolor),
                              )),
                            ),
                            SizedBox(
                              width: 30,
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text(
                                  "Default",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.blue),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  flex: 2,
                  child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 400,
                              childAspectRatio: 4 / 1.2,
                              crossAxisSpacing: 25,
                              mainAxisSpacing: 20),
                      itemCount: 4,
                      itemBuilder: (BuildContext ctx, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),

                          child: GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: wcolor, width: 1),
                                  color: Color.fromARGB(255, 24, 53, 85),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 15, left: 15),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Chip(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            backgroundColor: maingreycolor,
                                            label: Text(
                                              indexnumber[index].toString(),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ),
                                          Text(
                                            value.serverdata.serveTypes[index]
                                                .serveType,
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Charges:" +
                                                value.serverdata
                                                    .serveTypes[index].charge
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.blueGrey[200]),
                                          ),
                                          SizedBox(
                                            height: 30,
                                            width: 70,
                                          ),
                                          Text(
                                            "Other Charges:" +
                                                value
                                                    .serverdata
                                                    .serveTypes[index]
                                                    .otherCharges
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.blueGrey[200]),
                                          )
                                        ],
                                      )
                                    ]),
                              ),
                            ),
                            onTap: () {
                              deliveryTtype =
                                  value.serverdata.serveTypes[index].serveType;
                              print(deliveryTtype);
                              // Provider.of<DataProvider>(context, listen: false)
                              //     .getTablesLocationApi(selectedIndex);

                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => SelectTables()));
                              Get.to(() => SelectTables(),
                                  transition: Transition.fade);
                            },
                          ),
                          // ),
                        );
                      }),
                )
              ],
            );
          }
        }));
  }
}
