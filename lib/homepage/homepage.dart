import 'package:chef_connect_project/API/ApiProvider.dart';
import 'package:chef_connect_project/API/GetxProvider/Getxprovider.dart';
import 'package:chef_connect_project/API/Stateprovider.dart';
import 'package:chef_connect_project/SelectTables.dart/selectTables.dart';
import 'package:chef_connect_project/SelectTables.dart/tablegridview.dart';
import 'package:chef_connect_project/createOrder.dart/SelectServerType.dart';
import 'package:chef_connect_project/homepage/drawer.dart';
import 'package:chef_connect_project/itemOrder/Ordermanagement.dart';
import 'package:chef_connect_project/itemOrder/orders.dart';
import 'package:chef_connect_project/splashscreen.dart';
import 'package:chef_connect_project/styleUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconic/iconic.dart';
import 'package:lottie/lottie.dart';
import 'package:pelaicons/pelaicons.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;

late DataProvider dataProvider;

late Stateprovider apikeyprovider;
late DataProvider activeOrderprovider;

String storedApi = "";

Future<void> clearApiKey() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove("api_key");
  prefs.remove("UserName");
  print('API Key cleared!');
}

class homepage extends StatefulWidget {
  homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  DateTime timeBackPressed = DateTime.now();

  // MyGetx mygetxController = Get.put(MyGetx());
  @override
  Widget build(BuildContext context) {
    activeOrderprovider = Provider.of<DataProvider>(context, listen: false);
    activeOrderprovider.GetActiveOrders();
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    dataProvider.getHomeApi();

    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(timeBackPressed);
        timeBackPressed = DateTime.now();
        final isExitwarnig = difference >= Duration(seconds: 2);

        print(difference);

        if (isExitwarnig) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              elevation: 10,
              backgroundColor: Colors.red[800],
              duration: Duration(seconds: 2),
              content: Text('press back again to exit'),
            ),
          );
          return false;
        } else {
          return await showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return Dialog(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
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
                            "assetslottie/alert.json",
                          ),
                        ),
                        Text(
                          "Do you want to exit ?",
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade600,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                child: Text(
                                  "No",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 100,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () async {
                                  SystemNavigator.pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: maincolor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                ),
                                child: Text(
                                  "Yes",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        }
      },
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 3));
          activeOrderprovider =
              Provider.of<DataProvider>(context, listen: false);
          activeOrderprovider.GetActiveOrders();
          final dataProvider =
              Provider.of<DataProvider>(context, listen: false);
          dataProvider.getHomeApi();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: const DrawerPage(),
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Image.asset(
                "assets/Voxo chef connect PNG.png",
                scale: 11,
              ),
            ),
            leading: Builder(builder: (context) {
              return IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icon(
                  Pelaicons.menu_light_outline,
                  color: Colors.white,
                ),
              );
            }),
            actions: [
              // Consumer<Stateprovider>(
              //   builder: (context, value, child) {
              //     return IconButton.outlined(
              //       onPressed: () {
              //         // homeAPI();
              //         // value.getApiKey();
              //         // DataProvider().getApi();
              //         // print(selectedProducts);
              //         // print(selectedProducts);
              //         // print(order_idd);
              //         // print(invoice_type);
              //         print("cart master=${cart_masterId}");
              //         print("order id=${order_idd}");
              //         print("invoice=${invoicenumber}");
              //         print("selected products=${selectedProducts}");
              //         print("invoice type=${invoice_type}");
              //         print("DeliveryType=${deliveryTtype}");
              //         print("location=${myLocation}");
              //         print("tableId=${tableId}");
              //         print("tablename=${TableName}");
              //         print("tableindex=${tableindex}");

              //         print(timeBackPressed);
              //       },
              //       icon: const Icon(Icons.message),
              //       color: Colors.white,
              //     );
              //   },
              // ),
              // IconButton(
              //     onPressed: () async {
              //       await clearApiKey();
              //       Navigator.of(context).push(MaterialPageRoute(
              //         builder: (context) => splashscreen(),
              //       ));
              //     },
              //     icon: const Icon(
              //       Icons.logout,
              //       color: wcolor,
              //     ))
            ],
            backgroundColor: const Color.fromARGB(255, 5, 35, 69),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 11,
                child: SingleChildScrollView(
                  child: Consumer<DataProvider>(
                    builder: (context, value, child) {
                      if (value.isLoading) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height / 1.3,
                          child: Center(
                            child: Lottie.asset(
                              frameRate: FrameRate(60),
                              height: 120,
                              "assetslottie/Animation - 1697009692722.json",
                            ),
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      value.data2.data.ongoing_tables.length <=
                                              2
                                          ? 300
                                          : MediaQuery.of(context).size.height -
                                              300,
                                  color:
                                      const Color.fromARGB(255, 231, 242, 247),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.only(top: 60, left: 20),
                                        child: Text(
                                          "Ongoing Tables",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20))),

                                          //height: height.length<20?null:290,
                                          child: Center(
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  20,
                                              height: double.infinity,
                                              color: Colors.transparent,
                                              child: GridView.builder(
                                                  physics: ScrollPhysics(),

                                                  // physics: NeverScrollableScrollPhysics(),
                                                  gridDelegate:
                                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                                          maxCrossAxisExtent:
                                                              200,
                                                          childAspectRatio:
                                                              3 / 2.2,
                                                          crossAxisSpacing: 0,
                                                          mainAxisSpacing: 0),
                                                  itemCount: value.data2.data
                                                      .ongoing_tables.length,
                                                  itemBuilder:
                                                      (BuildContext ctx,
                                                          index) {
                                                    TextStyle textStyle;

                                                    if (value
                                                            .data2
                                                            .data
                                                            .ongoing_tables[
                                                                index]
                                                            .invoiceType ==
                                                        "SO") {
                                                      textStyle = TextStyle(
                                                        fontSize: 19,
                                                        color:
                                                            Colors.green[700],
                                                      );
                                                    } else {
                                                      textStyle = TextStyle(
                                                        fontSize: 19,
                                                        color: Colors.red[900],
                                                      );
                                                    }
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8,
                                                              right: 8,
                                                              top: 8),
                                                      child: GestureDetector(
                                                        onTap: value.isLoading
                                                            ? null
                                                            : () {
                                                                order_idd = value
                                                                    .ActiveOrders
                                                                    .data
                                                                    .orders[
                                                                        index]
                                                                    .orderId;

                                                                invoicenumber = value
                                                                    .ActiveOrders
                                                                    .data
                                                                    .orders[
                                                                        index]
                                                                    .invoiceNumber;
                                                                invoice_type = value
                                                                    .ActiveOrders
                                                                    .data
                                                                    .orders[
                                                                        index]
                                                                    .invoiceType;

                                                                cart_masterId = value
                                                                    .ActiveOrders
                                                                    .data
                                                                    .orders[
                                                                        index]
                                                                    .orderId;

                                                                TableName = value
                                                                    .ActiveOrders
                                                                    .data
                                                                    .orders[
                                                                        index]
                                                                    .tableNo;

                                                                print(
                                                                    order_idd);
                                                                print(
                                                                    invoicenumber);
                                                                print(
                                                                    invoice_type);

                                                                if (value
                                                                        .ActiveOrders
                                                                        .data
                                                                        .orders[
                                                                            index]
                                                                        .invoiceType ==
                                                                    "SO") {
                                                                  Provider.of<DataProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .GetActiveOrdersById(
                                                                          context);
                                                                  // Obx() {
                                                                  //   mygetxController
                                                                  //       .GetActiveOrdersById();
                                                                  // }
                                                                } else {
                                                                  Provider.of<DataProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .GetCartOrdersById(
                                                                          context);
                                                                }

                                                                // Navigator.of(context)
                                                                //     .push(
                                                                //         MaterialPageRoute(
                                                                //   builder: (context) =>
                                                                //       const OrdersPage(),
                                                                // ));
                                                              },
                                                        child: value.isLoading
                                                            ? CircularProgressIndicator(
                                                                valueColor:
                                                                    AlwaysStoppedAnimation<
                                                                            Color>(
                                                                        Colors
                                                                            .white),
                                                              )
                                                            : Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            5),
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                            color: Color.fromARGB(
                                                                                255,
                                                                                182,
                                                                                193,
                                                                                198),
                                                                            blurStyle:
                                                                                BlurStyle.normal,
                                                                            blurRadius: 5)
                                                                      ],
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15)),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(left: 5, top: 5),
                                                                            child:
                                                                                Text(
                                                                              "Order:${value.data2.data.ongoing_tables[index].order_id}",
                                                                              style: TextStyle(color: Colors.grey[600], fontSize: 15),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 5),
                                                                            child:
                                                                                Text(
                                                                              "${value.data2.data.ongoing_tables[index].time}",
                                                                              style: TextStyle(color: Colors.grey[600], fontSize: 15),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(
                                                                              left: 5,
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              "${value.data2.data.ongoing_tables[index].NoOfItems} item",
                                                                              style: TextStyle(color: Colors.grey[600], fontSize: 15),
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(
                                                                              right: 5,
                                                                            ),
                                                                            child:
                                                                                Text(
                                                                              "${value.data2.data.ongoing_tables[index].Persons} person",
                                                                              style: TextStyle(color: Colors.orangeAccent, fontSize: 15),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      fourseathomepage(
                                                                          index),
                                                                      Divider(
                                                                        height:
                                                                            2,
                                                                        indent:
                                                                            4,
                                                                        endIndent:
                                                                            4,
                                                                        color: Colors
                                                                            .grey,
                                                                      ),
                                                                      Text(
                                                                        "${value.data2.data.ongoing_tables[index].GrandTotal}",
                                                                        style:
                                                                            textStyle,
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                  decoration: const BoxDecoration(
                                      color: maincolor,
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(50),
                                          bottomRight: Radius.circular(50))),
                                ),
                                Positioned(
                                  top: 0,
                                  left: 60,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              15,
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            const BoxShadow(
                                                blurRadius: 2,
                                                color: Colors.grey)
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 0),
                                            child: Center(
                                              child: Text(
                                                value.data2.data.user_details
                                                    .store_name,
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 0),
                                              child: (() {
                                                if (value
                                                    .data2
                                                    .data
                                                    .user_details
                                                    .user_name
                                                    .isEmpty) {
                                                  clearApiKey();
                                                  Future.delayed(Duration.zero,
                                                      () {
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            splashscreen(),
                                                      ),
                                                    );
                                                  });
                                                }
                                                return Center(
                                                  child: Text(
                                                    value.data2.data
                                                        .user_details.user_name,
                                                    style: const TextStyle(
                                                        fontSize: 16),
                                                  ),
                                                );
                                              })()),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height / 3.3,
                                color: const Color.fromARGB(255, 231, 242, 247),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                8,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 74, 96, 120),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10,
                                              ),
                                              child: Column(children: [
                                                Text(
                                                  value.data2.data.user_details
                                                      .active_orders,
                                                  style: const TextStyle(
                                                      fontSize: 35,
                                                      color: wcolor),
                                                ),
                                                Text(
                                                  "Active Orders",
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      color: wcolor),
                                                ),
                                              ]),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.2,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                8,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 74, 96, 120),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10,
                                              ),
                                              child: Column(children: [
                                                Text(
                                                  value.data2.data.user_details
                                                      .dinein,
                                                  style: const TextStyle(
                                                      fontSize: 35,
                                                      color: wcolor),
                                                ),
                                                Text(
                                                  "Holded",
                                                  style: const TextStyle(
                                                      fontSize: 17,
                                                      color: wcolor),
                                                ),
                                              ]),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                8,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 74, 96, 120),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10,
                                              ),
                                              child: Column(children: [
                                                Text(
                                                  value.data2.data.user_details
                                                      .dinein,
                                                  style: const TextStyle(
                                                      fontSize: 35,
                                                      color: wcolor),
                                                ),
                                                Text(
                                                  "Dine In",
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: wcolor),
                                                ),
                                              ]),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                8,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 74, 96, 120),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10,
                                              ),
                                              child: Column(children: [
                                                Text(
                                                  value.data2.data.user_details
                                                      .takeaway,
                                                  style: const TextStyle(
                                                      fontSize: 35,
                                                      color: wcolor),
                                                ),
                                                Text(
                                                  "Take-way",
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: wcolor),
                                                ),
                                              ]),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                8,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 74, 96, 120),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10,
                                              ),
                                              child: Column(children: [
                                                Text(
                                                  value.data2.data.user_details
                                                      .parcel,
                                                  style: const TextStyle(
                                                      fontSize: 35,
                                                      color: wcolor),
                                                ),
                                                Text(
                                                  "Parcels",
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: wcolor),
                                                ),
                                              ]),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                8,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 74, 96, 120),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10,
                                              ),
                                              child: Column(children: [
                                                Text(
                                                  value.data2.data.user_details
                                                      .parcel,
                                                  style: const TextStyle(
                                                      fontSize: 35,
                                                      color: wcolor),
                                                ),
                                                Text(
                                                  "delivery",
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: wcolor),
                                                ),
                                              ]),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        );
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                  flex: 2,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 5.7,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Color.fromARGB(255, 5, 35, 69),
                    ),
                    child: Row(children: [
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 15, top: 20, bottom: 20),
                          child: InkWell(
                            onTap: () {
                              Get.to(() => const ServerSelect(),
                                  transition: Transition.fade,
                                  duration: Duration(milliseconds: 300));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Pelaicons.cart_3_light_outline,
                                      size: 30,
                                    ),
                                    Text(
                                      "Create",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "New Order",
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ]),
                            ),
                          )),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20, top: 20, bottom: 20),
                          child: InkWell(
                            onTap: () {
                              Get.to(() => OrderManagementPage(),
                                  transition: Transition.fade);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: 220,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Pelaicons.cart_2_light_outline,
                                      size: 30,
                                    ),
                                    Text(
                                      "Order",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    Text(
                                      "Management",
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ]),
                            ),
                          ))
                    ]),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
