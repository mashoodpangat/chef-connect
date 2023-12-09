// import 'package:chef_connect_project/API/ApiProvider.dart';
// import 'package:chef_connect_project/API/Stateprovider.dart';
// import 'package:chef_connect_project/API/cartOrderModel.dart';
// import 'package:chef_connect_project/FoodItemCategories/ProductCategories.dart';
// import 'package:chef_connect_project/FoodItemCategories/SubCategories.dart';
// import 'package:chef_connect_project/homepage/homepage.dart';
// import 'package:chef_connect_project/itemOrder/Ordermanagement.dart';
// import 'package:chef_connect_project/itemOrder/orders.dart';
// import 'package:chef_connect_project/styleUtils.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class OrderByIdPage extends StatefulWidget {
//   const OrderByIdPage({super.key});

//   @override
//   State<OrderByIdPage> createState() => _OrderByIdState();
// }

// late DataProvider activeOrderByIdprovider;
// late DataProvider CartOrderByIdprovider;
// bool _isInitialized = false;

// class _OrderByIdState extends State<OrderByIdPage> {
//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       // activeOrderByIdprovider =
//       //     Provider.of<DataProvider>(context, listen: false);
//       // activeOrderByIdprovider.GetActiveOrdersById();
//       // CartOrderByIdprovider = Provider.of<DataProvider>(context, listen: false);
//       // CartOrderByIdprovider.GetCartOrdersById();
//     });

//     // calculateGrandTotal();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: maincolor,
//       appBar: AppBar(
//         backgroundColor: maincolor,
//         leading: IconButton(
//             onPressed: () {
//               order_idd = 0;
//               cart_masterId = 0;
//               invoicenumber = 0;
//               selectedProducts.clear();
//               invoice_type = "";

//               Navigator.pop(context);
//             },
//             icon: Icon(
//               Icons.arrow_back_ios_new_outlined,
//               size: 25,
//               color: Colors.white,
//             )),
//         title: Text(
//           "Orders: " + '${order_idd}',
//           style: TextStyle(color: Colors.white, fontSize: 19),
//         ),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 print(order_idd);
//                 print(selectedProducts);
//                 print(invoicenumber);
//                 print("cart master=${cart_masterId}");
//                 print(invoice_type);
//               },
//               icon: Icon(
//                 Icons.more_vert,
//                 size: 25,
//                 color: Colors.white,
//               ))
//         ],
//       ),
//       body: WillPopScope(
//         onWillPop: () async {
//           setState(() {
//             cart_masterId = 0;
//             invoicenumber = 0;
//             order_idd = 0;
//             selectedProducts.clear();
//           });
//           return true;
//         },
//         child: Consumer<DataProvider>(
//           builder: (context, value, child) {
//             if (invoice_type == "SO") {
//               return Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(25),
//                       topRight: Radius.circular(25)),
//                 ),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 20),
//                         child: Container(
//                           width: MediaQuery.of(context).size.width - 40,
//                           height: MediaQuery.of(context).size.height / 9,
//                           decoration: BoxDecoration(
//                               color: Colors.grey[200],
//                               borderRadius: BorderRadius.circular(15)),
//                           child: Center(
//                             child: ListTile(
//                               leading: Container(
//                                 width: 70,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                     color: maingreycolor,
//                                     borderRadius: BorderRadius.circular(12)),
//                               ),
//                               title: Text(
//                                 "Name :",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 17),
//                               ),
//                               subtitle: Text(
//                                 "Order : ${order_idd}",
//                                 style: TextStyle(fontSize: 17),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 30),
//                         child: Text(
//                           "Items",
//                           style: TextStyle(fontSize: 18),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Center(
//                         child: Consumer<DataProvider>(
//                           builder: (context, value, child) {
//                             if (value.isLoading) {
//                               return Center(
//                                 child: CircularProgressIndicator(),
//                               );
//                             } else {
//                               return Container(
//                                 decoration: BoxDecoration(
//                                     color: Colors.transparent,
//                                     border: Border.all(
//                                       color: Colors.grey,
//                                     ),
//                                     borderRadius: BorderRadius.circular(15)),
//                                 width: MediaQuery.of(context).size.width - 30,
//                                 height:
//                                     MediaQuery.of(context).size.height / 2.1,
//                                 child: ListView.separated(
//                                   itemCount: selectedProducts.length,
//                                   separatorBuilder: (context, index) => Divider(
//                                     color: Colors.grey[400],
//                                   ),
//                                   itemBuilder: (context, index) {
//                                     return Padding(
//                                       padding: const EdgeInsets.only(top: 10),
//                                       child: InkWell(
//                                         onTap: () {
//                                           showDialog(
//                                             context: context,
//                                             builder: (BuildContext context) {
//                                               int quantity =
//                                                   selectedProducts[index]
//                                                       ["Qty"];
//                                               return AlertDialog(
//                                                 title: Text("Change Quantity"),
//                                                 content: Column(
//                                                   mainAxisSize:
//                                                       MainAxisSize.min,
//                                                   children: [
//                                                     Text(
//                                                         "Product: ${selectedProducts[index]["name"]}"),
//                                                     SizedBox(height: 10),
//                                                     Text(
//                                                         "Current Quantity: $quantity"),
//                                                     SizedBox(height: 10),
//                                                     TextField(
//                                                       keyboardType:
//                                                           TextInputType.number,
//                                                       decoration:
//                                                           InputDecoration(
//                                                         labelText:
//                                                             "New Quantity",
//                                                       ),
//                                                       onChanged: (newValue) {
//                                                         // Update the quantity when the user types a new value
//                                                         quantity = int.tryParse(
//                                                                 newValue) ??
//                                                             quantity;
//                                                       },
//                                                     ),
//                                                   ],
//                                                 ),
//                                                 actions: <Widget>[
//                                                   TextButton(
//                                                     child: Text("Cancel"),
//                                                     onPressed: () {
//                                                       Navigator.of(context)
//                                                           .pop();
//                                                     },
//                                                   ),
//                                                   TextButton(
//                                                     child: Text("OK"),
//                                                     onPressed: () {
//                                                       // Update the quantity in the selectedProducts list
//                                                       setState(() {
//                                                         selectedProducts[index]
//                                                             ["Qty"] = quantity;
//                                                       });

