import 'dart:async';

import 'package:chef_connect_project/API/ApiProvider.dart';

import 'package:chef_connect_project/FoodItemCategories/SubCategories.dart';
import 'package:chef_connect_project/SelectTables.dart/tablegridview.dart';
import 'package:chef_connect_project/itemOrder/orders.dart';

import 'package:chef_connect_project/styleUtils.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:auto_scroll/auto_scroll.dart';

class SelectTables extends StatefulWidget {
  const SelectTables({
    super.key,
  });

  @override
  State<SelectTables> createState() => _SelectTablesState();
}

late DataProvider locationprovider;
late DataProvider balconyprovider;
int selectedIndex = 0;

String myLocation = "";
int selectedSeatIndex = -1;
String TableName = '';
int tableId = 0;

int personNumber = 1;
ValueNotifier<int> selectedIndexNotifier = ValueNotifier<int>(0);

bool isvisible = true;
late PageController _pageController;
ScrollController _scrollController = ScrollController();

ScrollController _gridViewController = ScrollController();

class _SelectTablesState extends State<SelectTables>
    with TickerProviderStateMixin {
  TextEditingController seatController = TextEditingController();
  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: selectedIndex);

    Timer(Duration(milliseconds: 500), () {
      _scrollController.jumpTo(selectedIndex *
          1); // Replace YOUR_ITEM_WIDTH with the actual width of each item
    });

    // final locationprovider = Provider.of<DataProvider>(context, listen: false);
    // locationprovider.getTablesLocationApi(selectedIndex);

    // final balconyprovider = Provider.of<DataProvider>(context, listen: false);
    // balconyprovider.getTableSeatApi();
    _resetSelectedIndex();
    _fetchTablesLocationData();
    seatController.text = personNumber.toString();

    // Provider.of<DataProvider>(context, listen: false).getTablesLocationApi();
  }

  Future<void> _fetchTablesLocationData() async {
    final locationprovider = Provider.of<DataProvider>(context, listen: false);
    await locationprovider.getTablesLocationApi(selectedIndex);

    final balconyprovider = Provider.of<DataProvider>(context, listen: false);
    balconyprovider.getTableSeatApi();
  }

  @override
  void dispose() {
    _pageController.dispose();
    // seatController.dispose();
    super.dispose();
  }

  void _resetSelectedIndex() {
    setState(() {
      selectedIndex = 0;
      selectedSeatIndex = -1;
      tableId = 0;
      TableName = "";
      personNumber = 1;
    });
  }

  _scrollToBottom() {
    setState(() {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    // Provider.of<DataProvider>(context, listen: false)
    //     .getTablesLocationApi(selectedIndex);
    // Provider.of<DataProvider>(context, listen: false).getTableSeatApi();
    // TabController _tabController = TabController(length: 4, vsync: this);
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: maincolor,
        appBar: AppBar(
          backgroundColor: maincolor,
          leading: IconButton(
              onPressed: () {
                // myLocation = "";

                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                size: 25,
                color: Colors.white,
              )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: SizedBox(
                width: 85,
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => SubCategoriesPage(),

                    // ));

                    Get.to(() => SubCategoriesPage(),
                        transition: Transition.fade);
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(color: Colors.red[900]),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: ContinuousRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ),
            ),
            // IconButton(
            //     onPressed: () {
            //       // DataProvider().getTableSeatApi();
            //       // DataProvider().getpartyHallApi();
            //       print("adsf");
            //       print("location " + myLocation);
            //       print(selectedIndex);
            //       print("table name " + TableName);
            //       print("table id ${tableId}");
            //       print("personNumber ${personNumber}");

            //       print(selectedSeatIndex);
            //     },
            //     icon: Icon(
            //       Icons.more_vert,
            //       size: 25,
            //       color: Colors.white,
            //     ))
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              // TextButton(
              //   onPressed: () {},
              //   child: Text(
              //     "Skip",
              //     style: TextStyle(
              //         color: Colors.red,
              //         fontSize: 17,
              //         fontWeight: FontWeight.bold),
              //   ),
              // ),
              Consumer<DataProvider>(
                builder: (context, getdata, child) {
                  if (getdata.isLoading) {
                    return Container(
                      width: double.infinity,
                      height: 40,
                      color: Colors.white,
                    );
                  } else {
                    return DefaultTabController(
                      length: getdata.locationdata.data.locations.length,
                      child: SizedBox(
                        height: 45,
                        width: double.infinity,
                        child: ListView.builder(
                          controller: _scrollController,
                          physics: BouncingScrollPhysics(),
                          itemCount: getdata.locationdata.data.locations.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;

                                    selectedSeatIndex = -1;

                                    myLocation = getdata.locationdata.data
                                        .locations[index].location;
                                    Provider.of<DataProvider>(context,
                                            listen: false)
                                        .getTableSeatApi();

                                    print(selectedIndex);
                                    print(myLocation);

                                    _pageController.animateToPage(
                                      index,
                                      duration: Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 1),
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: selectedIndex == index
                                        ? maincolor
                                        : maingreycolor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      getdata.locationdata.data.locations[index]
                                          .location,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: selectedIndex == index
                                            ? Colors.white
                                            : Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 20),
              Consumer<DataProvider>(
                builder: (context, value, child) {
                  return Expanded(
                    flex: 3,
                    child: PageView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          if (value.isLoading) {
                            return Center(
                              child: Lottie.asset(
                                frameRate: FrameRate(60),
                                height: 100,
                                "assetslottie/Animation - 1697009692722.json",
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                width: double.infinity,
                                height:
                                    // value.tableSeatdata.data.tables
                                    //             .length >
                                    //         6
                                    //     ? 100
                                    //     :
                                    MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                    color: maingreycolor,
                                    borderRadius: BorderRadius.circular(12)),
                                child: GridView.builder(
                                    // controller: _gridViewController,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 20,
                                    ),
                                    itemCount:
                                        value.tableSeatdata.data.tables.length,
                                    itemBuilder: (BuildContext ctx, index) {
                                      final seatName = value.tableSeatdata.data
                                          .tables[index].name;
                                      final tableIdD = value
                                          .tableSeatdata.data.tables[index].id;
                                      if (value.tableSeatdata.data.tables[index]
                                              .noOfSeats ==
                                          4) {
                                        return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedSeatIndex = index;
                                                if (selectedSeatIndex == -1) {
                                                  TableName = '';
                                                  tableId = tableIdD;
                                                } else {
                                                  TableName = seatName;
                                                  tableId = tableIdD;
                                                }
                                              });
                                            },
                                            child: fourseat(
                                              value.tableSeatdata.data
                                                  .tables[index].name,
                                              isSelected:
                                                  selectedSeatIndex == index,
                                            ));
                                      } else if (value.tableSeatdata.data
                                              .tables[index].noOfSeats ==
                                          6) {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedSeatIndex = index;
                                              if (selectedSeatIndex == -1) {
                                                TableName = '';
                                                tableId = tableIdD;
                                              } else {
                                                TableName = seatName;
                                                tableId = tableIdD;
                                              }
                                            });
                                          },
                                          child: sixseat(
                                            value.tableSeatdata.data
                                                .tables[index].name,
                                            isSelected:
                                                selectedSeatIndex == index,
                                          ),
                                        );
                                      } else {
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedSeatIndex = index;
                                              if (selectedSeatIndex == -1) {
                                                TableName = '';
                                                tableId = tableIdD;
                                              } else {
                                                TableName = seatName;
                                                tableId = tableIdD;
                                              }
                                            });
                                          },
                                          child: TwoSeat(
                                            value.tableSeatdata.data
                                                .tables[index].name,
                                            isSelected:
                                                selectedSeatIndex == index,
                                          ),
                                        );
                                      }
                                    }),
                              ),
                            );
                          }

                          // }
                          // },
                          // );
                        }),
                  );
                },
              ),
              // SizedBox(
              //   height: 60,
              // ),
              Expanded(
                flex: 2,
                child: Visibility(
                  maintainAnimation: true,
                  maintainSize: true,
                  maintainState: true,
                  visible: isvisible,
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                          color: maincolor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Select Seat",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     if (getdata.tableSeatdata.data.tables[index]
                          //             .noOfSeats ==
                          //         6) ...[
                          //       Container(
                          //         width: 40,
                          //         height: 40,
                          //         decoration: BoxDecoration(
                          //             color: Colors.green,
                          //             borderRadius:
                          //                 BorderRadius.circular(20)),
                          //       ),
                          //       SizedBox(
                          //         width: 5,
                          //       ),
                          //       Container(
                          //         width: 40,
                          //         height: 40,
                          //         decoration: BoxDecoration(
                          //             color: Colors.green,
                          //             borderRadius:
                          //                 BorderRadius.circular(20)),
                          //       ),
                          //       SizedBox(
                          //         width: 5,
                          //       ),
                          //       Container(
                          //         width: 40,
                          //         height: 40,
                          //         decoration: BoxDecoration(
                          //             color: Colors.green,
                          //             borderRadius:
                          //                 BorderRadius.circular(20)),
                          //       ),
                          //       SizedBox(
                          //         width: 5,
                          //       ),
                          //       Container(
                          //         width: 40,
                          //         height: 40,
                          //         decoration: BoxDecoration(
                          //             color: Colors.green,
                          //             borderRadius:
                          //                 BorderRadius.circular(20)),
                          //       ),
                          //     ]
                          //   ],
                          // ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "How many Guests?",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      personNumber = personNumber > 1
                                          ? personNumber - 1
                                          : 1;
                                      seatController.text =
                                          personNumber.toString();
                                    });
                                  },
                                  icon: Icon(Icons.remove),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Flexible(
                                child: SizedBox(
                                  width: 30,
                                  child: TextField(
                                    controller: seatController,
                                    onChanged: (value) {
                                      personNumber =
                                          int.tryParse(value) ?? personNumber;
                                    },
                                    style: TextStyle(color: Colors.white),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      // hintText: personNumber.toString()
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              CircleAvatar(
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      personNumber++;
                                      seatController.text =
                                          personNumber.toString();
                                    });
                                    print(personNumber);
                                  },
                                  icon: Icon(Icons.add),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                              width: MediaQuery.of(context).size.width - 30,
                              height: 55,
                              child: (() {
                                if (tableindex == 0) {
                                  return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          backgroundColor: Colors.white),
                                      onPressed: () {
                                        if (selectedSeatIndex == -1) {
                                          TableName = '';
                                          tableId = 0;
                                        }
                                        // sam.add(getdata.FirstFloor.data
                                        //     .tables[buttonindex].name);
                                        Get.to(() => SubCategoriesPage(),
                                            transition: Transition.fade);
                                        // print(sam);
                                      },
                                      child: Text(
                                        "Take Order",
                                        style: TextStyle(
                                            color: maincolor, fontSize: 16),
                                      ));
                                } else {
                                  return ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          backgroundColor: Colors.white),
                                      onPressed: () {
                                        if (selectedSeatIndex == -1) {
                                          TableName = '';
                                          tableId = 0;
                                        }

                                        Get.to(() => OrdersPage(),
                                            transition: Transition.fade);
                                      },
                                      child: Text(
                                        "Continue",
                                        style: TextStyle(
                                            color: maincolor, fontSize: 16),
                                      ));
                                }
                              })()),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
