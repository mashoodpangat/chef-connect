// import 'dart:convert';
// import 'package:chef_connect_project/API/cartOrderModel.dart';
// import 'package:chef_connect_project/FoodItemCategories/ProductCategories.dart';
// import 'package:chef_connect_project/SelectTables.dart/selectTables.dart';
// import 'package:chef_connect_project/createOrder.dart/SelectServerType.dart';
// import 'package:chef_connect_project/itemOrder/orders.dart';
// import 'package:chef_connect_project/kitchenOrderlogin.dart';
// import 'package:chef_connect_project/splashscreen.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class MyGetx extends GetxController {
//   var isLoading = true.obs;

//   @override
//   void onInit() async {
//     await GetActiveOrdersById();
//     super.onInit();
//   }

//   late OrdersById ActiveOrdersById;

//   Future<void> GetActiveOrdersById() async {
//     try {
//       isLoading(true);
//       final response = await http.post(
//           Uri.parse(apidomine + 'get_order_details_by_id'),
//           body: {'apikey': apikey, 'order_id': order_idd.toString()});

//       if (response.statusCode == 200) {
//         final jsonBody = jsonDecode(response.body);

//         OrdersById ActiveOrderByIdResponse = OrdersById.fromJson(jsonBody);

//         ActiveOrdersById = ActiveOrderByIdResponse;

//         for (final items in ActiveOrdersById.data.details) {
//           selectedProducts.add({
//             "Barcode": items.barcode.toString(),
//             "Qty": items.qty.toInt(),
//             "UnitID": items.unitId,
//             "SalesPrice": items.rate.toInt(),
//             "Modifier": items.scannedBarcode,
//             "name": items.itemName,
//           });
//         }
//         deliveryTtype = ActiveOrdersById.data.deliveryType;
//         tableId = ActiveOrdersById.data.tableId;
//         print(selectedProducts);

//         // Use Get.to instead of Navigator.of(context).push
//         Get.to(() => OrdersPage());
//       } else {
//         throw Exception("Request failed with status: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error: $e");
//     } finally {
//       isLoading(false);
//     }
//   }
// }