//                                                       Provider.of<Stateprovider>(
//                                                               context,
//                                                               listen: false)
//                                                           .calculateGrandTotal(
//                                                               selectedProducts);

//                                                       Navigator.of(context)
//                                                           .pop();
//                                                     },
//                                                   ),
//                                                 ],
//                                               );
//                                             },
//                                           );
//                                         },
//                                         child: Container(
//                                           width:
//                                               MediaQuery.of(context).size.width,
//                                           height: 90,
//                                           decoration: BoxDecoration(
//                                             color: Colors.transparent,
//                                             borderRadius:
//                                                 BorderRadius.circular(12),
//                                           ),
//                                           child: Row(
//                                             children: [
//                                               Container(
//                                                 width: MediaQuery.of(context)
//                                                         .size
//                                                         .width /
//                                                     1.6,
//                                                 height: 100,
//                                                 color: Colors.transparent,
//                                                 child: ListTile(
//                                                   title: Text(
//                                                     selectedProducts[index]
//                                                             ["name"]
//                                                         .toString(),

//                                                     // value.ActiveOrdersById.data
//                                                     //     .details[index].itemName,
//                                                     // "",
//                                                     style:
//                                                         TextStyle(fontSize: 18),
//                                                   ),
//                                                   subtitle: Text(
//                                                     "Qty:${selectedProducts[index]["Qty"]} * ${selectedProducts[index]["SalesPrice"]} ",
//                                                     // "Qty:${value.ActiveOrdersById.data.details[index].qty} * ${value.ActiveOrdersById.data.details[index].rate} ",
//                                                     // "assvvadsv",
//                                                     style: TextStyle(
//                                                         fontSize: 18,
//                                                         color: Colors.black),
//                                                   ),
//                                                 ),
//                                               ),
//                                               Column(
//                                                 children: [
//                                                   Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             left: 50),
//                                                     child: IconButton(
//                                                         onPressed: () {},
//                                                         icon: Icon(
//                                                           Icons
//                                                               .delete_outline_sharp,
//                                                           size: 30,
//                                                         )),
//                                                   ),
//                                                   Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment.start,
//                                                     children: [
//                                                       Text(
//                                                         "Price:",
//                                                         style: TextStyle(
//                                                             fontSize: 17),
//                                                       ),
//                                                       Text(
//                                                         "${selectedProducts[index]["Qty"] * selectedProducts[index]["SalesPrice"]}",
//                                                         // "${value.ActiveOrdersById.data.details[index].qty * value.ActiveOrdersById.data.details[index].rate}",

