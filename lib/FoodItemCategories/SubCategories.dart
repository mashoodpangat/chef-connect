import 'dart:async';

import 'package:chef_connect_project/API/ApiProvider.dart';
import 'package:chef_connect_project/API/Stateprovider.dart';
import 'package:chef_connect_project/FoodItemCategories/ProductCategories.dart';
import 'package:chef_connect_project/FoodItemCategories/bottomSheet.dart';
import 'package:chef_connect_project/SelectTables.dart/selectTables.dart';
import 'package:chef_connect_project/ToggleSwitch.dart';
import 'package:chef_connect_project/createOrder.dart/SelectServerType.dart';
import 'package:chef_connect_project/homepage/homepage.dart';
import 'package:chef_connect_project/itemOrder/Ordermanagement.dart';
import 'package:chef_connect_project/itemOrder/orders.dart';

import 'package:chef_connect_project/styleUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

String catId = "";
late DataProvider subCategoriesprovider;
late DataProvider subCategoriesSearchprovider;
late DataProvider productSearchprovider;
late Stateprovider calculateprovider;

class SubCategoriesPage extends StatefulWidget {
  SubCategoriesPage({
    super.key,
  });

  @override
  State<SubCategoriesPage> createState() => _SubCategoriesPageState();
}

TextEditingController searchController = TextEditingController();
bool isSwitched = false;

