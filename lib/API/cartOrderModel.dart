// import 'dart:convert';

// //////////////////////////
// ///
// class confirmOrder {
//   final bool error;
//   final String message;
//   final OrderData data;

//   confirmOrder(
//       {required this.error, required this.message, required this.data});

//   factory confirmOrder.fromJson(Map<String, dynamic> json) {
//     return confirmOrder(
//       error: json['error'],
//       message: json['message'],
//       data: OrderData.fromJson(json['data']),
//     );
//   }
// }

// class OrderData {
//   final int invoiceNumber;
//   final int orderId;
//   final int noOfItems;
//   final String billingName;
//   final double grandTotal;
//   final List<OrderDetail> details;

//   OrderData({
//     required this.invoiceNumber,
//     required this.orderId,
//     required this.noOfItems,
//     required this.billingName,
//     required this.grandTotal,
//     required this.details,
//   });

//   factory OrderData.fromJson(Map<String, dynamic> json) {
//     var detailList = json['details'] as List;
//     List<OrderDetail> OrdersById =
//         detailList.map((detail) => OrderDetail.fromJson(detail)).toList();

//     return OrderData(
//       invoiceNumber: json['InvoiceNumber'],
//       orderId: json['order_id'],
//       noOfItems: json['NoOfItems'],
//       billingName: json['BillingName'],
//       grandTotal: json['GrandTotal'],
//       details: OrdersById,
//     );
//   }
// }

// class OrderDetail {
//   final int nonTradeDetailId;
//   final int tradeDetailId;
//   final int nonTradeMasterId;
//   final int barcode;
//   final double qty;
//   final int unitId;
//   final double unitPrice;
//   final double rate;
//   final double grossValue;
//   final double taxPerc;
//   final double tax;
//   final double taxable;
//   final double netAmount;
//   final int itemId;
//   final String itemCode;
//   final String itemName;
//   final String unitCode;
//   final double cessPerc;
//   final double cess;
//   final double sgstPerc;
//   final double sgst;
//   final double cgstPerc;
//   final double cgst;
//   final double igstPerc;
//   final double igst;
//   final String scannedBarcode;
//   final double cess1Perc;
//   final double cess1;
//   final double cess2Perc;
//   final double cess2;
//   final double salesPrice2;
//   final double salesPrice3;
//   final double msp;
//   final String specification;
//   final String itemStatus;

//   OrderDetail({
//     required this.nonTradeDetailId,
//     required this.tradeDetailId,
//     required this.nonTradeMasterId,
//     required this.barcode,
//     required this.qty,
//     required this.unitId,
//     required this.unitPrice,
//     required this.rate,
//     required this.grossValue,
//     required this.taxPerc,
//     required this.tax,
//     required this.taxable,
//     required this.netAmount,
//     required this.itemId,
//     required this.itemCode,
//     required this.itemName,
//     required this.unitCode,
//     required this.cessPerc,
//     required this.cess,
//     required this.sgstPerc,
//     required this.sgst,
//     required this.cgstPerc,
//     required this.cgst,
//     required this.igstPerc,
//     required this.igst,
//     required this.scannedBarcode,
//     required this.cess1Perc,
//     required this.cess1,
//     required this.cess2Perc,
//     required this.cess2,
//     required this.salesPrice2,
//     required this.salesPrice3,
//     required this.msp,
//     required this.specification,
//     required this.itemStatus,
//   });

//   factory OrderDetail.fromJson(Map<String, dynamic> json) {
//     return OrderDetail(
//       nonTradeDetailId: json['NonTradeDetailID'],
//       tradeDetailId: json['TradeDetailID'],
//       nonTradeMasterId: json['NonTradeMasterID'],
//       barcode: json['Barcode'],
//       qty: json['Qty'],
//       unitId: json['UnitID'],
//       unitPrice: json['UnitPrice'],
//       rate: json['Rate'],
//       grossValue: json['GrossValue'],
//       taxPerc: json['TaxPerc'],
//       tax: json['Tax'],
//       taxable: json['Taxable'],
//       netAmount: json['NetAmount'],
//       itemId: json['ItemID'],
//       itemCode: json['ItemCode'],
//       itemName: json['ItemName'],
//       unitCode: json['UnitCode'],
//       cessPerc: json['CessPerc'],
//       cess: json['Cess'],
//       sgstPerc: json['SGSTPerc'],
//       sgst: json['SGST'],
//       cgstPerc: json['CGSTPerc'],
//       cgst: json['CGST'],
//       igstPerc: json['IGSTPerc'],
//       igst: json['IGST'],
//       scannedBarcode: json['ScannedBarcode'],
//       cess1Perc: json['Cess1Perc'],
//       cess1: json['Cess1'],
//       cess2Perc: json['Cess2Perc'],
//       cess2: json['Cess2'],
//       salesPrice2: json['SalesPrice2'],
//       salesPrice3: json['SalesPrice3'],
//       msp: json['MSP'],
//       specification: json['Specification'],
//       itemStatus: json['ItemStatus'],
//     );
//   }
// }