//                                                         // "3224",
//                                                         style: TextStyle(
//                                                             fontSize: 18,
//                                                             color: Colors.blue),
//                                                       ),
//                                                     ],
//                                                   )
//                                                 ],
//                                               )
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               );
//                             }
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Center(
//                         child: SizedBox(
//                           height: 55,
//                           width: MediaQuery.of(context).size.width - 50,
//                           child: Consumer<DataProvider>(
//                             builder: (context, value, child) {
//                               return ElevatedButton(
//                                 onPressed: () {
//                                   // for (final item
//                                   //     in value.ActiveOrdersById.data.details) {
//                                   //   selectedProducts.add({
//                                   //     "Barcode": item.barcode,
//                                   //     "Qty": item.qty,
//                                   //     "UnitID": item.unitId,
//                                   //     "SalesPrice": item.rate,
//                                   //     "Modifier": item.scannedBarcode,
//                                   //     "name": item.itemName
//                                   //   });
//                                   // }
//                                   print(selectedProducts);
//                                   Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (context) {
//                                       return SubCategoriesPage();
//                                     },
//                                   ));
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: maincolor,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10.0),
//                                   ),
//                                 ),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Add more dish",
//                                       style: TextStyle(
//                                           color: Colors.white, fontSize: 20),
//                                     ),
//                                     Icon(
//                                       Icons.add_circle_outline,
//                                       color: Colors.white,
//                                       size: 30,
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Center(
//                         child: Consumer<DataProvider>(
//                           builder: (context, value, child) {
//                             if (value.isLoading) {
//                               return Container();
//                             } else {
//                               return Container(
//                                 width: MediaQuery.of(context).size.width - 40,
//                                 height: 200,
//                                 color: Colors.transparent,
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Item total",
//                                           style: TextStyle(
//                                               fontSize: 20, color: Colors.grey),
//                                         ),
//                                         Text(
//                                           "Price:",
//                                           style: TextStyle(
//                                               fontSize: 20, color: Colors.grey),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Gst & Tax",
//                                           style: TextStyle(
//                                               fontSize: 20, color: Colors.grey),
//                                         ),
//                                         Text(
//                                           "0",
//                                           style: TextStyle(
//                                               fontSize: 20, color: Colors.grey),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Server Time",
//                                           style: TextStyle(
//                                               fontSize: 20, color: Colors.grey),
//                                         ),
//                                         Text(
//                                           "0 min",
//                                           style: TextStyle(
//                                               fontSize: 20, color: Colors.grey),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Member discount",
//                                           style: TextStyle(fontSize: 20),
//                                         ),
//                                         Text(
//                                           "0",
//                                           style: TextStyle(
//                                               fontSize: 20, color: Colors.grey),
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Grand Total",
//                                           style: TextStyle(fontSize: 20),
//                                         ),
//                                         Consumer<DataProvider>(
//                                           builder: (context, value, child) {
//                                             return Text(
//                                               " ${Provider.of<Stateprovider>(context).grandTotal}",
//                                               style: TextStyle(
//                                                   fontSize: 20,
//                                                   color: Colors.blue,
//                                                   fontWeight: FontWeight.bold),
//                                             );
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }
//                           },
//                         ),
//                       ),
//                       Divider(
//                         endIndent: 15,
//                         indent: 15,
//                         color: Colors.grey[300],
//                       ),
//                       TextButton(
//                           onPressed: () {},
//                           child: Text(
//                             "Add mobile number",
//                             style: TextStyle(fontSize: 18, color: Colors.blue),
//                           )),
//                       Divider(
//                         endIndent: 15,
//                         indent: 15,
//                         color: Colors.grey[300],
//                       ),
//                       TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           "Rate Now",
//                           style: TextStyle(fontSize: 18, color: Colors.blue),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             } else {
//               return Column(
//                 children: [
//                   Expanded(
//                     flex: 9,
//                     child: Container(
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height,
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(25),
//                             topRight: Radius.circular(25)),
//                       ),
//                       child: SingleChildScrollView(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 20),
//                               child: Container(
//                                 width: MediaQuery.of(context).size.width - 40,
//                                 height: MediaQuery.of(context).size.height / 9,
//                                 decoration: BoxDecoration(
//                                     color: Colors.grey[200],
//                                     borderRadius: BorderRadius.circular(15)),
//                                 child: Center(
//                                   child: ListTile(
//                                     leading: Container(
//                                       width: 70,
//                                       height: 60,
//                                       decoration: BoxDecoration(
//                                           color: maingreycolor,
//                                           borderRadius:
//                                               BorderRadius.circular(12)),
//                                     ),
//                                     title: Text(
//                                       "Name :",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 17),
//                                     ),
//                                     subtitle: Text(
//                                       "Order : ${cart_masterId}",
//                                       style: TextStyle(fontSize: 17),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 30),
//                               child: Text(
//                                 "Items",
//                                 style: TextStyle(fontSize: 18),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Center(
//                               child: Consumer<DataProvider>(
//                                 builder: (context, value, child) {
//                                   if (value.isLoading) {
//                                     return Center(
//                                       child: CircularProgressIndicator(),
//                                     );
//                                   } else {
//                                     return Container(
//                                       decoration: BoxDecoration(
//                                           color: Colors.transparent,
//                                           border: Border.all(
//                                             color: Colors.grey,
//                                           ),
//                                           borderRadius:
//                                               BorderRadius.circular(15)),
//                                       width: MediaQuery.of(context).size.width -
//                                           30,
//                                       height:
//                                           MediaQuery.of(context).size.height /
//                                               2.1,
//                                       child: ListView.separated(
//                                         itemCount: selectedProducts.length,
//                                         separatorBuilder: (context, index) =>
//                                             Divider(
//                                           color: Colors.grey[400],
//                                         ),
//                                         itemBuilder: (context, index) {
//                                           return Padding(
//                                             padding:
//                                                 const EdgeInsets.only(top: 10),
//                                             child: InkWell(
//                                               onTap: () {
//                                                 showDialog(
//                                                   context: context,
//                                                   builder:
//                                                       (BuildContext context) {
//                                                     // double quantity = value
//                                                     //     .ActiveOrdersById
//                                                     //     .data
//                                                     //     .details[index]
//                                                     //     .qty;
//                                                     //     selectedProducts[index]["Qty"];
//                                                     return AlertDialog(
//                                                       title: Text(
//                                                           "Change Quantity"),
//                                                       content: Column(
//                                                         mainAxisSize:
//                                                             MainAxisSize.min,
//                                                         children: [
//                                                           Text(
//                                                               // "Product: ${value.CartOrdersById.data.details[index].itemName}"
//                                                               ""),
//                                                           SizedBox(height: 10),
//                                                           Text(
//                                                             // "Current Quantity: ${quantity}"
//                                                             "",
//                                                           ),
//                                                           SizedBox(height: 10),
//                                                           TextField(
//                                                             keyboardType:
//                                                                 TextInputType
//                                                                     .number,
//                                                             decoration:
//                                                                 InputDecoration(
//                                                               labelText:
//                                                                   "New Quantity",
//                                                             ),
//                                                             onChanged:
//                                                                 (newValue) {
//                                                               // Update the quantity when the user types a new value
//                                                               // quantity =
//                                                               //     int.tryParse(newValue) ??
//                                                               //         quantity;
//                                                               // double
//                                                               //     newQuantity =
//                                                               //     double.tryParse(
//                                                               //             newValue) ??
//                                                               //         quantity;
//                                                               // print(newValue);
//                                                               setState(() {
//                                                                 // Update the quantity in the data model
//                                                                 // value
//                                                                 //     .ActiveOrdersById
//                                                                 //     .data
//                                                                 //     .details[
//                                                                 //         index]
//                                                                 //     .qty = newQuantity;
//                                                               });
//                                                               // value.ActiveOrdersById.data
//                                                               //         .details[index].qty =
//                                                               //     double.tryParse(newValue) ??
//                                                               //         quantity;
//                                                             },
//                                                           ),
//                                                         ],
//                                                       ),
//                                                       actions: <Widget>[
//                                                         TextButton(
//                                                           child: Text("Cancel"),
//                                                           onPressed: () {
//                                                             Navigator.of(
//                                                                     context)
//                                                                 .pop();
//                                                           },
//                                                         ),
//                                                         TextButton(
//                                                           child: Text("OK"),
//                                                           onPressed: () {
//                                                             // Update the quantity in the selectedProducts list
//                                                             // setState(() {

