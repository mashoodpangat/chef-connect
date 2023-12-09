







 //  Consumer<DataProvider>(
                  //   builder: (context, value, child) {
                  //     if (value.isLoading) {
                  //       return Center(
                  //           child: Lottie.asset(
                  //         frameRate: FrameRate(60),
                  //         height: 120,
                  //         "assetslottie/Animation - 1697009692722.json",
                  //       ));
                  //       // return shimmersActiveOrders(context);
                  //     } else {
                  //       return Container(
                  //         color: Colors.grey[200],
                  //         child: ListView.builder(
                  //           itemCount: value.ActiveOrders.data.orders.length,
                  //           itemBuilder: (context, index) {
                  //             if (value.ActiveOrders.data.orders[index]
                  //                     .invoiceType ==
                  //                 "Cart") {
                  //               return Padding(
                  //                 padding: const EdgeInsets.only(
                  //                     top: 10, left: 10, right: 10),
                  //                 child: GestureDetector(
                  //                   onTap: () {
                  //                     order_idd = value.ActiveOrders.data
                  //                         .orders[index].orderId;
                  //                     invoicenumber = value.ActiveOrders.data
                  //                         .orders[index].invoiceNumber;

                  //                     cart_masterId = value.ActiveOrders.data
                  //                         .orders[index].orderId;
                  //                     invoice_type = value.ActiveOrders.data
                  //                         .orders[index].invoiceType;
                  //                     TableName = value.ActiveOrders.data
                  //                         .orders[index].tableNo;
                  //                     Provider.of<DataProvider>(context,
                  //                             listen: false)
                  //                         .GetCartOrdersById(context);
                  //                     print(cart_masterId);
                  //                     // Navigator.of(context)
                  //                     //     .push(MaterialPageRoute(
                  //                     //   builder: (context) => OrdersPage(),
                  //                     // ));
                  //                   },
                  //                   child: Container(
                  //                     width: double.infinity,
                  //                     height: 170,
                  //                     decoration: BoxDecoration(
                  //                       color: Colors.white,
                  //                       borderRadius: BorderRadius.circular(20),
                  //                     ),
                  //                     child: Column(
                  //                       children: [
                  //                         Row(
                  //                           crossAxisAlignment:
                  //                               CrossAxisAlignment.start,
                  //                           children: [
                  //                             Container(
                  //                               width: MediaQuery.of(context)
                  //                                       .size
                  //                                       .width /
                  //                                   3.8,
                  //                               height: 100,
                  //                               decoration: BoxDecoration(
                  //                                   color: Colors.white,
                  //                                   borderRadius:
                  //                                       BorderRadius.circular(
                  //                                           20)),
                  //                               child: Row(
                  //                                 crossAxisAlignment:
                  //                                     CrossAxisAlignment.start,
                  //                                 children: [
                  //                                   Column(
                  //                                       crossAxisAlignment:
                  //                                           CrossAxisAlignment
                  //                                               .start,
                  //                                       children: [
                  //                                         Padding(
                  //                                           padding:
                  //                                               const EdgeInsets
                  //                                                       .only(
                  //                                                   left: 20),
                  //                                           child: Container(
                  //                                             width: 80,
                  //                                             height: 20,
                  //                                             decoration: BoxDecoration(
                  //                                                 color: Colors
                  //                                                         .green[
                  //                                                     600],
                  //                                                 borderRadius:
                  //                                                     BorderRadius
                  //                                                         .circular(
                  //                                                             20)),
                  //                                             child: Center(
                  //                                                 child: Text(
                  //                                               value
                  //                                                   .ActiveOrders
                  //                                                   .data
                  //                                                   .orders[
                  //                                                       index]
                  //                                                   .invoiceNumber
                  //                                                   .toString(),
                  //                                               // "",
                  //                                               style: const TextStyle(
                  //                                                   color: Colors
                  //                                                       .white),
                  //                                             )),
                  //                                           ),
                  //                                         ),
                  //                                         const SizedBox(
                  //                                           height: 20,
                  //                                         ),
                  //                                         Padding(
                  //                                           padding:
                  //                                               const EdgeInsets
                  //                                                       .only(
                  //                                                   left: 20),
                  //                                           child: table(index),
                  //                                         )
                  //                                       ]),
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                             const SizedBox(
                  //                               width: 20,
                  //                             ),
                  //                             Container(
                  //                               width: MediaQuery.of(context)
                  //                                       .size
                  //                                       .width /
                  //                                   3,
                  //                               height: 100,
                  //                               color: Colors.white,
                  //                               child: Column(
                  //                                 crossAxisAlignment:
                  //                                     CrossAxisAlignment.start,
                  //                                 children: [
                  //                                   const SizedBox(
                  //                                     height: 15,
                  //                                   ),
                  //                                   Text(
                  //                                     '${value.ActiveOrders.data.orders[index].noOfItems}' +
                  //                                         '${" Items"}',
                  //                                     style: const TextStyle(
                  //                                         fontSize: 18,
                  //                                         fontWeight:
                  //                                             FontWeight.w500),
                  //                                   ),
                  //                                   Text(
                  //                                     '${"Table No: "}' +
                  //                                         '${value.ActiveOrders.data.orders[index].tableNo}',
                  //                                     style: const TextStyle(
                  //                                         color: Colors.grey,
                  //                                         fontSize: 15),
                  //                                   ),
                  //                                   Text(
                  //                                     '${"Person: "}' +
                  //                                         '${value.ActiveOrders.data.orders[index].persons}',
                  //                                     style: const TextStyle(
                  //                                         color: Colors.grey,
                  //                                         fontSize: 15),
                  //                                   ),
                  //                                 ],
                  //                               ),
                  //                             ),
                  //                             Container(
                  //                               width: MediaQuery.of(context)
                  //                                       .size
                  //                                       .width /
                  //                                   3.5,
                  //                               height: 100,
                  //                               decoration: BoxDecoration(
                  //                                   color: Colors.transparent,
                  //                                   borderRadius:
                  //                                       BorderRadius.circular(
                  //                                           20)),
                  //                               child: Column(children: [
                  //                                 const SizedBox(
                  //                                   height: 10,
                  //                                 ),
                  //                                 const Text(
                  //                                   "Add Details",
                  //                                   style: TextStyle(
                  //                                       color: Colors.green,
                  //                                       fontSize: 16),
                  //                                 ),
                  //                                 const SizedBox(
                  //                                   height: 15,
                  //                                 ),
                  //                                 const Text(
                  //                                   "price",
                  //                                   style: TextStyle(
                  //                                       fontSize: 17,
                  //                                       color: Colors.grey),
                  //                                 ),
                  //                                 Text(
                  //                                   value
                  //                                       .ActiveOrders
                  //                                       .data
                  //                                       .orders[index]
                  //                                       .grandTotal
                  //                                       .toString(),
                  //                                   style: const TextStyle(
                  //                                       fontSize: 16),
                  //                                 )
                  //                               ]),
                  //                             ),
                  //                           ],
                  //                         ),
                  //                         const Divider(
                  //                           color: Colors.black,
                  //                           thickness: .6,
                  //                           indent: 15,
                  //                           endIndent: 15,
                  //                         ),
                  //                         Row(
                  //                           mainAxisAlignment:
                  //                               MainAxisAlignment.spaceEvenly,
                  //                           children: [
                  //                             SizedBox(
                  //                               width: MediaQuery.of(context)
                  //                                       .size
                  //                                       .width /
                  //                                   2.5,
                  //                               child: ElevatedButton(
                  //                                 onPressed: () {
                  //                                   order_idd = value
                  //                                       .ActiveOrders
                  //                                       .data
                  //                                       .orders[index]
                  //                                       .orderId;
                  //                                   invoicenumber = value
                  //                                       .ActiveOrders
                  //                                       .data
                  //                                       .orders[index]
                  //                                       .invoiceNumber;

                  //                                   cart_masterId = value
                  //                                       .ActiveOrders
                  //                                       .data
                  //                                       .orders[index]
                  //                                       .orderId;
                  //                                   invoice_type = value
                  //                                       .ActiveOrders
                  //                                       .data
                  //                                       .orders[index]
                  //                                       .invoiceType;
                  //                                   TableName = value
                  //                                       .ActiveOrders
                  //                                       .data
                  //                                       .orders[index]
                  //                                       .tableNo;
                  //                                   Provider.of<DataProvider>(
                  //                                           context,
                  //                                           listen: false)
                  //                                       .GetCartOrdersById(
                  //                                           context);
                  //                                   print(cart_masterId);
                  //                                   Navigator.of(context)
                  //                                       .push(MaterialPageRoute(
                  //                                     builder: (context) =>
                  //                                         OrdersPage(),
                  //                                   ));
                  //                                 },
                  //                                 style:
                  //                                     ElevatedButton.styleFrom(
                  //                                   backgroundColor: maincolor,
                  //                                   shape:
                  //                                       RoundedRectangleBorder(
                  //                                           borderRadius:
                  //                                               BorderRadius
                  //                                                   .circular(
                  //                                                       10.0)),
                  //                                 ),
                  //                                 child: const Text(
                  //                                   "Add Items",
                  //                                   style: TextStyle(
                  //                                       color: Colors.white),
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                             SizedBox(
                  //                               width: MediaQuery.of(context)
                  //                                       .size
                  //                                       .width /
                  //                                   2.5,
                  //                               child: ElevatedButton(
                  //                                 onPressed: () {},
                  //                                 style:
                  //                                     ElevatedButton.styleFrom(
                  //                                   backgroundColor: Colors.red,
                  //                                   shape:
                  //                                       RoundedRectangleBorder(
                  //                                           borderRadius:
                  //                                               BorderRadius
                  //                                                   .circular(
                  //                                                       10.0)),
                  //                                 ),
                  //                                 child: const Text(
                  //                                   "Print Bill",
                  //                                   style: TextStyle(
                  //                                       color: Colors.white),
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ],
                  //                         )
                  //                       ],
                  //                     ),
                  //                   ),
                  //                 ),
                  //               );
                  //             } else {
                  //               return null;
                  //             }
                  //           },
                  //         ),
                  //       );
                  //     }
                  //   },
                  // ),