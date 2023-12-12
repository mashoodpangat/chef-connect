import 'dart:async';

import 'package:chef_connect_project/API/ApiProvider.dart';
import 'package:chef_connect_project/API/Stateprovider.dart';
import 'package:chef_connect_project/FoodItemCategories/ProductCategories.dart';
import 'package:chef_connect_project/FoodItemCategories/SubCategories.dart';
import 'package:chef_connect_project/itemOrder/orders.dart';
import 'package:chef_connect_project/styleUtils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class YourBottomSheet extends StatefulWidget {
  @override
  _YourBottomSheetState createState() => _YourBottomSheetState();
}

class _YourBottomSheetState extends State<YourBottomSheet> {
  int selectedContainerIndex = -1;

  void reloadBottomSheetContent() {
    setState(() {});
  }

  Future<bool> _onWillPop() async {
    // Reset productQuantity and return true
    setState(() {
      productQuantity = 1;
    });
    return true;
  }

  late DataProvider specificationprovider;

  int selectedContainerIndexs = -1;
  String Modifier = "";

  StreamController<int> _quantityController = StreamController<int>.broadcast();
  final TextEditingController _textEditingController = TextEditingController();
  final TextEditingController _OrgquantityController = TextEditingController();
  @override
  void initState() {
    super.initState();
    specificationprovider = Provider.of<DataProvider>(context, listen: false);
    specificationprovider.GetSpecification();
    _OrgquantityController.text = productQuantity.toString();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.pop(context); // Close the bottom sheet
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Container(
                      width: 120,
                      height: 80,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              image: NetworkImage(
                                  "https://img.freepik.com/free-photo/tasty-top-view-sliced-pizza-italian-traditional-round-pizza_90220-1357.jpg?t=st=1690788800~exp=1690792400~hmac=ca1e6020cafddfb2ab16d45c198bc80dee2414a1a2a9d2bc6ceb963fbb610838&w=740"),
                              fit: BoxFit.fill),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.6,
                    height: 100,
                    color: Colors.transparent,
                    child: ListTile(
                      title: Text(
                        // value.productCategory.data.products[index].name,
                        Name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        "Price: " +
                            // value
                            //     .productCategory.data.products[index].rate
                            //     .toString(),
                            SalesPrice.toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
              Consumer<DataProvider>(
                builder: (context, value, child) => Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: (() {
                      if (value.isLoading) {
                        return Center(
                          child: Container(
                            height: 80,
                            width: 80,
                            child: Lottie.asset(
                              "assetslottie/Animation - 1697009692722.json",
                            ),
                          ),
                        );
                      } else if (value
                          .productSpecification.data.products.isNotEmpty) {
                        return Center(
                          child: Consumer<DataProvider>(
                            builder: (context, value, child) => Container(
                                width: MediaQuery.of(context).size.width - 50,
                                height: MediaQuery.of(context).size.height / 5,
                                child: // Inside your GridView.builder
                                    // Inside your GridView.builder
                                    GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                  ),
                                  itemCount:
                                      // value
                                      //     .productSpecification.data.products.length,
                                      2,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: 140,
                                      height: 140,
                                      color: Colors.transparent,
                                      child: Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedContainerIndexs = index;
                                                print(index);
                                                reloadBottomSheetContent();
                                              });
                                              Barcode = value
                                                  .productSpecification
                                                  .data
                                                  .products[index]
                                                  .barcode
                                                  .toString();
                                              UnitID = value
                                                  .productSpecification
                                                  .data
                                                  .products[index]
                                                  .unitId;
                                              SalesPrice = value
                                                  .productSpecification
                                                  .data
                                                  .products[index]
                                                  .rate;

                                              Name = value.productSpecification
                                                  .data.products[index].name;
                                              print(Barcode);
                                              print(UnitID);
                                              print(SalesPrice);
                                              print(Name);
                                              print(selectedProducts);
                                            },
                                            child: Container(
                                              width: 140,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Colors.grey[400],
                                                border: Border.all(
                                                  color: selectedContainerIndexs ==
                                                          index
                                                      ? Colors.green
                                                          .shade700 // Change the border color here
                                                      : Colors.grey.shade400,
                                                  width:
                                                      selectedContainerIndexs ==
                                                              index
                                                          ? 3.5
                                                          : 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                width: 140,
                                                height: 100,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    child: Image.asset(
                                                      "assets/food.png",
                                                      fit: BoxFit.fill,
                                                    )),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 140,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                            ),
                                            child: Center(
                                              child: Text(
                                                "${value.productSpecification.data.products[index].specification} RATE:${value.productSpecification.data.products[index].rate}",
                                                // "",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                )),
                          ),
                        );
                      } else {
                        return null;
                      }
                    })()),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                color: const Color.fromARGB(255, 230, 225, 227),
                child: const Center(
                    child: Text(
                  "Qty",
                  style: TextStyle(fontSize: 18),
                )),
              ),
              SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: maingreycolor,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            productQuantity =
                                productQuantity > 1 ? productQuantity - 1 : 1;
                            _quantityController.add(productQuantity.toInt());
                            _OrgquantityController.text =
                                productQuantity.toString();
                          });
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    StreamBuilder<int>(
                        stream: _quantityController.stream,
                        initialData: productQuantity.toInt(),
                        builder: (context, snapshot) {
                          return Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: maingreycolor,
                                borderRadius: BorderRadius.circular(12)),
                            alignment: Alignment.center,
                            child: Center(
                                child: TextField(
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                productQuantity =
                                    int.tryParse(value) ?? productQuantity;
                              },
                              controller: _OrgquantityController,
                              style: const TextStyle(
                                color: wcolor,
                              ),
                            )),
                          );
                        }),
                    const SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundColor: maingreycolor,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            productQuantity++;
                            _quantityController.add(productQuantity.toInt());
                            print(productQuantity);
                            _OrgquantityController.text =
                                productQuantity.toString();
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                color: const Color.fromARGB(255, 230, 225, 227),
                child: const Center(
                    child: Text(
                  "Additional Info",
                  style: TextStyle(fontSize: 18),
                )),
              ),
              const SizedBox(
                height: 30,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Info",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                          hintText: "Enter additional info",
                          hintStyle: const TextStyle(fontSize: 17),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)))),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(
                      height:
                          MediaQuery.of(context).size.width < 600 ? 6.h : 7.h,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            Modifier = _textEditingController.text.trim();
                            _textEditingController.clear();
                          });
                          print(_textEditingController);

                          // Product _selectedProduct = value
                          //     .productCategory.data.products[index];
                          // selectedProducts.add(_selectedProduct);
                          // print(selectedProducts);

                          selectedProducts.add({
                            "Barcode": Barcode,
                            "Qty": productQuantity,
                            "UnitID": UnitID,
                            "SalesPrice": SalesPrice,
                            "Modifier": Modifier,
                            "name": Name,
                            "time": time
                          });
                          print(selectedProducts);

                          // DataProvider().GetItemsOrders();
                          // Provider.of<DataProvider>(context,
                          //         listen: false)
                          //     .GetItemsOrders();

                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) {
                          //     return SubCategoriesPage();
                          //   },
                          // ));

                          // Get.to(() => SubCategoriesPage(),
                          //     transition: Transition.fade);
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SubCategoriesPage(),
                          ));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: maincolor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        child: const Text(
                          "ADD",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  )),
                  SizedBox(
                    width: 2.w,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: SizedBox(
                        height:
                            MediaQuery.of(context).size.width < 600 ? 6.h : 7.h,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              Modifier = _textEditingController.text.trim();
                              _textEditingController.clear();
                            });

                            selectedProducts.add({
                              "Barcode": Barcode,
                              "Qty": productQuantity,
                              "UnitID": UnitID,
                              "SalesPrice": SalesPrice,
                              "Modifier": Modifier,
                              "name": Name,
                              "time": time
                            });

                            Provider.of<Stateprovider>(context, listen: false)
                                .calculateGrandTotal(selectedProducts);

                            Get.to(() => OrdersPage(),
                                transition: Transition.fade);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          child: const Text(
                            "Finish",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