//                                                             //   value
//                                                             //       .ActiveOrdersById
//                                                             //       .data
//                                                             //       .details[index]
//                                                             //       .qty = quantity;
//                                                             // });

//                                                             // Provider.of<Stateprovider>(
//                                                             //         context,
//                                                             //         listen: false)
//                                                             //     .calculateGrandTotal(
//                                                             //         selectedProducts);

//                                                             Navigator.of(
//                                                                     context)
//                                                                 .pop();
//                                                           },
//                                                         ),
//                                                       ],
//                                                     );
//                                                   },
//                                                 );
//                                               },
//                                               child: Container(
//                                                 width: MediaQuery.of(context)
//                                                     .size
//                                                     .width,
//                                                 height: 90,
//                                                 decoration: BoxDecoration(
//                                                   color: Colors.transparent,
//                                                   borderRadius:
//                                                       BorderRadius.circular(12),
//                                                 ),
//                                                 child: Row(
//                                                   children: [
//                                                     Container(
//                                                       width:
//                                                           MediaQuery.of(context)
//                                                                   .size
//                                                                   .width /
//                                                               1.6,
//                                                       height: 100,
//                                                       color: Colors.transparent,
//                                                       child: ListTile(
//                                                         title: Text(
//                                                           selectedProducts[
//                                                                   index]["name"]
//                                                               .toString(),
//                                                           // value
//                                                           //     .CartOrdersById
//                                                           //     .data
//                                                           //     .details[index]
//                                                           //     .itemName,
//                                                           // "",
//                                                           style: TextStyle(
//                                                               fontSize: 18),
//                                                         ),
//                                                         subtitle: Text(
//                                                           "Qty:${selectedProducts[index]["Qty"]} * ${selectedProducts[index]["SalesPrice"]} ",
//                                                           // "Qty:${value.CartOrdersById.data.details[index].quantity.toString()} * ${value.CartOrdersById.data.details[index].salesPrice.toString()} ",
//                                                           // "assvvadsv",
//                                                           style: TextStyle(
//                                                               fontSize: 18,
//                                                               color:
//                                                                   Colors.black),
//                                                         ),
//                                                       ),
//                                                     ),
//                                                     Column(
//                                                       children: [
//                                                         Padding(
//                                                           padding:
//                                                               const EdgeInsets
//                                                                       .only(
//                                                                   left: 50),
//                                                           child: IconButton(
//                                                               onPressed: () {},
//                                                               icon: Icon(
//                                                                 Icons
//                                                                     .delete_outline_sharp,
//                                                                 size: 30,
//                                                               )),
//                                                         ),
//                                                         Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             Text(
//                                                               "Price:",
//                                                               style: TextStyle(
//                                                                   fontSize: 17),
//                                                             ),
//                                                             Text(
//                                                               "${selectedProducts[index]["Qty"] * selectedProducts[index]["SalesPrice"]}"
//                                                                   .toString(),

