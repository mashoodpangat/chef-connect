import 'dart:async';

import 'package:chef_connect_project/API/ApiProvider.dart';
import 'package:chef_connect_project/API/Stateprovider.dart';
import 'package:chef_connect_project/FoodItemCategories/ProductCategories.dart';
import 'package:chef_connect_project/FoodItemCategories/SubCategories.dart';
import 'package:chef_connect_project/SelectTables.dart/selectTables.dart';
import 'package:chef_connect_project/createOrder.dart/SelectServerType.dart';
import 'package:chef_connect_project/homepage/homepage.dart';
import 'package:chef_connect_project/itemOrder/Ordermanagement.dart';

import 'package:chef_connect_project/styleUtils.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pelaicons/pelaicons.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

int order_idd = 0;
int tableindex = 0;

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersState();
}

// double grandTotal = 0.0;

late DataProvider cartItemOrderprovider;
late DataProvider ActiveOrderConfirmprovider;
late Stateprovider calculateprovider;
late Stateprovider quantityprovider;

class _OrdersState extends State<OrdersPage> {
  int index = 0;
  late TextEditingController quantityController;
  List<TextEditingController> quantityControllers = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});

    quantityControllers = List.generate(
      selectedProducts.length,
      (index) => TextEditingController(
        text: selectedProducts[index]["Qty"].toString(),
      ),
    );
  }

  // StreamController<int> quantityController1 = StreamController<int>.broadcast();

  //////////////////////////////quantity change//////////////////////

  void _decreaseQuantity(int index) {
    setState(() {
      if (index >= 0 && index < selectedProducts.length) {
        if (selectedProducts[index]["Qty"] > 0) {
          selectedProducts[index]["Qty"] = selectedProducts[index]["Qty"] - 1;
          quantityControllers[index].text =
              selectedProducts[index]["Qty"].toString();
        }
      }
    });
  }

  void _updateQuantity(int index, String value) {
    setState(() {
      if (index >= 0 && index < selectedProducts.length) {
        selectedProducts[index]["Qty"] = int.tryParse(value) ?? 0;
      }
    });
  }

  void _increaseQuantity(int index) {
    setState(() {
      if (index >= 0 && index < selectedProducts.length) {
        selectedProducts[index]["Qty"] = selectedProducts[index]["Qty"] + 1;
        quantityControllers[index].text =
            selectedProducts[index]["Qty"].toString();
      }
    });
  }

  double calculateTotalPrice(List<Map<String, dynamic>> selectedProducts) {
    double totalPrice = 0.0;
    for (var product in selectedProducts) {
      double quantity = product["Qty"].toDouble(); // Convert to double
      double salesPrice = product["SalesPrice"].toDouble(); // Convert to double
      totalPrice += quantity * salesPrice;
    }
    return totalPrice;
  }

  @override
  void dispose() {
    quantityController.dispose(); // Dispose of the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TextEditingController quantityController =
    //     TextEditingController(text: "${selectedProducts[index]["Qty"]}");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: maincolor,
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: maincolor,
        leading: IconButton(
            onPressed: () {
              selectedProducts.clear();
              order_idd = 0;
              invoicenumber = 0;
              cart_masterId = 0;
              invoice_type = "";
              deliveryTtype = "";
              tableId = 0;
              TableName = "";
              tableindex = 0;

              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => homepage(),
              ));
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              size: 25,
              color: Colors.white,
            )),
        title: const Text(
          "Orders",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          SizedBox(
            width: 90,
            height: 35,
            child: ElevatedButton(
              onPressed: () {
                tableindex = 1;
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SelectTables(),
                ));
              },
              child: Text(
                "${TableName}",
                style: TextStyle(color: Colors.red[900]),
              ),
              style: ElevatedButton.styleFrom(
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          IconButton(
              onPressed: () {
                // print("cart master=${cart_masterId}");
                // print("order id=${order_idd}");
                // print("invoice=${invoicenumber}");
                print("selected products=${selectedProducts}");
                print("serverTime=${findGreatestTime(selectedProducts)}");
                // print("delivery=${deliveryTtype}");
                // print(tableId);
                print(selectedProducts.length);
                print("item quantity:");
              },
              icon: const Icon(
                Icons.more_vert,
                size: 25,
                color: Colors.white,
              ))
        ],
      ),
      body: WillPopScope(
        onWillPop: () async {
          setState(() {
            cart_masterId = 0;
            invoicenumber = 0;
            order_idd = 0;
            tableId = 0;
            tableindex = 0;
            TableName = "";
            invoice_type = "";
            deliveryTtype = "";
            selectedProducts.clear();
          });
          return true;
        },
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 7,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: FutureBuilder(
                          builder: (context, snapshot) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: " Items :",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors
                                              .black, // Set the color to red
                                        ),
                                      ),
                                      TextSpan(
                                        text: "${selectedProducts.length}",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors
                                              .red, // Set the color to green
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text.rich(
                                      TextSpan(
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: "Server time:",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: maincolor,
                                            ),
                                          ),
                                          TextSpan(
                                            text: findGreatestTime(
                                                    selectedProducts)
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.red,
                                            ),
                                          ),
                                          TextSpan(
                                            text: " min",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))
                              ],
                            );
                          },
                        ),
                      ),
                      Center(
                        child: Consumer<DataProvider>(
                          builder: (context, value, child) {
                            return Container(
                              width: MediaQuery.of(context).size.width - 15,
                              height: selectedProducts.length < 2
                                  ? MediaQuery.of(context).size.height / 3
                                  : MediaQuery.of(context).size.height / 2.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.grey)),
                              child: ListView.separated(
                                itemCount: selectedProducts.length,
                                separatorBuilder: (context, index) =>
                                    DottedLine(
                                  dashColor: maincolor,
                                  lineThickness: 1.5,
                                ),
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Colors.white,
                                    elevation: 0,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 6),
                                          child: Text(
                                            "${selectedProducts[index]["name"]}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                                color: maincolor),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    await showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return Dialog(
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        32,
                                                                    vertical:
                                                                        16),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: wcolor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                Container(
                                                                  height: 100,
                                                                  width: 100,
                                                                  color: Colors
                                                                      .transparent,
                                                                  child: Lottie
                                                                      .asset(
                                                                    "assetslottie/delete icon lottie.json",
                                                                  ),
                                                                ),
                                                                Text(
                                                                  "Are you Sure ?",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                                SizedBox(
                                                                  height: 20,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    SizedBox(
                                                                      width:
                                                                          100,
                                                                      height:
                                                                          40,
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              Colors.grey[600],
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                                        ),
                                                                        child:
                                                                            Text(
                                                                          "No",
                                                                          style:
                                                                              TextStyle(color: Colors.white),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          100,
                                                                      height:
                                                                          40,
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed:
                                                                            () async {
                                                                          setState(
                                                                              () {
                                                                            selectedProducts.removeAt(index);

                                                                            // Provider.of<Stateprovider>(context, listen: false).calculateGrandTotal(selectedProducts);
                                                                          });
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          backgroundColor:
                                                                              maincolor,
                                                                          shape:
                                                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                                                        ),
                                                                        child:
                                                                            Text(
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
                                                  child: Icon(
                                                    Pelaicons
                                                        .delete_light_outline,
                                                    size: 40,
                                                    color: maincolor,
                                                  ),
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "${selectedProducts[index]["Modifier"]}",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.grey),
                                                    ),
                                                    Text.rich(
                                                      TextSpan(
                                                        children: <TextSpan>[
                                                          TextSpan(
                                                            text:
                                                                "${selectedProducts[index]["Qty"]} ",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: maincolor,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: "X",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .red, // Set the color to red
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text:
                                                                " ${selectedProducts[index]["SalesPrice"]}= ${selectedProducts[index]["Qty"] * selectedProducts[index]["SalesPrice"]}",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: maincolor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: 108,
                                              height: 33,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                color: Colors.grey.shade300,
                                              ),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          _decreaseQuantity(
                                                              index);
                                                        });
                                                      },
                                                      child: Icon(
                                                        Icons.remove,
                                                        size: 30,
                                                      )),
                                                  Container(
                                                    width: 48,
                                                    height: 27,
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                              color: Colors.grey
                                                                  .shade500,
                                                              offset: Offset(
                                                                6,
                                                                6,
                                                              ),
                                                              blurRadius: 15,
                                                              spreadRadius: 1),
                                                          BoxShadow(
                                                              color:
                                                                  Colors.white,
                                                              offset: Offset(
                                                                -6,
                                                                -3,
                                                              ),
                                                              blurRadius: 15,
                                                              spreadRadius: 1)
                                                        ],
                                                        color: Colors
                                                            .grey.shade300,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                    alignment: Alignment.center,
                                                    child: Center(
                                                      child: TextField(
                                                        decoration:
                                                            InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                        textAlign:
                                                            TextAlign.center,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        onChanged: (value) {
                                                          _updateQuantity(
                                                              index, value);
                                                        },
                                                        controller:
                                                            quantityControllers[
                                                                index],
                                                        style: const TextStyle(
                                                            color: maincolor,
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                      onTap: () {
                                                        _increaseQuantity(
                                                            index);
                                                      },
                                                      child: Icon(
                                                        Icons.add,
                                                        size: 30,
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );

                                  ////////////////////////////////////////////////////////
                                },
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 50,
                          child: Consumer<DataProvider>(
                            builder: (context, value, child) {
                              return ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return SubCategoriesPage();
                                    },
                                  ));
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: maincolor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Add more dish",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    Icon(
                                      Icons.add_circle_outline,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),

                      ///////////////////////////////////////////////////////////////////////////////
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.7,
                            height: MediaQuery.of(context).size.height / 5.5,
                            color: Colors.transparent,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Item Total",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                                  Text(
                                    "Tax Total",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                                  Text(
                                    "Loyalty Discount",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                                  Text(
                                    "Other Discount",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                                  Text(
                                    "Grand Total",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: maincolor,
                                        fontWeight: FontWeight.bold),
                                  )
                                ]),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.height / 5.5,
                              color: Colors.transparent,
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          ":",
                                          style: TextStyle(
                                              fontSize: 18, color: maincolor),
                                        ),
                                        Text(
                                          " ${calculateTotalPrice(selectedProducts).toString()}",
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.grey),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          ":",
                                          style: TextStyle(
                                              fontSize: 18, color: maincolor),
                                        ),
                                        Text(
                                          "00.00",
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.grey),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          ":",
                                          style: TextStyle(
                                              fontSize: 18, color: maincolor),
                                        ),
                                        Text(
                                          "00.00",
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.grey),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          ":",
                                          style: TextStyle(
                                              fontSize: 18, color: maincolor),
                                        ),
                                        Text(
                                          " 00.00",
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.grey),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          ":",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: maincolor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          " ${calculateTotalPrice(selectedProducts).toString()}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: maincolor,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    )
                                  ]),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.1,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: ElevatedButton(
                                onPressed: () async {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: maingreycolor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: Text(
                                  "Rate Now",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.1,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: ElevatedButton(
                                onPressed: () async {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: maingreycolor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Loyalty",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 8),
                                      child: Icon(
                                        Pelaicons.gift_light_outline,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(blurRadius: 5, color: Colors.black)],
                ),
                child: (() {
                  if (order_idd == 0) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: Adaptive.w(45),
                          height:
                              MediaQuery.of(context).size.width < 600 ? 55 : 60,
                          child: Consumer<DataProvider>(
                            builder: (context, value, child) {
                              return ElevatedButton(
                                onPressed: () {
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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                height: 100,
                                                width: 100,
                                                color: Colors.transparent,
                                                child: Lottie.asset(
                                                  "assetslottie/animation_ln94nvvh.json",
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 100,
                                                    height: 40,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.grey[600],
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                      ),
                                                      child: Text(
                                                        "No",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                    height: 40,
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        try {
                                                          Provider.of<DataProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .GetCartOrders(
                                                                  context);
                                                          selectedProducts
                                                              .clear();
                                                          cart_masterId = 0;
                                                          order_idd = 0;
                                                          invoicenumber = 0;
                                                          deliveryTtype = "";
                                                          tableId = 0;
                                                          tableindex = 0;

                                                          print("cart created");
                                                        } catch (e) {
                                                          print(
                                                              "Error confirming order: $e");
                                                        }
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            maincolor,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                      ),
                                                      child: Text(
                                                        "Yes",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
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
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: maingreycolor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                                child: const Text(
                                  "Hold",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width < 600
                              ? Adaptive.w(45)
                              : Adaptive.w(45),
                          height:
                              MediaQuery.of(context).size.width < 600 ? 55 : 60,
                          child: Consumer<DataProvider>(
                            builder: (context, value, child) {
                              return ElevatedButton(
                                onPressed: () {
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
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  height: 100,
                                                  width: 100,
                                                  color: Colors.transparent,
                                                  child: Lottie.asset(
                                                    "assetslottie/animation_ln94nvvh.json",
                                                  ),
                                                ),
                                                Text(
                                                  "Are you Sure ?",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: 100,
                                                      height: 40,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.grey[600],
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                        ),
                                                        child: Text(
                                                          "No",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 100,
                                                      height: 40,
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          try {
                                                            if (order_idd ==
                                                                0) {
                                                              Provider.of<DataProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .GetCartConfirmOrders(
                                                                      context);
                                                            } else {
                                                              Provider.of<DataProvider>(
                                                                      context,
                                                                      listen:
                                                                          false)
                                                                  .GetEditActiveOrder(
                                                                      context);
                                                              print(
                                                                  "edited active order");
                                                            }

                                                            order_idd = 0;
                                                            invoicenumber = 0;
                                                            deliveryTtype = "";
                                                            tableId = 0;
                                                            tableindex = 0;

                                                            selectedProducts
                                                                .clear();

                                                            print(
                                                                "Order confirmed successfully");
                                                          } catch (e) {
                                                            print(
                                                                "Error confirming order: $e");
                                                          }
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              maincolor,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                        ),
                                                        child: Text(
                                                          "Yes",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
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
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: maincolor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                                child: const Text(
                                  "Confirm Order",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (invoice_type == "SO") {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width / 2.3,
                      height: MediaQuery.of(context).size.width < 600 ? 55 : 60,
                      child: Consumer<DataProvider>(
                        builder: (context, value, child) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: ElevatedButton(
                              onPressed: () {
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
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                height: 100,
                                                width: 100,
                                                color: Colors.transparent,
                                                child: Lottie.asset(
                                                  "assetslottie/animation_ln94nvvh.json",
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 100,
                                                    height: 40,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.grey[600],
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                      ),
                                                      child: Text(
                                                        "No",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 100,
                                                    height: 40,
                                                    child: ElevatedButton(
                                                      onPressed: () async {
                                                        try {
                                                          Provider.of<DataProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .GetEditActiveOrder(
                                                                  context);
                                                          print(
                                                              "edited active order");

                                                          order_idd = 0;
                                                          invoicenumber = 0;
                                                          invoice_type = "";
                                                          deliveryTtype = "";
                                                          tableId = 0;
                                                          tableindex = 0;

                                                          selectedProducts
                                                              .clear();

                                                          print(
                                                              "Order confirmed successfully");
                                                        } catch (e) {
                                                          print(
                                                              "Error confirming order: $e");
                                                        }
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            maincolor,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                      ),
                                                      child: Text(
                                                        "Yes",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
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
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: maincolor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                              ),
                              child: const Text(
                                "Confirm Order",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (invoice_type == "Cart") {
                    // Render different content for other cases
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.3,
                          height:
                              MediaQuery.of(context).size.width < 600 ? 55 : 60,
                          child: Consumer<DataProvider>(
                            builder: (context, value, child) {
                              return ElevatedButton(
                                onPressed: () {
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
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  height: 100,
                                                  width: 100,
                                                  color: Colors.transparent,
                                                  child: Lottie.asset(
                                                    "assetslottie/animation_ln94nvvh.json",
                                                  ),
                                                ),
                                                Text(
                                                  "Are you Sure ?",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: 100,
                                                      height: 40,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.grey[600],
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                        ),
                                                        child: Text(
                                                          "No",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 100,
                                                      height: 40,
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          try {
                                                            Provider.of<DataProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .GetCartOrders(
                                                                    context);
                                                            // print(DataProvider()
                                                            //     .GetActiveOrders());
                                                            selectedProducts
                                                                .clear();
                                                            cart_masterId = 0;
                                                            order_idd = 0;
                                                            invoicenumber = 0;
                                                            invoice_type = "";
                                                            deliveryTtype = "";
                                                            tableId = 0;
                                                            tableindex = 0;

                                                            print(
                                                                "cart created");
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .push(
                                                            //         MaterialPageRoute(
                                                            //   builder:
                                                            //       (context) =>
                                                            //           homepage(),
                                                            // ));
                                                          } catch (e) {
                                                            print(
                                                                "Error confirming order: $e");
                                                          }
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              maincolor,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                        ),
                                                        child: Text(
                                                          "Yes",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
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
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: maingreycolor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                                child: const Text(
                                  "Hold",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.3,
                          height:
                              MediaQuery.of(context).size.width < 600 ? 55 : 60,
                          child: Consumer<DataProvider>(
                            builder: (context, value, child) {
                              return ElevatedButton(
                                onPressed: () {
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
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  height: 100,
                                                  width: 100,
                                                  color: Colors.transparent,
                                                  child: Lottie.asset(
                                                    "assetslottie/animation_ln94nvvh.json",
                                                  ),
                                                ),
                                                Text(
                                                  "Are you Sure ?",
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: 100,
                                                      height: 40,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.grey[600],
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                        ),
                                                        child: Text(
                                                          "No",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 100,
                                                      height: 40,
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          try {
                                                            Provider.of<DataProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .GetcartToActiveOrder(
                                                                    context);
                                                            cart_masterId = 0;
                                                            order_idd = 0;
                                                            invoicenumber = 0;
                                                            invoice_type = "";
                                                            deliveryTtype = "";
                                                            tableId = 0;
                                                            tableindex = 0;

                                                            selectedProducts
                                                                .clear();

                                                            print(
                                                                "Order confirmed successfully");
                                                            // Navigator.of(
                                                            //         context)
                                                            //     .push(
                                                            //         MaterialPageRoute(
                                                            //   builder:
                                                            //       (context) =>
                                                            //           homepage(),
                                                            // ));
                                                          } catch (e) {
                                                            print(
                                                                "Error confirming order: $e");
                                                          }
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              maincolor,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                        ),
                                                        child: Text(
                                                          "Yes",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
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
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: maincolor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                ),
                                child: const Text(
                                  "Confirm Order",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                })(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// double grandTotal = selectedProducts.fold(0.0, (double total, product) {
//   double salesPrice = product["SalesPrice"];
//   int quantity = product["Qty"];
//   return total + (salesPrice * quantity);
// });

// void updateGrandTotal() {
//   double total = 0.0;
//   for (final product in selectedProducts) {
//     final quantity = product["Qty"];
//     final price = product["SalesPrice"];
//     total += quantity * price;
//   }
//   setState(() {
//     grandTotal = total;
//   });
// }
