import 'dart:convert';

import 'dart:math';
import 'package:chef_connect_project/API/cartOrderModel.dart';
import 'package:chef_connect_project/API/mclassproduct.dart';
import 'package:chef_connect_project/API/modelclassAPI.dart';
import 'package:chef_connect_project/FoodItemCategories/ProductCategories.dart';
import 'package:chef_connect_project/FoodItemCategories/SubCategories.dart';
import 'package:chef_connect_project/SelectTables.dart/selectTables.dart';
import 'package:chef_connect_project/createOrder.dart/SelectServerType.dart';
import 'package:chef_connect_project/homepage/homepage.dart';

import 'package:chef_connect_project/itemOrder/Ordermanagement.dart';
import 'package:chef_connect_project/itemOrder/orders.dart';
import 'package:chef_connect_project/kitchenOrderlogin.dart';
import 'package:chef_connect_project/splashscreen.dart';
import 'package:chef_connect_project/styleUtils.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';

enum providerstatus { LOADING, COMPLETED }

class DataProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  late HomeDataResponse data2;

  Future<void> getHomeApi() async {
    _isLoading = true;

    final response = await http.post(Uri.parse(apidomine + "order_home"),
        body: ({'apikey': apikey}));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);

      HomeDataResponse homeData = HomeDataResponse.fromJson(jsonResponse);

      data2 = homeData;

      // print(data1.userDetails.storeName);

      // final homeData = HomeData.fromJson(jsonResponse['data']);
      // print(homeData);
    } else {
      throw Exception(e);
    }
    _isLoading = false;
    notifyListeners();
  }

  late ServeTypeResponse serverdata;

  Future<void> getserverApi() async {
    _isLoading = true;

    final response = await http.post(Uri.parse(apidomine + 'serve_type'),
        body: ({'apikey': apikey}));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);

      ServeTypeResponse serveTypeResponse =
          ServeTypeResponse.fromJson(jsonBody);

      serverdata = serveTypeResponse;

      // return jsonBody;
    } else {
      throw Exception('Failed to fetch serve types');
    }

    _isLoading = false;
    notifyListeners();
  }

  // String mLocation = "";
  late TablesLocation locationdata;

  Future<void> getTablesLocationApi(int selectedIndex) async {
    _isLoading = true;
    try {
      final RResponse = await http.post(Uri.parse(apidomine + 'get_locations'),
          body: ({'apikey': apikey}));

      if (RResponse.statusCode == 200) {
        final jsonBody = jsonDecode(RResponse.body);

        TablesLocation locationResponse = TablesLocation.fromJson(jsonBody);

        locationdata = locationResponse;

        myLocation = locationdata.data.locations[selectedIndex].location;
        notifyListeners();

        // return jsonBody;
      } else {
        throw Exception(e);
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
      // return null;
    }
  }

  late TableResponse tableSeatdata;

  Future<void> getTableSeatApi() async {
    _isLoading = true;
    final response = await http.post(Uri.parse(apidomine + 'get_tables'),
        body: ({'location': myLocation.toString()}));

    if (response.statusCode == 200) {
      // print(myLocation);
      // print(response.body);
      // print(response.statusCode);
      final jsonBody = jsonDecode(response.body);

      TableResponse tableSeatResponse = TableResponse.fromJson(jsonBody);

      tableSeatdata = tableSeatResponse;

      // return jsonBody;
    } else {
      throw Exception(e);
      // print("failed");
    }
    _isLoading = false;
    notifyListeners();
    return null;
  }

  // late TableResponse FirstFloor;

  // Future<void> getFirstFloorApi() async {
  //   _isLoading = true;
  //   final response = await http.post(Uri.parse(apidomine + 'get_tables'),
  //       body: ({'location': 'First Floor'}));

  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     print(response.statusCode);
  //     final jsonBody = jsonDecode(response.body);

  //     TableResponse FirstFloorResponse = TableResponse.fromJson(jsonBody);

  //     FirstFloor = FirstFloorResponse;
  //     status = providerstatus.COMPLETED;

  //     // return jsonBody;
  //   } else {
  //     // throw Exception('Failed to fetch serve types');
  //     print("failed");
  //   }
  //   _isLoading = false;
  //   notifyListeners();
  // }

  // late TableResponse groundFloor;

  // Future<void> getGroundFloorApi() async {
  //   _isLoading = true;
  //   final response = await http.post(Uri.parse(apidomine + 'get_tables'),
  //       body: ({'location': 'ground floor'}));

  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     print(response.statusCode);
  //     final jsonBody = jsonDecode(response.body);

  //     TableResponse groundFloorResponse = TableResponse.fromJson(jsonBody);

  //     groundFloor = groundFloorResponse;
  //     status = providerstatus.COMPLETED;

  //     // return jsonBody;
  //   } else {
  //     throw Exception('Failed to fetch serve types');
  //   }
  //   _isLoading = false;
  //   notifyListeners();
  // }

  // late TableResponse partyHall;

  // Future<void> getpartyHallApi() async {
  //   _isLoading = true;
  //   final response = await http.post(Uri.parse(apidomine + 'get_tables'),
  //       body: ({'location': 'party hall'}));

  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     print(response.statusCode);
  //     final jsonBody = jsonDecode(response.body);

  //     TableResponse partyHallResponse = TableResponse.fromJson(jsonBody);

  //     partyHall = partyHallResponse;
  //     status = providerstatus.COMPLETED;

  //     // return jsonBody;
  //   } else {
  //     throw Exception('Failed to fetch serve types');
  //   }
  //   _isLoading = false;
  //   notifyListeners();
  // }

///////////////////////sub categories////////////////////////////

  late mainSubCategories subCategories;

  Future<void> getsubCategories() async {
    _isLoading = true;
    final response = await http.post(
        Uri.parse(apidomine + 'get_sub_categories'),
        body: ({'cat_id': '-1', 'PriceGroupID': '1'}));

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);

      mainSubCategories subCategoriesResponse =
          mainSubCategories.fromJson(jsonBody);

      subCategories = subCategoriesResponse;

      // return jsonBody;
    } else {
      throw Exception(CircularProgressIndicator());
    }
    _isLoading = false;
    notifyListeners();
  }

  late DefaultFood productCategory;

  Future<void> getproductCategory() async {
    _isLoading = true;
    final response = await http.post(
        Uri.parse(apidomine + 'get_products_by_category'),
        body: ({'cat_id': catId}));

    if (response.statusCode == 200) {
      // print(response.body);
      // print(response.statusCode);
      final jsonBody = jsonDecode(response.body);

      DefaultFood productCategoryResponse = DefaultFood.fromJson(jsonBody);

      productCategory = productCategoryResponse;

      // return jsonBody;
    } else {
      throw Exception('Failed to fetch serve types');
    }
    _isLoading = false;
    notifyListeners();
  }

  // int CartMasterIDDD = 0;

  // late CreateCartResponse CartitemsOrders;
  // List<Map<String, dynamic>> detailsList = [];

  // Future<void> GetItemsOrders() async {
  //   _isLoading = true;

  //   // try {
  //   //   if (CartMasterIDDD > 0) {
  //   //     for (var i = 0; i < CartitemsOrders.data.details.length; i++) {
  //   //       detailsList.add({
  //   //         "Barcode": CartitemsOrders.data.details[i].barcode,
  //   //         "Qty": CartitemsOrders.data.details[i].quantity,
  //   //         "UnitID": CartitemsOrders.data.details[i].unitID,
  //   //         "SalesPrice": CartitemsOrders.data.details[i].salesPrice,
  //   //         "Modifier": CartitemsOrders.data.details[i].modifier
  //   //       });
  //   //     }
  //   //     notifyListeners();
  //   //   }
  //   // } catch (e) {
  //   //   throw Exception(e);
  //   // }

  //   // detailsList.add({
  //   //   "Barcode": Barcode,
  //   //   "Qty": productQuantity,
  //   //   "UnitID": UnitID,
  //   //   "SalesPrice": SalesPrice,
  //   //   "Modifier": Modifier,
  //   // });

  //   final Map<String, dynamic> requestData = {
  //     "status": "ok",
  //     "message": "Order details",
  //     "data": [
  //       {
  //         "apikey": apikey,
  //         "TableID": 4,
  //         "SeatNumbers": "A",
  //         "delivery_type": deliveryTtype,
  //         "Mobile": "",
  //         "Name": "",
  //         "Address1": "",
  //         "EmailID": "",
  //         "DOB": "",
  //         "WDATE": "",
  //         "Address2": "",
  //         "PriceGroupID": 1,
  //         "CartMasterID": CartMasterIDDD,
  //         "NonTradeMasterID": 0,
  //         "details": [
  //           {
  //             "Barcode": Barcode,
  //             "Qty": productQuantity,
  //             "UnitID": UnitID,
  //             "SalesPrice": SalesPrice,
  //             "Modifier": Modifier,
  //           },
  //           if (CartMasterIDDD > 0)
  //             for (var i = 0; i < CartitemsOrders.data.details.length; i++)
  //               {
  //                 "Barcode": CartitemsOrders.data.details[i].barcode,
  //                 "Qty": CartitemsOrders.data.details[i].quantity,
  //                 "UnitID": CartitemsOrders.data.details[i].unitID,
  //                 "SalesPrice": CartitemsOrders.data.details[i].salesPrice,
  //                 "Modifier": CartitemsOrders.data.details[i].modifier,
  //               }
  //         ]
  //       }
  //     ]
  //   };

  //   final response1 = await http.post(
  //     Uri.parse(apidomine + 'create_cart'),
  //     headers: {"Content-Type": "application/json"},
  //     body: json.encode(requestData),
  //   );

  //   if (response1.statusCode == 200) {
  //     print(response1.statusCode);
  //     // try {
  //     final jsonBody = jsonDecode(response1.body);

  //     CreateCartResponse itemsOrdersResponse =
  //         CreateCartResponse.fromJson(jsonBody);

  //     CartitemsOrders = itemsOrdersResponse;

  //     CartMasterIDDD = CartitemsOrders.data.cartMasterId;

  //     // print(CartconfirmOrder);

  //     print(CartitemsOrders.data.details);
  //     print(CartitemsOrders);
  //     print(response1.body);
  //     print(detailsList);
  //   } else {
  //     throw Exception(e);
  //   }

  //   _isLoading = false;
  //   notifyListeners();
  // }

  late OrderResponse confirmOrder;

  Future<void> GetCartConfirmOrders(BuildContext context) async {
    _isLoading = true;

    final Map<String, dynamic> requestDataConfirmOrder = {
      "status": "ok",
      "message": "Order details",
      "data": [
        {
          "apikey": apikey,
          "TableID": tableId,
          "SeatNumbers": "A",
          "NoofPersons": personNumber,
          "delivery_type": deliveryTtype,
          "Mobile": "",
          "Name": "",
          "Address1": "",
          "EmailID": "",
          "DOB": "",
          "WDATE": "",
          "Address2": "",
          "PriceGroupID": 1,
          "details": selectedProducts
        }
      ]
    };
    final response = await http.post(
      Uri.parse(apidomine + 'confirm_order'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(requestDataConfirmOrder),
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      OrderResponse CartConfirmOrdersResponse =
          OrderResponse.fromJson(jsonBody);

      confirmOrder = CartConfirmOrdersResponse;

      // InvoiceNumber = CartconfirmOrder.data.invoiceNumber;
      // order_Id = CartconfirmOrder.data.orderId;
      // print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr" + response.body);

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => homepage(),
      ));
    } else {
      throw Exception(e);
    }

    _isLoading = false;
    notifyListeners();
  }

  ////////////////////////////// to the cart///////////////////////////

  late CreateCartResponse creatcartOrder;

  Future<void> GetCartOrders(BuildContext context) async {
    _isLoading = true;

    final Map<String, dynamic> requestDataCartOrder = {
      "status": "ok",
      "message": "Order details",
      "data": [
        {
          "apikey": apikey,
          "TableID": tableId,
          "SeatNumbers": "A",
          "NoofPersons": personNumber,
          "delivery_type": deliveryTtype,
          "Mobile": "",
          "Name": "",
          "Address1": "",
          "EmailID": "",
          "DOB": "",
          "WDATE": "",
          "Address2": "",
          "PriceGroupID": 1,
          "CartMasterID": cart_masterId,
          "NonTradeMasterID": 0,
          "details": selectedProducts
        }
      ]
    };
    final response = await http.post(
      Uri.parse(apidomine + 'create_cart'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(requestDataCartOrder),
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      CreateCartResponse CartOrdersResponse =
          CreateCartResponse.fromJson(jsonBody);

      creatcartOrder = CartOrdersResponse;
      // print(response.body);

      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => homepage(),
      ));

      // InvoiceNumber = CartconfirmOrder.data.invoiceNumber;
      // order_Id = CartconfirmOrder.data.orderId;
    } else {
      throw Exception(e);
    }

    _isLoading = false;
    notifyListeners();
  }

  ////////////////////////////////////active orders///////////////////////////

  late ActiveOrder ActiveOrders;

  Future<void> GetActiveOrders() async {
    _isLoading = true;

    final response = await http.post(Uri.parse(apidomine + 'get_active_order'),
        body: ({'apikey': apikey}));

    if (response.statusCode == 200) {
      // print(response.body);
      // print(response.statusCode);
      final jsonBody = jsonDecode(response.body);

      ActiveOrder ActiveOrderResponse = ActiveOrder.fromJson(jsonBody);

      ActiveOrders = ActiveOrderResponse;
      print(response.body);

      // return jsonBody;
    } else {
      throw Exception(e);
    }

    _isLoading = false;
    notifyListeners();
  }

  ///////////////active orders by id///////////////////////////

  // late OrdersById ActiveOrdersById;

  // Future<void> GetActiveOrdersById() async {
  //   _isLoading = true;

  //   final response = await http.post(
  //       Uri.parse(apidomine + 'get_order_details_by_id'),
  //       body: ({'apikey': apikey, 'order_id': order_idd}));

  //   if (response.statusCode == 200) {
  //     print(response.body);
  //     print(response.statusCode);
  //     final jsonBody = jsonDecode(response.body);

  //     OrdersById ActiveOrderByIdResponse = OrdersById.fromJson(jsonBody);

  //     ActiveOrdersById = ActiveOrderByIdResponse;
  //     print(ActiveOrdersById);

  //     // return jsonBody;
  //   } else {
  //     throw Exception("eeeeeeeeeeeeeeeeeeee" + ' ${e}');
  //   }

  //   _isLoading = false;
  //   notifyListeners();
  // }

  late OrdersById ActiveOrdersById;

  Future<void> GetActiveOrdersById(BuildContext context) async {
    _isLoading = true;
    // ProgressDialog pr = ProgressDialog(
    //   context,
    //   showLogs: true,
    // );
    // pr.style(
    //     message: "",
    //     backgroundColor: wcolor,
    //     progressWidget:
    //         Lottie.asset("assetslottie/Animation - 1697009692722.json"),
    //     progressWidgetAlignment: Alignment.center,
    //     padding: EdgeInsets.only(left: 120));
    try {
      showDialog(
        context: context,
        barrierDismissible: false, // prevent dialog from being dismissed
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.symmetric(horizontal: 100),
            content: Lottie.asset("assetslottie/Animation - 1697009692722.json",
                width: 40, height: 70),
          );
        },
      );
      final response = await http.post(
          Uri.parse(apidomine + 'get_order_details_by_id'),
          body: {'apikey': apikey, 'order_id': order_idd.toString()});

      Navigator.of(context).pop();

      if (response.statusCode == 200) {
        // print(response.body);
        // print(response.statusCode);
        final jsonBody = jsonDecode(response.body);

        OrdersById ActiveOrderByIdResponse = OrdersById.fromJson(jsonBody);

        ActiveOrdersById = ActiveOrderByIdResponse;

        for (final items in ActiveOrdersById.data.details) {
          selectedProducts.add({
            "Barcode": items.barcode.toString(),
            "Qty": items.qty.toInt(),
            "UnitID": items.unitId,
            "SalesPrice": items.rate.toInt(),
            "Modifier": items.scannedBarcode,
            "name": items.itemName,
          });
        }
        deliveryTtype = ActiveOrdersById.data.deliveryType;
        tableId = ActiveOrdersById.data.tableId;
        print(selectedProducts);

        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OrdersPage(),
        ));
      } else {
        // Handle non-200 status code here, you can throw an exception or set an error message.
        throw Exception("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      // Handle exceptions that occur during the request or JSON parsing.
      print("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

//////////////////get_order_details_by_id_and_create_cart////////////////

  late CartDetailsByIdResponse CartOrdersById;

  Future<void> GetCartOrdersById(BuildContext context) async {
    _isLoading = true;
    print("invoiii${invoice_type}");
    print("orderrr${order_idd}");

    try {
      showDialog(
        context: context,
        barrierDismissible: false, // prevent dialog from being dismissed
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.symmetric(horizontal: 100),
            content: Lottie.asset("assetslottie/Animation - 1697009692722.json",
                width: 40, height: 70),
          );
        },
      );
      final response = await http.post(
          Uri.parse(apidomine + 'get_order_details_by_id_and_create_cart'),
          body: {
            'apikey': apikey,
            'order_id': order_idd.toString(),
            'InvoiceType': invoice_type.toString()
          });
      Navigator.of(context).pop();
      if (response.statusCode == 200) {
        // print(response.body);
        // print(response.statusCode);
        final jsonBody = jsonDecode(response.body);

        CartDetailsByIdResponse CartOrderByIdResponse =
            CartDetailsByIdResponse.fromJson(jsonBody);

        CartOrdersById = CartOrderByIdResponse;

        for (final item in CartOrdersById.data.details) {
          selectedProducts.add({
            "Barcode": item.barcode.toString(),
            "Qty": item.quantity.toInt(),
            "UnitID": item.unitID,
            "SalesPrice": item.salesPrice.toInt(),
            "Modifier": item.modifier,
            "name": item.itemName,
          });
        }
        deliveryTtype = CartOrdersById.data.deliveryType;
        tableId = CartOrdersById.data.tableID;

        print(selectedProducts);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OrdersPage(),
        ));
      } else {
        throw Exception("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  //////////////////////////////edit active orders/////////////////////////////

  late EditOrder EditActiveOrder;

  Future<void> GetEditActiveOrder(BuildContext context) async {
    _isLoading = true;

    try {
      final Map<String, dynamic> requestEditActiveOrder = {
        "status": "ok",
        "message": "Order details",
        "data": [
          {
            "apikey": apikey,
            "InvoiceNumber": invoicenumber,
            "order_id": order_idd,
            "TableID": tableId,
            "SeatNumbers": "A",
            "delivery_type": deliveryTtype,
            "Mobile": "",
            "Name": "",
            "Address1": "",
            "EmailID": "",
            "DOB": "",
            "WDATE": "",
            "Address2": "",
            "PriceGroupID": 1,
            "details": selectedProducts
          }
        ]
      };
      final response = await http.post(Uri.parse(apidomine + 'edit_order'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode(requestEditActiveOrder));

      if (response.statusCode == 200) {
        // print(response.body);
        // print(response.statusCode);
        final jsonBody = jsonDecode(response.body);

        EditOrder EditActiveOrderResponse = EditOrder.fromJson(jsonBody);

        EditActiveOrder = EditActiveOrderResponse;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => homepage(),
        ));
        // print("Edited active" + "${EditActiveOrder}");
      } else {
        throw Exception("Request failed with status: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  ///////////////////////////////cart_confirm_ to active order/////////////////////////

  late Orders cartToActiveOrder;

  Future<void> GetcartToActiveOrder(BuildContext context) async {
    _isLoading = true;

    final Map<String, dynamic> requestDatacartToActiveOrder = {
      "status": "ok",
      "message": "Order details",
      "data": [
        {
          "apikey": apikey,
          "TableID": tableId,
          "SeatNumbers": "A",
          "delivery_type": deliveryTtype,
          "Mobile": "",
          "Name": "",
          "Address1": "",
          "EmailID": "",
          "DOB": "",
          "WDATE": "",
          "Address2": "",
          "PriceGroupID": 1,
          "CartMasterID": cart_masterId,
          "order_id": 0,
          "InvoiceNumber": 0
        }
      ]
    };
    final response = await http.post(
      Uri.parse(apidomine + 'cart_confirm_order'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(requestDatacartToActiveOrder),
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      Orders cartToActiveOrderResponse = Orders.fromJson(jsonBody);

      cartToActiveOrder = cartToActiveOrderResponse;
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => homepage(),
      ));

      // InvoiceNumber = CartconfirmOrder.data.invoiceNumber;
      // order_Id = CartconfirmOrder.data.orderId;
      // print("sssssssss" + response.body);
    } else {
      throw Exception(e);
    }

    _isLoading = false;
    notifyListeners();
  }

  late SubCategory subCategorySearch;

  Future<void> getsubCategorySearch(String query) async {
    _isLoading = true;
    final response = await http.post(
        Uri.parse(apidomine + 'get_sub_categories_search'),
        body: ({"subcategory": query}));

    if (response.statusCode == 200) {
      // print(response.body);
      // print(response.statusCode);
      final jsonBody = jsonDecode(response.body);

      SubCategory subCategorySearchResponse = SubCategory.fromJson(jsonBody);

      subCategorySearch = subCategorySearchResponse;

      // return jsonBody;
    } else {
      throw Exception(e);
    }
    _isLoading = false;
    notifyListeners();
  }

  late ProductData ProductsSearch;

  Future<void> GetProductsSearch(String query1) async {
    _isLoading = true;
    final response = await http.post(
        Uri.parse(apidomine + 'get_products_search'),
        body: ({"item": query1, "PriceGroupID": "1"}));

    if (response.statusCode == 200) {
      // print(response.body);
      // print(response.statusCode);
      final jsonBody = jsonDecode(response.body);

      ProductData ProductsSearchResponse = ProductData.fromJson(jsonBody);

      ProductsSearch = ProductsSearchResponse;

      // return jsonBody;
    } else {
      throw Exception(e);
    }
    _isLoading = false;
    notifyListeners();
  }

  late Specification productSpecification;

  Future<void> GetSpecification() async {
    _isLoading = true;
    final response = await http.post(
        Uri.parse(apidomine + 'get_products_by_specification'),
        body: ({"id": productsId.toString(), "PriceGroupID": "1"}));

    if (response.statusCode == 200) {
      // print(response.body);
      // print(response.statusCode);
      final jsonBody = jsonDecode(response.body);

      Specification specificationSearchResponse =
          Specification.fromJson(jsonBody);

      productSpecification = specificationSearchResponse;
      print(response.body);

      // return jsonBody;
    } else {
      throw Exception(e);
    }
    _isLoading = false;
    notifyListeners();
  }
}













// late ServeTypeResponse serveTypeResponse;
// bool isLoading = true;

// void fetchServeT() async {
//   try {
//     ServeTypeResponse response = await getserverApi();
//     serveTypeResponse = response;
//     isLoading = false;
//     notifyListeners();
//   } catch (e) {
//     print(e.toString());
//   }
// }

//   Serverdetails? serverDetails;
//   Future<void> getserverApi() async {
//     final response = await http.post(Uri.parse(apidomine + 'serve_type'),
//         body: ({'apikey': apikey}));

//     if (response.statusCode == 200) {
//       final jsonResponse = json.decode(response.body);
//       serverDetails = serverdetailsFromJson(jsonResponse);
//       notifyListeners();
//     } else {
//       print("error loading");
//     }
//   }