//                                                               // "3224",
//                                                               style: TextStyle(
//                                                                   fontSize: 18,
//                                                                   color: Colors
//                                                                       .blue),
//                                                             ),
//                                                           ],
//                                                         )
//                                                       ],
//                                                     )
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     );
//                                   }
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Center(
//                               child: SizedBox(
//                                 height: 55,
//                                 width: MediaQuery.of(context).size.width - 50,
//                                 child: Consumer<DataProvider>(
//                                   builder: (context, value, child) {
//                                     return ElevatedButton(
//                                       onPressed: () {
//                                         // for (final item in value
//                                         //     .CartOrdersById.data.details) {
//                                         //   selectedProducts.add({
//                                         //     "Barcode": item.barcode,
//                                         //     "Qty": item.quantity,
//                                         //     "UnitID": item.unitID,
//                                         //     "SalesPrice": item.salesPrice,
//                                         //     "Modifier": item.modifier,
//                                         //     "name": item.itemName
//                                         //   });
//                                         // }
//                                         print(selectedProducts);
//                                         Navigator.of(context)
//                                             .push(MaterialPageRoute(
//                                           builder: (context) {
//                                             return SubCategoriesPage();
//                                           },
//                                         ));
//                                       },
//                                       style: ElevatedButton.styleFrom(
//                                         backgroundColor: maincolor,
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(10.0),
//                                         ),
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             "Add more dish",
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 20),
//                                           ),
//                                           Icon(
//                                             Icons.add_circle_outline,
//                                             color: Colors.white,
//                                             size: 30,
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   },
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 30,
//                             ),
//                             Center(
//                               child: Consumer<DataProvider>(
//                                 builder: (context, value, child) {
//                                   if (value.isLoading) {
//                                     return Container();
//                                   } else {
//                                     return Container(
//                                       width: MediaQuery.of(context).size.width -
//                                           40,
//                                       height: 200,
//                                       color: Colors.transparent,
//                                       child: Column(
//                                         children: [
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 "Item total",
//                                                 style: TextStyle(
//                                                     fontSize: 20,
//                                                     color: Colors.grey),
//                                               ),
//                                               Text(
//                                                 "Price: ${""}",
//                                                 style: TextStyle(
//                                                     fontSize: 20,
//                                                     color: Colors.grey),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 10,
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 "Gst & Tax",
//                                                 style: TextStyle(
//                                                     fontSize: 20,
//                                                     color: Colors.grey),
//                                               ),
//                                               Text(
//                                                 "0",
//                                                 style: TextStyle(
//                                                     fontSize: 20,
//                                                     color: Colors.grey),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 10,
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 "Server Time",
//                                                 style: TextStyle(
//                                                     fontSize: 20,
//                                                     color: Colors.grey),
//                                               ),
//                                               Text(
//                                                 "0 min",
//                                                 style: TextStyle(
//                                                     fontSize: 20,
//                                                     color: Colors.grey),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 10,
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 "Member discount",
//                                                 style: TextStyle(fontSize: 20),
//                                               ),
//                                               Text(
//                                                 "0",
//                                                 style: TextStyle(
//                                                     fontSize: 20,
//                                                     color: Colors.grey),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 10,
//                                           ),
//                                           Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.spaceBetween,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Text(
//                                                 "Grand Total",
//                                                 style: TextStyle(fontSize: 20),
//                                               ),
//                                               Consumer<DataProvider>(
//                                                 builder:
//                                                     (context, value, child) {
//                                                   return Text(
//                                                     " ${""}",
//                                                     style: TextStyle(
//                                                         fontSize: 20,
//                                                         color: Colors.blue,
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   );
//                                                 },
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     );
//                                   }
//                                 },
//                               ),
//                             ),
//                             Divider(
//                               endIndent: 15,
//                               indent: 15,
//                               color: Colors.grey[300],
//                             ),
//                             TextButton(
//                                 onPressed: () {},
//                                 child: Text(
//                                   "Add mobile number",
//                                   style: TextStyle(
//                                       fontSize: 18, color: Colors.blue),
//                                 )),
//                             Divider(
//                               endIndent: 15,
//                               indent: 15,
//                               color: Colors.grey[300],
//                             ),
//                             TextButton(
//                               onPressed: () {},
//                               child: Text(
//                                 "Rate Now",
//                                 style:
//                                     TextStyle(fontSize: 18, color: Colors.blue),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Container(
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(color: Colors.grey, blurRadius: 7)
//                           ]),
//                       child: Center(
//                         child: SizedBox(
//                           height: 55,
//                           width: MediaQuery.of(context).size.width - 40,
//                           child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: maincolor,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                 ),
//                               ),
//                               onPressed: () {
//                                 Provider.of<DataProvider>(context,
//                                         listen: false)
//                                     .GetcartToActiveOrder();
//                                 cart_masterId = 0;
//                                 order_idd = 0;
//                                 invoicenumber = 0;

//                                 selectedProducts.clear();
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                   builder: (context) => homepage(),
//                                 ));
//                               },
//                               child: Text(
//                                 "Confirm Order",
//                                 style: TextStyle(color: Colors.white),
//                               )),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
