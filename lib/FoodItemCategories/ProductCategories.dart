import 'dart:math';

import 'package:chef_connect_project/API/ApiProvider.dart';
import 'package:chef_connect_project/API/Stateprovider.dart';

import 'package:chef_connect_project/FoodItemCategories/bottomSheet.dart';
import 'package:chef_connect_project/SelectTables.dart/selectTables.dart';
import 'package:chef_connect_project/ToggleSwitch.dart';
import 'package:chef_connect_project/itemOrder/orders.dart';

import 'package:chef_connect_project/styleUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

List<Map<String, dynamic>> selectedProducts = [];

int findGreatestTime(List<Map<String, dynamic>> selectedProducts) {
  // Initialize mytime to a default value
  int mytime = 0;
  for (Map<String, dynamic> product in selectedProducts) {
    if (product.containsKey("time") && product["time"] is int) {
      int productTime = product["time"];
      if (productTime > mytime) {
        mytime = productTime; // Update mytime with the new maximum value
      }
    }
  }
  return mytime;
}

class ProductsCategories extends StatefulWidget {
  final String catId;
  ProductsCategories({super.key, required this.catId});
//required this.index
  // final int index;

  @override
  State<ProductsCategories> createState() => _ProductsCategoriesState();
}

int productQuantity = 1;
String Barcode = "";
int UnitID = 0;
double SalesPrice = 0;
int time = 0;

String Name = "";
int productsId = 0;

late DataProvider productCategoryprovider;

FocusNode _textFormFieldFocus = FocusNode();

class _ProductsCategoriesState extends State<ProductsCategories> {
  @override
  void initState() {
    super.initState();
    productQuantity = 1;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    productCategoryprovider = Provider.of<DataProvider>(context, listen: false);
    productCategoryprovider.getproductCategory();
  }

  TextEditingController productSearchcontroller = TextEditingController();

  @override
  void dispose() {
    productSearchcontroller.dispose();

    super.dispose();
  }

  // final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // cartItemOrderprovider = Provider.of<DataProvider>(context, listen: false);
    // cartItemOrderprovider.GetItemsOrders();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        leading: IconButton(
            onPressed: () {
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
                // DataProvider().getTablesLocationApi();
                // DataProvider().getproductCategory();
                print("adsf");
                // DataProvider().GetItemsOrders();
                log(tableId);
                print(DataProvider().GetSpecification());
              },
              icon: const Icon(
                Icons.more_vert,
                size: 25,
                color: Colors.white,
              ))
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      const Text(
                        "Back to ",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        width: 120,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Sub Category',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                              shadowColor: Colors.black,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Colors.green))
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 9,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: SizedBox(
                            height: 55,
                            child: Form(
                              child: TextFormField(
                                // focusNode: _textFormFieldFocus,
                                onTap: () {
                                  // _textFormFieldFocus.requestFocus();
                                },
                                onChanged: (values) {
                                  Provider.of<DataProvider>(context,
                                          listen: false)
                                      .GetProductsSearch(values);
                                },
                                controller: productSearchcontroller,
                                cursorColor: Colors.white,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide(
                                          color: Colors.black)),
                                  filled: true,
                                  hintStyle: const TextStyle(
                                      color:
                                          Color.fromARGB(255, 172, 171, 171)),
                                  hintText: "Search for",
                                  fillColor:
                                      const Color.fromARGB(255, 42, 44, 56),
                                  suffixIcon: const Icon(
                                    Icons.search_sharp,
                                    color: Colors.white,
                                  ),
                                ),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )),
                      const SizedBox(
                        height: 15,
                      ),
                      Consumer<DataProvider>(
                        builder: (context, value, child) {
                          if (value.isLoading) {
                            return shimmercontainer(context);
                          } else if (productSearchcontroller.text.isEmpty) {
                            return Container(
                              width: MediaQuery.of(context).size.width - 40,
                              color: Colors.transparent,
                              height: MediaQuery.of(context).size.height / 1.45,
                              child: ListView.builder(
                                itemCount:
                                    value.productCategory.data.products.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Barcode = value.productCategory.data
                                          .products[index].barcode
                                          .toString();
                                      UnitID = value.productCategory.data
                                          .products[index].unitId;

                                      SalesPrice = value.productCategory.data
                                          .products[index].rate;

                                      Name = value.productCategory.data
                                          .products[index].name;
                                      productsId = value.productCategory.data
                                          .products[index].id;

                                      time = value.productCategory.data
                                          .products[index].time;

                                      print(Barcode);
                                      print(UnitID);
                                      print(SalesPrice);
                                      print(productsId);

                                      showBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return YourBottomSheet();
                                        },
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(bottom: 10),
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
                                                    BorderRadius.circular(12)),
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
                                                  value.productCategory.data
                                                      .products[index].name
                                                      .toString(),
                                                  // "",
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      color: wcolor),
                                                ),
                                                Text(
                                                  "${value.productCategory.data.products[index].time.toString()} mins",
                                                  // "",
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      color: wcolor),
                                                ),
                                                Text(
                                                  "Price: ${value.productCategory.data.products[index].rate.toString()}",
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
                                                border:
                                                    Border.all(color: wcolor)),
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
                            );
                          } else {
                            return Container(
                              width: MediaQuery.of(context).size.width - 40,
                              color: Colors.transparent,
                              height: MediaQuery.of(context).size.height / 1.48,
                              child: ListView.builder(
                                itemCount: value.ProductsSearch.products.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Barcode = value.ProductsSearch
                                          .products[index].barcode
                                          .toString();
                                      UnitID = value.ProductsSearch
                                          .products[index].unitId;

                                      SalesPrice = value
                                          .ProductsSearch.products[index].rate;

                                      Name = value
                                          .ProductsSearch.products[index].name;

                                      productsId = value
                                          .ProductsSearch.products[index].id;
                                      time = value.productCategory.data
                                          .products[index].time;

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
                                      margin: const EdgeInsets.only(bottom: 10),
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
                                                    BorderRadius.circular(12)),
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
                                                border:
                                                    Border.all(color: wcolor)),
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
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Visibility(
                visible: selectedProducts.isNotEmpty,
                child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: maincolor,
                    ),
                    onPressed: () {
                      Get.to(() => OrdersPage(), transition: Transition.fade);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${Provider.of<Stateprovider>(context).grandTotal}",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Text(
                          "View Orders",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void reloadBottomSheetContent() {
    setState(() {});
  }
}
