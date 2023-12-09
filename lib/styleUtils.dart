import 'package:flutter/material.dart';

const wcolor = Colors.white;
const greycolor = Colors.grey;
const maincolor = Color.fromARGB(255, 5, 35, 69);
const maingreycolor = Color.fromARGB(255, 42, 44, 56);

List<String> orderTypes = [
  'Active Orders',
  'Dine-In',
  'Take-way',
  'Parcel',
];

final MainColor = Color.fromARGB(245, 246, 253, 255);

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor,
      appBar: AppBar(
        backgroundColor: MainColor,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        title: Text("Dashboard"),
        actions: [
          Container(
            width: 40,
            height: 40,
            color: Colors.white,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
          ),
        ],
        elevation: 0,
      ),
    );
  }
}
  // return InkWell(
  //                                     onTap: () {

  //                                       showDialog(
  //                                         context: context,
  //                                         builder: (BuildContext context) {
  //                                           int quantity =
  //                                               selectedProducts[index]["Qty"];
  //                                           return AlertDialog(
  //                                             title:
  //                                                 const Text("Change Quantity"),
  //                                             content: Column(
  //                                               mainAxisSize: MainAxisSize.min,
  //                                               children: [
  //                                                 Text(
  //                                                     "Product: ${selectedProducts[index]["name"]}"),
  //                                                 const SizedBox(height: 10),
  //                                                 Text(
  //                                                     "Current Quantity: $quantity"),
  //                                                 const SizedBox(height: 10),
  //                                                 TextField(
  //                                                   keyboardType:
  //                                                       TextInputType.number,
  //                                                   decoration:
  //                                                       const InputDecoration(
  //                                                     labelText: "New Quantity",
  //                                                   ),
  //                                                   onChanged: (newValue) {
  //                                                     // Update the quantity when the user types a new value
  //                                                     quantity = int.tryParse(
  //                                                             newValue) ??
  //                                                         quantity;
  //                                                   },
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                             actions: <Widget>[
  //                                               TextButton(
  //                                                 child: const Text("Cancel"),
  //                                                 onPressed: () {
  //                                                   Navigator.of(context).pop();
  //                                                 },
  //                                               ),
  //                                               TextButton(
  //                                                 child: const Text("OK"),
  //                                                 onPressed: () {
  //                                                   // Update the quantity in the selectedProducts list
  //                                                   // setState(() {
  //                                                   //   selectedProducts[index]
  //                                                   //       ["Qty"] = quantity;
  //                                                   // });

  //                                                   Provider.of<Stateprovider>(
  //                                                           context,
  //                                                           listen: false)
  //                                                       .updateQuantity(
  //                                                           index, quantity);

  //                                                   Provider.of<Stateprovider>(
  //                                                           context,
  //                                                           listen: false)
  //                                                       .calculateGrandTotal(
  //                                                           selectedProducts);

  //                                                   Navigator.of(context).pop();
  //                                                 },
  //                                               ),
  //                                             ],
  //                                           );
  //                                         },
  //                                       );
  //                                     },
  //                                     child: Slidable(
  //                                       endActionPane: ActionPane(
  //                                           extentRatio: .25,
  //                                           motion: StretchMotion(),
  //                                           children: [
  //                                             SlidableAction(
  //                                               autoClose: true,
  //                                               borderRadius:
  //                                                   BorderRadius.circular(12),
  //                                               onPressed: (context) {
  //                                                 //////////delete item///////////////
  //                                                 showDialog(
  //                                                   barrierDismissible: false,
  //                                                   context: context,
  //                                                   builder:
  //                                                       (BuildContext context) {
  //                                                     return Dialog(
  //                                                       child: Container(
  //                                                         padding: EdgeInsets
  //                                                             .symmetric(
  //                                                                 horizontal:
  //                                                                     32,
  //                                                                 vertical: 16),
  //                                                         decoration:
  //                                                             BoxDecoration(
  //                                                           color: wcolor,
  //                                                           borderRadius:
  //                                                               BorderRadius
  //                                                                   .circular(
  //                                                                       20),
  //                                                         ),
  //                                                         child: Column(
  //                                                           mainAxisSize:
  //                                                               MainAxisSize
  //                                                                   .min,
  //                                                           children: [
  //                                                             Container(
  //                                                               height: 100,
  //                                                               width: 100,
  //                                                               color: Colors
  //                                                                   .transparent,
  //                                                               child: Lottie
  //                                                                   .asset(
  //                                                                 "assetslottie/delete icon lottie.json",
  //                                                               ),
  //                                                             ),
  //                                                             Text(
  //                                                               "Are you Sure ?",
  //                                                               style: TextStyle(
  //                                                                   fontSize:
  //                                                                       20),
  //                                                             ),
  //                                                             SizedBox(
  //                                                               height: 20,
  //                                                             ),
  //                                                             Row(
  //                                                               mainAxisAlignment:
  //                                                                   MainAxisAlignment
  //                                                                       .spaceBetween,
  //                                                               children: [
  //                                                                 SizedBox(
  //                                                                   width: 100,
  //                                                                   height: 40,
  //                                                                   child:
  //                                                                       ElevatedButton(
  //                                                                     onPressed:
  //                                                                         () {
  //                                                                       Navigator.of(context)
  //                                                                           .pop();
  //                                                                     },
  //                                                                     style: ElevatedButton
  //                                                                         .styleFrom(
  //                                                                       backgroundColor:
  //                                                                           Colors.grey[600],
  //                                                                       shape: RoundedRectangleBorder(
  //                                                                           borderRadius:
  //                                                                               BorderRadius.circular(12)),
  //                                                                     ),
  //                                                                     child:
  //                                                                         Text(
  //                                                                       "No",
  //                                                                       style: TextStyle(
  //                                                                           color:
  //                                                                               Colors.white),
  //                                                                     ),
  //                                                                   ),
  //                                                                 ),
  //                                                                 SizedBox(
  //                                                                   width: 100,
  //                                                                   height: 40,
  //                                                                   child:
  //                                                                       ElevatedButton(
  //                                                                     onPressed:
  //                                                                         () async {
  //                                                                       setState(
  //                                                                           () {
  //                                                                         selectedProducts
  //                                                                             .removeAt(index);

  //                                                                         Provider.of<Stateprovider>(context, listen: false)
  //                                                                             .calculateGrandTotal(selectedProducts);
  //                                                                       });
  //                                                                       Navigator.of(context)
  //                                                                           .pop();
  //                                                                     },
  //                                                                     style: ElevatedButton
  //                                                                         .styleFrom(
  //                                                                       backgroundColor:
  //                                                                           maincolor,
  //                                                                       shape: RoundedRectangleBorder(
  //                                                                           borderRadius:
  //                                                                               BorderRadius.circular(12)),
  //                                                                     ),
  //                                                                     child:
  //                                                                         Text(
  //                                                                       "Yes",
  //                                                                       style: TextStyle(
  //                                                                           color:
  //                                                                               Colors.white),
  //                                                                     ),
  //                                                                   ),
  //                                                                 ),
  //                                                               ],
  //                                                             )
  //                                                           ],
  //                                                         ),
  //                                                       ),
  //                                                     );
  //                                                   },
  //                                                 );
  //                                               },
  //                                               icon: Icons.delete,
  //                                               backgroundColor: maingreycolor,
  //                                               label: "Delete",
  //                                             )
  //                                           ]),
  //                                       child: Container(
  //                                         height: "${selectedProducts[index]["name"]}"
  //                                                         .length <=
  //                                                     20 ||
  //                                                 "${selectedProducts[index]["Modifier"]}"
  //                                                     .isEmpty
  //                                             ? 75
  //                                             : 95,
  //                                         decoration: BoxDecoration(
  //                                           color: Colors.transparent,
  //                                           borderRadius:
  //                                               BorderRadius.circular(12),
  //                                         ),
  //                                         child: Row(
  //                                           children: [
  //                                             Container(
  //                                               width: MediaQuery.of(context)
  //                                                       .size
  //                                                       .width /
  //                                                   1.45,
  //                                               height: 95,
  //                                               color: Colors.transparent,
  //                                               child: Column(
  //                                                 crossAxisAlignment:
  //                                                     CrossAxisAlignment.start,
  //                                                 children: [
  //                                                   // ListTile(
  //                                                   //   title: Text(
  //                                                   //     selectedProducts[index]
  //                                                   //             ["name"]
  //                                                   //         .toString(),
  //                                                   //     style: const TextStyle(
  //                                                   //         fontSize: 17),
  //                                                   //   ),
  //                                                   // ),
  //                                                   Padding(
  //                                                     padding:
  //                                                         const EdgeInsets.only(
  //                                                             left: 10),
  //                                                     child: Text(
  //                                                       selectedProducts[index]
  //                                                               ["name"]
  //                                                           .toString(),
  //                                                       style: const TextStyle(
  //                                                           fontSize: 17),
  //                                                       overflow:
  //                                                           TextOverflow.clip,
  //                                                     ),
  //                                                   ),
  //                                                   Padding(
  //                                                     padding:
  //                                                         const EdgeInsets.only(
  //                                                             left: 10),
  //                                                     child: Text(
  //                                                       //
  //                                                       "Qty:${selectedProducts[index]["Qty"]} X   ${selectedProducts[index]["SalesPrice"]} ",
  //                                                       style: const TextStyle(
  //                                                           fontSize: 17,
  //                                                           color:
  //                                                               Colors.black),
  //                                                     ),
  //                                                   ),
  //                                                   Padding(
  //                                                     padding:
  //                                                         const EdgeInsets.only(
  //                                                             left: 10),
  //                                                     child: Text(
  //                                                       "${selectedProducts[index]["Modifier"]}",
  //                                                       style: TextStyle(
  //                                                           fontSize: 16,
  //                                                           color: Colors
  //                                                               .grey.shade700),
  //                                                       overflow:
  //                                                           TextOverflow.clip,
  //                                                     ),
  //                                                   )
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                             Row(
  //                                               children: [
  //                                                 Text(
  //                                                   "Price:",
  //                                                   style: const TextStyle(
  //                                                       fontSize: 17),
  //                                                 ),
  //                                                 Text(
  //                                                   "${selectedProducts[index]["Qty"] * selectedProducts[index]["SalesPrice"]}",
  //                                                   // "",
  //                                                   style: const TextStyle(
  //                                                       fontSize: 17,
  //                                                       color: Colors.blue,
  //                                                       overflow:
  //                                                           TextOverflow.clip),
  //                                                 ),
  //                                               ],
  //                                             )
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   );
