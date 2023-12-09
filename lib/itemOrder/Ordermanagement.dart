import 'package:chef_connect_project/API/ApiProvider.dart';
import 'package:chef_connect_project/API/cartOrderModel.dart';
import 'package:chef_connect_project/FoodItemCategories/ProductCategories.dart';
import 'package:chef_connect_project/SelectTables.dart/selectTables.dart';
import 'package:chef_connect_project/SelectTables.dart/tablegridview.dart';

import 'package:chef_connect_project/createOrder.dart/SelectServerType.dart';
import 'package:chef_connect_project/itemOrder/orders.dart';
import 'package:chef_connect_project/styleUtils.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

String invoice_type = "";
int cart_masterId = 0;
int invoicenumber = 0;

class OrderManagementPage extends StatefulWidget {
  const OrderManagementPage({super.key});

  @override
  State<OrderManagementPage> createState() => _OrderManagementState();
}

late DataProvider ActiveOrderprovider;
late DataProvider activeOrderByIdproviders;

class _OrderManagementState extends State<OrderManagementPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Order> filteredOrders = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabelsearchcontroller.dispose();
    super.dispose();
  }

  TextEditingController _tabelsearchcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ActiveOrderprovider = Provider.of<DataProvider>(context, listen: false);
    ActiveOrderprovider.GetActiveOrders();
    // activeOrderByIdproviders =
    //     Provider.of<DataProvider>(context, listen: false);
    // activeOrderByIdproviders.GetActiveOrdersById();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: IconButton(
            onPressed: () {
              cart_masterId = 0;
              invoicenumber = 0;
              order_idd = 0;
              deliveryTtype = "";

              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_outlined,
              size: 25,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {
                print(order_idd);
                print(selectedProducts);
                print(invoicenumber);
                print("cart master=${cart_masterId}");
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
            deliveryTtype = "";
            selectedProducts.clear();
          });

          return true;
        },
        child: Column(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 18,
            decoration: const BoxDecoration(
                color: maincolor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: TabBar(
              unselectedLabelColor: Colors.grey[500],
              labelColor: Colors.white,
              indicatorColor: Colors.white,
              controller: _tabController,
              tabs: [
                const Tab(text: 'Active'),
                const Tab(text: 'Holded'),
                const Tab(text: 'completed'),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 55,
            child: TextField(
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  filteredOrders = ActiveOrderprovider.ActiveOrders.data.orders
                      .where((order) => order.tableNo
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });

                // Remove notifyListeners() here
              },
              controller: _tabelsearchcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.black)),
                  filled: true,
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 172, 171, 171)),
                  hintText: "Search for",
                  fillColor: const Color.fromARGB(255, 42, 44, 56),
                  suffixIcon: const Icon(
                    Icons.search_sharp,
                    color: Colors.white,
                  )),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Expanded(
              child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: DefaultTabController(
              length: 3,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Consumer<DataProvider>(
                    builder: (context, value, child) {
                      if (value.isLoading) {
                        return Container(
                          color: Colors.grey[300],
                          child: Center(
                              child: Lottie.asset(
                            frameRate: FrameRate(60),
                            height: 120,
                            "assetslottie/Animation - 1697009692722.json",
                          )),
                        );
                        // return shimmersActiveOrders(context);
                      } else {
                        return Container(
                          color: Colors.grey[300],
                          child: ListView.builder(
                            itemCount: value.ActiveOrders.data.orders.length,
                            itemBuilder: (context, index) {
                              // final order =
                              //     value.ActiveOrders.data.orders[index];
                              final order =
                                  value.ActiveOrders.data.orders[index];
                              if (_tabelsearchcontroller.text.isEmpty ||
                                  order.tableNo.toLowerCase().contains(
                                        _tabelsearchcontroller.text
                                            .toLowerCase(),
                                      )) {
                                if (value.ActiveOrders.data.orders[index]
                                        .invoiceType ==
                                    "SO") {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: InkWell(
                                      onTap: () {
                                        order_idd = value.ActiveOrders.data
                                            .orders[index].orderId;

                                        invoicenumber = value.ActiveOrders.data
                                            .orders[index].invoiceNumber;
                                        invoice_type = value.ActiveOrders.data
                                            .orders[index].invoiceType;
                                        TableName = value.ActiveOrders.data
                                            .orders[index].tableNo;

                                        print(order_idd);
                                        print(invoicenumber);
                                        print(invoice_type);

                                        Provider.of<DataProvider>(context,
                                                listen: false)
                                            .GetActiveOrdersById(context);

                                        // Navigator.of(context)
                                        //     .push(MaterialPageRoute(
                                        //   builder: (context) =>
                                        //       const OrdersPage(),
                                        // ));
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 170,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3.8,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 20),
                                                              child: Container(
                                                                width: 80,
                                                                height: 20,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                            .green[
                                                                        600],
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                child: Center(
                                                                    child: Text(
                                                                  value
                                                                      .ActiveOrders
                                                                      .data
                                                                      .orders[
                                                                          index]
                                                                      .invoiceNumber
                                                                      .toString(),
                                                                  // "",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                )),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 20),
                                                              child:
                                                                  table(index),
                                                            )
                                                          ]),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  height: 100,
                                                  color: Colors.white,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Text(
                                                        '${value.ActiveOrders.data.orders[index].noOfItems}' +
                                                            '${" Items"}',
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        '${"Table No: "}' +
                                                            '${value.ActiveOrders.data.orders[index].tableNo}',
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15),
                                                      ),
                                                      Text(
                                                        '${"Person: "}' +
                                                            '${value.ActiveOrders.data.orders[index].persons}',
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3.5,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Column(children: [
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Text(
                                                      "Add Details",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 16),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    const Text(
                                                      "price",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(
                                                      value
                                                          .ActiveOrders
                                                          .data
                                                          .orders[index]
                                                          .grandTotal
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    )
                                                  ]),
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                              color: Colors.black,
                                              thickness: .6,
                                              indent: 15,
                                              endIndent: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      order_idd = value
                                                          .ActiveOrders
                                                          .data
                                                          .orders[index]
                                                          .orderId;

                                                      invoicenumber = value
                                                          .ActiveOrders
                                                          .data
                                                          .orders[index]
                                                          .invoiceNumber;
                                                      invoice_type = value
                                                          .ActiveOrders
                                                          .data
                                                          .orders[index]
                                                          .invoiceType;
                                                      TableName = value
                                                          .ActiveOrders
                                                          .data
                                                          .orders[index]
                                                          .tableNo;

                                                      Provider.of<DataProvider>(
                                                              context,
                                                              listen: false)
                                                          .GetActiveOrdersById(
                                                              context);

                                                      Navigator.of(context)
                                                          .push(
                                                              MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrdersPage(),
                                                      ));
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          maincolor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0)),
                                                    ),
                                                    child: const Text(
                                                      "Add Items",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  child: ElevatedButton(
                                                    onPressed: () {},
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          maincolor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0)),
                                                    ),
                                                    child: const Text(
                                                      "Print Bill",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container();
                                }
                              } else {
                                return Container();
                              }
                            },
                          ),
                        );
                      }
                    },
                  ),
                  Consumer<DataProvider>(
                    builder: (context, value, child) {
                      if (value.isLoading) {
                        return Container(
                          color: Colors.grey[300],
                          child: Center(
                              child: Lottie.asset(
                            frameRate: FrameRate(60),
                            height: 120,
                            "assetslottie/Animation - 1697009692722.json",
                          )),
                        );
                        // return shimmersActiveOrders(context);
                      } else {
                        return Container(
                          color: Colors.grey[300],
                          child: ListView.builder(
                            itemCount: value.ActiveOrders.data.orders.length,
                            itemBuilder: (context, index) {
                              final order =
                                  value.ActiveOrders.data.orders[index];
                              if (_tabelsearchcontroller.text.isEmpty ||
                                  order.tableNo.toLowerCase().contains(
                                        _tabelsearchcontroller.text
                                            .toLowerCase(),
                                      )) {
                                if (value.ActiveOrders.data.orders[index]
                                        .invoiceType ==
                                    "Cart") {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        order_idd = value.ActiveOrders.data
                                            .orders[index].orderId;
                                        invoicenumber = value.ActiveOrders.data
                                            .orders[index].invoiceNumber;

                                        cart_masterId = value.ActiveOrders.data
                                            .orders[index].orderId;
                                        invoice_type = value.ActiveOrders.data
                                            .orders[index].invoiceType;
                                        TableName = value.ActiveOrders.data
                                            .orders[index].tableNo;
                                        Provider.of<DataProvider>(context,
                                                listen: false)
                                            .GetCartOrdersById(context);
                                        print(cart_masterId);
                                        // Navigator.of(context)
                                        //     .push(MaterialPageRoute(
                                        //   builder: (context) => OrdersPage(),
                                        // ));
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        height: 170,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3.8,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 20),
                                                              child: Container(
                                                                width: 80,
                                                                height: 20,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                            .green[
                                                                        600],
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)),
                                                                child: Center(
                                                                    child: Text(
                                                                  value
                                                                      .ActiveOrders
                                                                      .data
                                                                      .orders[
                                                                          index]
                                                                      .invoiceNumber
                                                                      .toString(),
                                                                  // "",
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                )),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 20),
                                                              child:
                                                                  table(index),
                                                            )
                                                          ]),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3,
                                                  height: 100,
                                                  color: Colors.white,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 15,
                                                      ),
                                                      Text(
                                                        '${value.ActiveOrders.data.orders[index].noOfItems}' +
                                                            '${" Items"}',
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      Text(
                                                        '${"Table No: "}' +
                                                            '${value.ActiveOrders.data.orders[index].tableNo}',
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15),
                                                      ),
                                                      Text(
                                                        '${"Person: "}' +
                                                            '${value.ActiveOrders.data.orders[index].persons}',
                                                        style: const TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3.5,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                      color: Colors.transparent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Column(children: [
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Text(
                                                      "Add Details",
                                                      style: TextStyle(
                                                          color: Colors.green,
                                                          fontSize: 16),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    const Text(
                                                      "price",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(
                                                      value
                                                          .ActiveOrders
                                                          .data
                                                          .orders[index]
                                                          .grandTotal
                                                          .toString(),
                                                      style: const TextStyle(
                                                          fontSize: 16),
                                                    )
                                                  ]),
                                                ),
                                              ],
                                            ),
                                            const Divider(
                                              color: Colors.black,
                                              thickness: .6,
                                              indent: 15,
                                              endIndent: 15,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      order_idd = value
                                                          .ActiveOrders
                                                          .data
                                                          .orders[index]
                                                          .orderId;
                                                      invoicenumber = value
                                                          .ActiveOrders
                                                          .data
                                                          .orders[index]
                                                          .invoiceNumber;

                                                      cart_masterId = value
                                                          .ActiveOrders
                                                          .data
                                                          .orders[index]
                                                          .orderId;
                                                      invoice_type = value
                                                          .ActiveOrders
                                                          .data
                                                          .orders[index]
                                                          .invoiceType;
                                                      TableName = value
                                                          .ActiveOrders
                                                          .data
                                                          .orders[index]
                                                          .tableNo;
                                                      Provider.of<DataProvider>(
                                                              context,
                                                              listen: false)
                                                          .GetCartOrdersById(
                                                              context);
                                                      print(cart_masterId);
                                                      Navigator.of(context)
                                                          .push(
                                                              MaterialPageRoute(
                                                        builder: (context) =>
                                                            OrdersPage(),
                                                      ));
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          maincolor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0)),
                                                    ),
                                                    child: const Text(
                                                      "Add Items",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.5,
                                                  child: ElevatedButton(
                                                    onPressed: () {},
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.red,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0)),
                                                    ),
                                                    child: const Text(
                                                      "Print Bill",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return null;
                                }
                              } else {
                                return Container();
                              }
                            },
                          ),
                        );
                      }
                    },
                  ),
                  Container(
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
          ))
        ]),
      ),
    );
  }
}