import 'dart:convert';

///////////////////////ActiveOrders////////////////////////////////

ActiveOrder activeOrderFromJson(String str) =>
    ActiveOrder.fromJson(json.decode(str));

String activeOrderToJson(ActiveOrder data) => json.encode(data.toJson());

class ActiveOrder {
  bool error;
  String message;
  Data data;

  ActiveOrder({
    required this.error,
    required this.message,
    required this.data,
  });

  factory ActiveOrder.fromJson(Map<String, dynamic> json) => ActiveOrder(
        error: json["error"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  List<Order> orders;

  Data({
    required this.orders,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orders: List<Order>.from(json["orders"].map((x) => Order.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "orders": List<dynamic>.from(orders.map((x) => x.toJson())),
      };
}

class Order {
  int invoiceNumber;
  String invoiceType;
  int orderId;
  int noOfItems;
  double grandTotal;
  String tableNo;
  String noOfSeats;
  int persons;
  String time;

  Order({
    required this.invoiceNumber,
    required this.invoiceType,
    required this.orderId,
    required this.noOfItems,
    required this.grandTotal,
    required this.tableNo,
    required this.noOfSeats,
    required this.persons,
    required this.time,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        invoiceNumber: json["InvoiceNumber"],
        invoiceType: json["InvoiceType"],
        orderId: json["order_id"],
        noOfItems: json["NoOfItems"],
        grandTotal: json["GrandTotal"],
        tableNo: json["table_no"] ?? "0",
        noOfSeats: json["no_of_seats"],
        persons: json["Persons"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "InvoiceNumber": invoiceNumber,
        "InvoiceType": invoiceType,
        "order_id": orderId,
        "NoOfItems": noOfItems,
        "GrandTotal": grandTotal,
        "table_no": tableNo,
        "no_of_seats": noOfSeats,
        "Persons": persons,
        "time": time,
      };
}

//////////////////////////////active orders by id///////////////////

class OrdersById {
  final bool error;
  final String message;
  final OrderData data;

  OrdersById({
    required this.error,
    required this.message,
    required this.data,
  });

  factory OrdersById.fromJson(Map<String, dynamic> json) {
    return OrdersById(
      error: json['error'],
      message: json['message'],
      data: OrderData.fromJson(json['data']),
    );
  }
}

class OrderData {
  final int invoiceNumber;
  final int orderId;
  final int noOfItems;
  final int tableId;
  final String seatNumbers;
  final String deliveryType;
  final String name;
  final String mobile;
  final String address1;
  final String address2;
  final int priceGroupId;
  final double grandTotal;
  final List<OrderDetail> details;

  OrderData({
    required this.invoiceNumber,
    required this.orderId,
    required this.noOfItems,
    required this.tableId,
    required this.seatNumbers,
    required this.deliveryType,
    required this.name,
    required this.mobile,
    required this.address1,
    required this.address2,
    required this.priceGroupId,
    required this.grandTotal,
    required this.details,
  });
  factory OrderData.fromJson(Map<String, dynamic> json) {
    final detailsList = json['details'] as List<dynamic>;
    final detailsData =
        detailsList.map((detail) => OrderDetail.fromJson(detail)).toList();

    return OrderData(
      invoiceNumber: json['InvoiceNumber'] is int
          ? json['InvoiceNumber']
          : int.tryParse(json['InvoiceNumber'].toString()) ?? 0,
      orderId: json['order_id'] is int
          ? json['order_id']
          : int.tryParse(json['order_id'].toString()) ?? 0,
      noOfItems: json['NoOfItems'] is int
          ? json['NoOfItems']
          : int.tryParse(json['NoOfItems'].toString()) ?? 0,
      tableId: json['TableID'] is int
          ? json['TableID']
          : int.tryParse(json['TableID'].toString()) ?? 0,
      seatNumbers: json['SeatNumbers'] ?? "",
      deliveryType: json['delivery_type'] ?? "",
      name: json['Name'] ?? "",
      mobile: json['Mobile'] ?? "",
      address1: json['Address1'] ?? "",
      address2: json['Address2'] ?? "",
      priceGroupId: json['PriceGroupID'] is int
          ? json['PriceGroupID']
          : int.tryParse(json['PriceGroupID'].toString()) ?? 0,
      grandTotal: json['GrandTotal'] is double
          ? json['GrandTotal']
          : double.tryParse(json['GrandTotal'].toString()) ?? 0.0,
      details: detailsData,
    );
  }
}

class OrderDetail {
  final int nonTradeDetailId;
  final int tradeDetailId;
  final int nonTradeMasterId;
  final int barcode;
  double qty;
  final int unitId;
  final double unitPrice;
  final double rate;
  final double grossValue;
  final double taxPerc;
  final double tax;
  final double taxable;
  final double netAmount;
  final int itemId;
  final String itemCode;
  final String itemName;
  final String unitCode;
  final double cessPerc;
  final double cess;
  final double sgstPerc;
  final double sgst;
  final double cgstPerc;
  final double cgst;
  final double igstPerc;
  final double igst;
  final String scannedBarcode;
  final double cess1Perc;
  final double cess1;
  final double cess2Perc;
  final double cess2;
  final double salesPrice2;
  final double salesPrice3;
  final double msp;
  final String specification;
  final String itemStatus;

  OrderDetail({
    required this.nonTradeDetailId,
    required this.tradeDetailId,
    required this.nonTradeMasterId,
    required this.barcode,
    required this.qty,
    required this.unitId,
    required this.unitPrice,
    required this.rate,
    required this.grossValue,
    required this.taxPerc,
    required this.tax,
    required this.taxable,
    required this.netAmount,
    required this.itemId,
    required this.itemCode,
    required this.itemName,
    required this.unitCode,
    required this.cessPerc,
    required this.cess,
    required this.sgstPerc,
    required this.sgst,
    required this.cgstPerc,
    required this.cgst,
    required this.igstPerc,
    required this.igst,
    required this.scannedBarcode,
    required this.cess1Perc,
    required this.cess1,
    required this.cess2Perc,
    required this.cess2,
    required this.salesPrice2,
    required this.salesPrice3,
    required this.msp,
    required this.specification,
    required this.itemStatus,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      nonTradeDetailId: json['NonTradeDetailID'] is String
          ? int.tryParse(json['NonTradeDetailID']) ?? 0
          : json['NonTradeDetailID'],
      tradeDetailId: json['TradeDetailID'] is String
          ? int.tryParse(json['TradeDetailID']) ?? 0
          : json['TradeDetailID'],
      nonTradeMasterId: json['NonTradeMasterID'] is String
          ? int.tryParse(json['NonTradeMasterID']) ?? 0
          : json['NonTradeMasterID'],
      barcode: json['Barcode'] is String
          ? int.tryParse(json['Barcode']) ?? 0
          : json['Barcode'],
      qty: json['Qty'] is double
          ? json['Qty']
          : double.tryParse(json['Qty'].toString()) ?? 0.0,
      unitId: json['UnitID'] is String
          ? int.tryParse(json['UnitID']) ?? 0
          : json['UnitID'],
      unitPrice: json['UnitPrice'] is String
          ? double.tryParse(json['UnitPrice']) ?? 0.0
          : json['UnitPrice'],
      rate: json['Rate'] is String
          ? double.tryParse(json['Rate']) ?? 0.0
          : json['Rate'],
      grossValue: json['GrossValue'] is String
          ? double.tryParse(json['GrossValue']) ?? 0.0
          : json['GrossValue'],
      taxPerc: json['TaxPerc'] is String
          ? double.tryParse(json['TaxPerc']) ?? 0.0
          : json['TaxPerc'],
      tax: json['Tax'] is String
          ? double.tryParse(json['Tax']) ?? 0.0
          : json['Tax'],
      taxable: json['Taxable'] is String
          ? double.tryParse(json['Taxable']) ?? 0.0
          : json['Taxable'],
      netAmount: json['NetAmount'] is String
          ? double.tryParse(json['NetAmount']) ?? 0.0
          : json['NetAmount'],
      itemId: json['ItemID'] is String
          ? int.tryParse(json['ItemID']) ?? 0
          : json['ItemID'],
      itemCode: json['ItemCode'],
      itemName: json['ItemName'],
      unitCode: json['UnitCode'],
      cessPerc: json['CessPerc'] is String
          ? double.tryParse(json['CessPerc']) ?? 0.0
          : json['CessPerc'],
      cess: json['Cess'] is String
          ? double.tryParse(json['Cess']) ?? 0.0
          : json['Cess'],
      sgstPerc: json['SGSTPerc'] is String
          ? double.tryParse(json['SGSTPerc']) ?? 0.0
          : json['SGSTPerc'],
      sgst: json['SGST'] is String
          ? double.tryParse(json['SGST']) ?? 0.0
          : json['SGST'],
      cgstPerc: json['CGSTPerc'] is String
          ? double.tryParse(json['CGSTPerc']) ?? 0.0
          : json['CGSTPerc'],
      cgst: json['CGST'] is String
          ? double.tryParse(json['CGST']) ?? 0.0
          : json['CGST'],
      igstPerc: json['IGSTPerc'] is String
          ? double.tryParse(json['IGSTPerc']) ?? 0.0
          : json['IGSTPerc'],
      igst: json['IGST'] is String
          ? double.tryParse(json['IGST']) ?? 0.0
          : json['IGST'],
      scannedBarcode: json['ScannedBarcode'],
      cess1Perc: json['Cess1Perc'] is String
          ? double.tryParse(json['Cess1Perc']) ?? 0.0
          : json['Cess1Perc'],
      cess1: json['Cess1'] is String
          ? double.tryParse(json['Cess1']) ?? 0.0
          : json['Cess1'],
      cess2Perc: json['Cess2Perc'] is String
          ? double.tryParse(json['Cess2Perc']) ?? 0.0
          : json['Cess2Perc'],
      cess2: json['Cess2'] is String
          ? double.tryParse(json['Cess2']) ?? 0.0
          : json['Cess2'],
      salesPrice2: json['SalesPrice2'] is String
          ? double.tryParse(json['SalesPrice2']) ?? 0.0
          : json['SalesPrice2'],
      salesPrice3: json['SalesPrice3'] is String
          ? double.tryParse(json['SalesPrice3']) ?? 0.0
          : json['SalesPrice3'],
      msp: json['MSP'] is String
          ? double.tryParse(json['MSP']) ?? 0.0
          : json['MSP'],
      specification: json['Specification'],
      itemStatus: json['ItemStatus'],
    );
  }
}

///////////////////////////////get_order_details_by_id_and_create_cart///////////////////

class CartDetailsByIdResponse {
  bool error;
  String message;
  CartDetailsData data;

  CartDetailsByIdResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  factory CartDetailsByIdResponse.fromJson(Map<String, dynamic> json) {
    return CartDetailsByIdResponse(
      error: json['error'],
      message: json['message'],
      data: CartDetailsData.fromJson(json['data']),
    );
  }
}

class CartDetailsData {
  int cartMasterID;
  int orderID;
  int invoiceNumber;
  int tableID;
  String seatNumbers;
  String deliveryType;
  List<CartItem> details;

  CartDetailsData({
    required this.cartMasterID,
    required this.orderID,
    required this.invoiceNumber,
    required this.tableID,
    required this.seatNumbers,
    required this.deliveryType,
    required this.details,
  });

  factory CartDetailsData.fromJson(Map<String, dynamic> json) {
    var detailsList = json['details'] as List;
    List<CartItem> cartItems =
        detailsList.map((item) => CartItem.fromJson(item)).toList();

    return CartDetailsData(
      cartMasterID: json['CartMasterID'],
      orderID: json['order_id'],
      invoiceNumber: json['InvoiceNumber'],
      tableID: json['TableID'] ?? "0",
      seatNumbers: json['SeatNumbers'],
      deliveryType: json['delivery_type'],
      details: cartItems,
    );
  }
}

class CartItem {
  String itemName;
  int barcode;
  double salesPrice;
  double quantity;
  String unit;
  int unitID;
  String modifier;
  int itemID;
  int cartDetailsID;

  CartItem({
    required this.itemName,
    required this.barcode,
    required this.salesPrice,
    required this.quantity,
    required this.unit,
    required this.unitID,
    required this.modifier,
    required this.itemID,
    required this.cartDetailsID,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      itemName: json['ItemName'],
      barcode: json['Barcode'],
      salesPrice: json['SalesPrice'].toDouble(),
      quantity: json['Quantity'].toDouble(),
      unit: json['Unit'],
      unitID: json['UnitID'],
      modifier: json['Modifier'],
      itemID: json['ItemID'],
      cartDetailsID: json['CartDetailsID'],
    );
  }
}

///////////////////////////edit active order///////////////////////////////

class EditOrder {
  bool error;
  String message;
  EditOrderData data;

  EditOrder({
    required this.error,
    required this.message,
    required this.data,
  });

  factory EditOrder.fromJson(Map<String, dynamic> json) {
    return EditOrder(
      error: json['error'],
      message: json['message'],
      data: EditOrderData.fromJson(json['data']),
    );
  }
}

class EditOrderData {
  int invoiceNumber;
  int orderId;
  int noOfItems;
  String billingName;
  double grandTotal;
  int tableId;
  String seatNumber;
  int priceGroupId;
  String mobile;
  String address1;
  String address2;
  String serveType;
  List<EditOrderDetail> details;
  String seatNumbers;

  EditOrderData({
    required this.invoiceNumber,
    required this.orderId,
    required this.noOfItems,
    required this.billingName,
    required this.grandTotal,
    required this.tableId,
    required this.seatNumber,
    required this.priceGroupId,
    required this.mobile,
    required this.address1,
    required this.address2,
    required this.serveType,
    required this.details,
    required this.seatNumbers,
  });

  factory EditOrderData.fromJson(Map<String, dynamic> json) {
    var detailsList = json['details'] as List;
    List<EditOrderDetail> details =
        detailsList.map((detail) => EditOrderDetail.fromJson(detail)).toList();

    return EditOrderData(
      invoiceNumber: json['InvoiceNumber'],
      orderId: json['order_id'],
      noOfItems: json['NoOfItems'],
      billingName: json['BillingName'],
      grandTotal: json['GrandTotal'].toDouble(),
      tableId: json['TableID'],
      seatNumber: json['SeatNumber'],
      priceGroupId: json['PriceGroupID'],
      mobile: json['Mobile'],
      address1: json['Address1'],
      address2: json['Address2'],
      serveType: json['ServeType'],
      details: details,
      seatNumbers: json['SeatNumbers'],
    );
  }
}

class EditOrderDetail {
  int nonTradeDetailId;
  int tradeDetailId;
  int nonTradeMasterId;
  int barcode;
  double qty;
  int unitId;
  double unitPrice;
  double rate;
  double grossValue;
  double taxPerc;
  double tax;
  double taxable;
  double netAmount;
  int itemId;
  String itemCode;
  String itemName;
  String unitCode;
  double cessPerc;
  double cess;
  double sgstPerc;
  double sgst;
  double cgstPerc;
  double cgst;
  double igstPerc;
  double igst;
  String scannedBarcode;
  double cess1Perc;
  double cess1;
  double cess2Perc;
  double cess2;
  double salesPrice2;
  double salesPrice3;
  double msp;
  String specification;
  String itemStatus;

  EditOrderDetail({
    required this.nonTradeDetailId,
    required this.tradeDetailId,
    required this.nonTradeMasterId,
    required this.barcode,
    required this.qty,
    required this.unitId,
    required this.unitPrice,
    required this.rate,
    required this.grossValue,
    required this.taxPerc,
    required this.tax,
    required this.taxable,
    required this.netAmount,
    required this.itemId,
    required this.itemCode,
    required this.itemName,
    required this.unitCode,
    required this.cessPerc,
    required this.cess,
    required this.sgstPerc,
    required this.sgst,
    required this.cgstPerc,
    required this.cgst,
    required this.igstPerc,
    required this.igst,
    required this.scannedBarcode,
    required this.cess1Perc,
    required this.cess1,
    required this.cess2Perc,
    required this.cess2,
    required this.salesPrice2,
    required this.salesPrice3,
    required this.msp,
    required this.specification,
    required this.itemStatus,
  });

  factory EditOrderDetail.fromJson(Map<String, dynamic> json) {
    return EditOrderDetail(
      nonTradeDetailId: json['NonTradeDetailID'],
      tradeDetailId: json['TradeDetailID'],
      nonTradeMasterId: json['NonTradeMasterID'],
      barcode: json['Barcode'],
      qty: json['Qty'].toDouble(),
      unitId: json['UnitID'],
      unitPrice: json['UnitPrice'].toDouble(),
      rate: json['Rate'].toDouble(),
      grossValue: json['GrossValue'].toDouble(),
      taxPerc: json['TaxPerc'].toDouble(),
      tax: json['Tax'].toDouble(),
      taxable: json['Taxable'].toDouble(),
      netAmount: json['NetAmount'].toDouble(),
      itemId: json['ItemID'],
      itemCode: json['ItemCode'],
      itemName: json['ItemName'],
      unitCode: json['UnitCode'],
      cessPerc: json['CessPerc'].toDouble(),
      cess: json['Cess'].toDouble(),
      sgstPerc: json['SGSTPerc'].toDouble(),
      sgst: json['SGST'].toDouble(),
      cgstPerc: json['CGSTPerc'].toDouble(),
      cgst: json['CGST'].toDouble(),
      igstPerc: json['IGSTPerc'].toDouble(),
      igst: json['IGST'].toDouble(),
      scannedBarcode: json['ScannedBarcode'],
      cess1Perc: json['Cess1Perc'].toDouble(),
      cess1: json['Cess1'].toDouble(),
      cess2Perc: json['Cess2Perc'].toDouble(),
      cess2: json['Cess2'].toDouble(),
      salesPrice2: json['SalesPrice2'].toDouble(),
      salesPrice3: json['SalesPrice3'].toDouble(),
      msp: json['MSP'].toDouble(),
      specification: json['Specification'],
      itemStatus: json['ItemStatus'],
    );
  }
}

/////////////////////////////////////Sub category search//////////////////////////////////

class SubCategory {
  final bool error;
  final String message;
  final SubCategoryData data;

  SubCategory({
    required this.error,
    required this.message,
    required this.data,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      error: json['error'] as bool,
      message: json['message'] as String,
      data: SubCategoryData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class SubCategoryData {
  final List<SubCategoryItem> subcategories;

  SubCategoryData({
    required this.subcategories,
  });

  factory SubCategoryData.fromJson(Map<String, dynamic> json) {
    final subcategoriesList = (json['subcategories'] as List)
        .map((item) => SubCategoryItem.fromJson(item as Map<String, dynamic>))
        .toList();

    return SubCategoryData(subcategories: subcategoriesList);
  }
}

class SubCategoryItem {
  final int id;
  final String name;
  final String imageUrl;

  SubCategoryItem({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory SubCategoryItem.fromJson(Map<String, dynamic> json) {
    return SubCategoryItem(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String,
    );
  }
}

//////////////////////////products Search///////////////////////

class ProductData {
  final bool error;
  final String message;
  final String status;
  final List<Product> products;

  ProductData({
    required this.error,
    required this.message,
    required this.status,
    required this.products,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) {
    List<Product> productList = <Product>[];
    if (json['data'] != null && json['data']['products'] != null) {
      for (var productJson in json['data']['products']) {
        productList.add(Product.fromJson(productJson));
      }
    }

    return ProductData(
      error: json['error'] ?? false,
      message: json['message'] ?? '',
      status: json['status'] ?? '',
      products: productList,
    );
  }
}

class Product {
  final String name;
  final int barcode;
  final int id;
  final String imageUrl;
  final double rate;
  final int time;
  final int unitId;

  Product({
    required this.name,
    required this.barcode,
    required this.id,
    required this.imageUrl,
    required this.rate,
    required this.time,
    required this.unitId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? '',
      barcode: json['barcode'] ?? 0,
      id: json['id'] ?? 0,
      imageUrl: json['image_url'] ?? '',
      rate: json['rate'] ?? 0.0,
      time: json['time'] ?? 0,
      unitId: json['UnitID'] ?? 0,
    );
  }
}