class _SubCategoriesPageState extends State<SubCategoriesPage> {
  @override
  void initState() {
    super.initState();
    // Initialize your providers and other initial state here.
    subCategoriesprovider = Provider.of<DataProvider>(context, listen: false);
    subCategoriesprovider.getsubCategories();
    productSearchprovider = Provider.of<DataProvider>(context, listen: false);
    productSearchprovider.GetProductsSearch(searchController.text);
    calculateprovider = Provider.of<Stateprovider>(context, listen: false);
    calculateprovider.calculateGrandTotal(selectedProducts);
    searchController.clear();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    return WillPopScope(
      onWillPop: () async {
        //
        setState(() {
          searchController.clear();
          tableId = 0;
          deliveryTtype = "";
          selectedProducts = [];
          dialogBoxOrderCancel(context);
        });
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: maincolor,
        appBar: AppBar(
          title: Text(
            "Sub Categories",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          backgroundColor: maincolor,
          leading: IconButton(
              onPressed: () {
                // _formKey.currentState?.reset();
                setState(() {
                  isSwitched = false;
                });

                if (selectedProducts.length >= 1) {
                  dialogBoxOrderCancel(context);
                } else {
                  deliveryTtype = "";
                  tableId = 0;
                  selectedProducts = [];
                  searchController.clear();
                  Get.to(() => homepage(), transition: Transition.fade);
                }
              },
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 25,
                color: Colors.white,
              )),
          actions: [
            IconButton(
                onPressed: () {
                  // DataProvider().GetItemsOrders(index);
                  print("adsf");
                  print(myLocation);
                  print(TableName);
                  print(selectedSeatIndex);
                  print(tableId);
                  print("seatnumber ${personNumber}");
                },
                icon: Icon(
                  Icons.more_vert,
                  size: 25,
                  color: Colors.white,
                ))
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 40,
                  decoration: BoxDecoration(
                      color: wcolor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15))),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Veg Only",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        FlutterSwitch(
                          toggleColor: maincolor,
                          activeIcon: Icon(
                            Icons.offline_pin,
                            color: Colors.white,
                          ),
                          width: 60.0,
                          height: 28.0,
                          value: isSwitched,
                          activeColor: Colors.green,
                          inactiveColor: Colors.grey,
                          activeText: "ON",
                          inactiveText: "OFF",
                          onToggle: (value) {
                            setState(() {
                              isSwitched = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 55,
                      width: MediaQuery.of(context).size.width - 20,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: TextFormField(
                          controller: searchController,
                          onChanged: (values) {
                            Provider.of<DataProvider>(context, listen: false)
                                .GetProductsSearch(values);
                          },
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.black)),
                              filled: true,
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 172, 171, 171)),
                              hintText: "Search for",
                              fillColor: const Color.fromARGB(255, 42, 44, 56),
                              suffixIcon: Icon(
                                Icons.search_sharp,
                                color: Colors.white,
                              )),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "Select for",
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 2,
                      endIndent: 25,
                      indent: 25,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      flex: 9,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Consumer<DataProvider>(
                            builder: (context, value, child) {
                          if (value.isLoading) {
                            return shimmersSubcategories(context);
                            // return Center(
                            //   child: CircularProgressIndicator(),
                            // );
                          } else if (searchController.text.isEmpty) {
                            return Container(
                              color: Colors.transparent,
                              child: GridView.builder(
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 20,
                                        childAspectRatio: 3 / 4),
                                itemCount:
                                    // value.subCategorySearch != null
                                    // ?
                                    // subCategoriesSearchprovider
                                    //     .subCategorySearch
                                    //     .data
                                    //     .subcategories
                                    //     .length,
                                    // :
                                    value.subCategories.subcategories.length,
                                itemBuilder: (context, index) {
                                  final subcategory =
                                      // value.subCategorySearch != null
                                      // ?
                                      // subCategoriesSearchprovider
                                      //     .subCategorySearch
                                      //     .data
                                      //     .subcategories[index]
                                      //     .id;
                                      // :
                                      value.subCategories.subcategories[index]
                                          .id;
                                  return InkWell(
                                    onTap: () {
                                      catId = subcategory.toString();
                                      // productindex = index;
                                      print(catId);

                                      Get.to(
                                          () => ProductsCategories(
                                                catId: catId,
                                              ),
                                          transition: Transition.fade);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 200,
                                            height: 120,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                      "https://img.freepik.com/free-photo/tasty-top-view-sliced-pizza-italian-traditional-round-pizza_90220-1357.jpg?t=st=1690788800~exp=1690792400~hmac=ca1e6020cafddfb2ab16d45c198bc80dee2414a1a2a9d2bc6ceb963fbb610838&w=740",
                                                    ),
                                                    fit: BoxFit.cover),
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                          ),
                                          Container(
                                            width: 100,
                                            height: 30,
                                            color: Colors.transparent,
                                            child: Center(
                                                child: Text(
                                                    // value.subCategorySearch !=
                                                    //         null
                                                    //     ? value
                                                    //         .subCategorySearch
                                                    //         .data
                                                    //         .subcategories[
                                                    //             index]
                                                    //         .name
                                                    //     :
                                                    value
                                                        .subCategories
                                                        .subcategories[index]
                                                        .name)),
                                            // subCategoriesSearchprovider
                                            //     .subCategorySearch
                                            //     .data
                                            //     .subcategories[
                                            //         index]
                                            //     .name))
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width - 30,
                                color: Colors.transparent,
                                height:
                                    MediaQuery.of(context).size.height / 1.48,
                                child: ListView.builder(
                                  itemCount:
                                      value.ProductsSearch.products.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Barcode = value.ProductsSearch
                                            .products[index].barcode
                                            .toString();
                                        UnitID = value.ProductsSearch
                                            .products[index].unitId;

                                        SalesPrice = value.ProductsSearch
                                            .products[index].rate;

                                        Name = value.ProductsSearch
                                            .products[index].name;

                                        productsId = value
                                            .ProductsSearch.products[index].id;

                                        print(Barcode);
                                        print(UnitID);
                                        print(SalesPrice);
                                        showBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return YourBottomSheet();
                                          },
                                        );
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        width: 200,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 42, 44, 56),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Row(
                                          children: [
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              width: 120,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                  image: const DecorationImage(
                                                      image: NetworkImage(
                                                          "https://img.freepik.com/free-photo/tasty-top-view-sliced-pizza-italian-traditional-round-pizza_90220-1357.jpg?t=st=1690788800~exp=1690792400~hmac=ca1e6020cafddfb2ab16d45c198bc80dee2414a1a2a9d2bc6ceb963fbb610838&w=740"),
                                                      fit: BoxFit.fill),
                                                  color: Colors.amber,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Container(
                                              width: 170,
                                              height: 90,
                                              color: Colors.transparent,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    value.ProductsSearch
                                                        .products[index].name
                                                        .toString(),
                                                    // "",
                                                    style: const TextStyle(
                                                        fontSize: 15,
                                                        color: wcolor),
                                                  ),
                                                  Text(
                                                    "${value.ProductsSearch.products[index].time.toString()} mins",
                                                    // "",
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        color: wcolor),
                                                  ),
                                                  Text(
                                                    "Price: ${value.ProductsSearch.products[index].rate.toString()}",
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        color: wcolor),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  color: Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: wcolor)),
                                              child: const Center(
                                                  child: Text(
                                                "+",
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 20),
                                              )),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            );
                            // return Container(
                            //   color: Colors.transparent,
                            //   child: GridView.builder(
                            //     gridDelegate:
                            //         SliverGridDelegateWithFixedCrossAxisCount(
                            //             crossAxisCount: 3,
                            //             crossAxisSpacing: 10,
                            //             mainAxisSpacing: 20,
                            //             childAspectRatio: 3 / 4),
                            //     itemCount:
                            //         // value.subCategorySearch != null
                            //         // ?
                            //         // subCategoriesSearchprovider
                            //         //     .subCategorySearch
                            //         //     .data
                            //         //     .subcategories
                            //         //     .length,
                            //         // :
                            //         value.ProductsSearch.products.length,
                            //     itemBuilder: (context, index) {
                            //       // final subcategory =
                            //       // value.subCategorySearch != null
                            //       // ?
                            //       // subCategoriesSearchprovider
                            //       //     .subCategorySearch
                            //       //     .data
                            //       //     .subcategories[index]
                            //       //     .id;
                            //       // :
                            //       // value.subCategories.subcategories[index]
                            //       //     .id;
                            //       return InkWell(
                            //         onTap: () {
                            //           Barcode = value.ProductsSearch
                            //               .products[index].barcode
                            //               .toString();
                            //           UnitID = value.ProductsSearch
                            //               .products[index].unitId;

                            //           SalesPrice = value
                            //               .ProductsSearch.products[index].rate;

                            //           Name = value
                            //               .ProductsSearch.products[index].name;

                            //           print(Barcode);
                            //           print(UnitID);
                            //           print(SalesPrice);
                            //           ShowBottomSheet(context, index);
                            //         },
                            //         child: Container(
                            //           decoration: BoxDecoration(
                            //               color: Colors.transparent,
                            //               borderRadius:
                            //                   BorderRadius.circular(12)),
                            //           child: Column(
                            //             children: [
                            //               Container(
                            //                 width: 200,
                            //                 height: 120,
                            //                 decoration: BoxDecoration(
                            //                     image: DecorationImage(
                            //                         image: NetworkImage(
                            //                           "https://img.freepik.com/free-photo/tasty-top-view-sliced-pizza-italian-traditional-round-pizza_90220-1357.jpg?t=st=1690788800~exp=1690792400~hmac=ca1e6020cafddfb2ab16d45c198bc80dee2414a1a2a9d2bc6ceb963fbb610838&w=740",
                            //                         ),
                            //                         fit: BoxFit.cover),
                            //                     color: Colors.transparent,
                            //                     borderRadius:
                            //                         BorderRadius.circular(12)),
                            //               ),
                            //               Container(
                            //                 alignment: Alignment.topCenter,
                            //                 width: 100,
                            //                 height: 30,
                            //                 color: Colors.transparent,
                            //                 child: Text(
                            //                   // value.subCategorySearch !=
                            //                   //         null
                            //                   //     ? value
                            //                   //         .subCategorySearch
                            //                   //         .data
                            //                   //         .subcategories[
                            //                   //             index]
                            //                   //         .name
                            //                   //     :
                            //                   value.ProductsSearch
                            //                       .products[index].name,
                            //                   style: TextStyle(fontSize: 12),
                            //                 ),
                            //                 // subCategoriesSearchprovider
                            //                 //     .subCategorySearch
                            //                 //     .data
                            //                 //     .subcategories[
                            //                 //         index]
                            //                 //     .name))
                            //               )
                            //             ],
                            //           ),
                            //         ),
                            //       );
                            //     },
                            //   ),
                            // );
                          }
                        }),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width - 50,
                            child: (() {
                              if (selectedProducts.isNotEmpty) {
                                return ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        backgroundColor: maincolor),
                                    onPressed: () {
                                      Get.to(() => OrdersPage(),
                                          transition: Transition.fade);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${Provider.of<Stateprovider>(context).grandTotal}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          "View Orders",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                      ],
                                    ));
                              } else {
                                return null;
                              }
                            })()),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void dialogBoxOrderCancel(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            decoration: BoxDecoration(
              color: wcolor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Are you sure..?",
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 130,
                      height: 45,
                      child: ElevatedButton(
                        onPressed: () {
                          deliveryTtype = "";
                          tableId = 0;
                          selectedProducts = [];
                          searchController.clear();
                          Get.to(() => homepage(), transition: Transition.fade);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade600,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Cancel Order",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    if (invoice_type != "SO")
                      SizedBox(
                        width: 130,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () async {
                            try {
                              Provider.of<DataProvider>(context, listen: false)
                                  .GetCartOrders(context);
                              selectedProducts.clear();
                              cart_masterId = 0;
                              order_idd = 0;
                              invoicenumber = 0;
                              deliveryTtype = "";
                              tableId = 0;
                              tableindex = 0;

                              print("cart created");
                            } catch (e) {
                              print("Error confirming order: $e");
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: maincolor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            "Hold Order",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width - 100,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: maincolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Continue",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> _onWillPop() async {
    // Reset productQuantity and return true
    setState(() {
      productQuantity = 1;
    });
    return true;
  }
}
