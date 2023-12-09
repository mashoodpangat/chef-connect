import 'dart:convert';

class HomeDataResponse {
  bool error;
  String message;
  HomeData data;

  HomeDataResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  factory HomeDataResponse.fromJson(Map<String, dynamic> json) {
    return HomeDataResponse(
      error: json['error'],
      message: json['message'],
      data: HomeData.fromJson(json['data']),
    );
  }
}

class HomeData {
  UserDetails user_details;
  List<OngoingTable> ongoing_tables;

  HomeData({
    required this.user_details,
    required this.ongoing_tables,
  });

  factory HomeData.fromJson(Map<String, dynamic> json) {
    var ongoingTablesList = json['ongoing_tables'] as List;
    List<OngoingTable> ongoingTables =
        ongoingTablesList.map((item) => OngoingTable.fromJson(item)).toList();

    return HomeData(
      user_details: UserDetails.fromJson(json['user_details']),
      ongoing_tables: ongoingTables,
    );
  }
}

class UserDetails {
  String store_name;
  String user_name;
  String active_orders;
  String dinein;
  String takeaway;
  String parcel;

  UserDetails({
    required this.store_name,
    required this.user_name,
    required this.active_orders,
    required this.dinein,
    required this.takeaway,
    required this.parcel,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      store_name: json['store_name'],
      user_name: json['user_name'],
      active_orders: json['active_orders'],
      dinein: json['dinein'],
      takeaway: json['takeaway'],
      parcel: json['parcel'],
    );
  }
}

class OngoingTable {
  int invoiceNumber;
  String invoiceType;
  int order_id;
  int NoOfItems;
  double GrandTotal;
  String table_no;
  String no_of_seats;
  int Persons;
  String time;
  int UserID;

  OngoingTable({
    required this.invoiceNumber,
    required this.invoiceType,
    required this.order_id,
    required this.NoOfItems,
    required this.GrandTotal,
    required this.table_no,
    required this.no_of_seats,
    required this.Persons,
    required this.time,
    required this.UserID,
  });

  factory OngoingTable.fromJson(Map<String, dynamic> json) {
    return OngoingTable(
      invoiceNumber: json['InvoiceNumber'],
      invoiceType: json['InvoiceType'],
      order_id: json['order_id'],
      NoOfItems: json['NoOfItems'],
      GrandTotal: json['GrandTotal'].toDouble(),
      table_no: json['table_no'] ?? "0",
      no_of_seats: json['no_of_seats'],
      Persons: json['Persons'],
      time: json['time'],
      UserID: json['UserID'],
    );
  }
}

//////////////////////////////////////////////////////////////////////////////
class ServeType {
  final String serveType;
  final double charge;
  final int otherCharges;

  ServeType({
    required this.serveType,
    required this.charge,
    required this.otherCharges,
  });

  factory ServeType.fromJson(Map<String, dynamic> json) {
    return ServeType(
      serveType: json['ServeType'],
      charge: double.parse(json['Charge']),
      otherCharges: json['OtherCharges'],
    );
  }
}

class ServeTypeResponse {
  final bool error;
  final String message;
  final String serveTime;
  final List<ServeType> serveTypes;

  ServeTypeResponse({
    required this.error,
    required this.message,
    required this.serveTime,
    required this.serveTypes,
  });

  factory ServeTypeResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> serveTypeList = json['data']['serve_type'];
    List<ServeType> serveTypes = serveTypeList
        .map((serveTypeJson) => ServeType.fromJson(serveTypeJson))
        .toList();

    return ServeTypeResponse(
      error: json['error'],
      message: json['message'],
      serveTime: json['data']['serve_time'],
      serveTypes: serveTypes,
    );
  }
}

////////////////////////////////tables locations//////////////////////////
///
///

// TablesLocation tablesLocationFromJson(String str) => TablesLocation.fromJson(json.decode(str));

// String tablesLocationToJson(TablesLocation data) => json.encode(data.toJson());

class TablesLocation {
  bool error;
  String message;
  Data data;

  TablesLocation({
    required this.error,
    required this.message,
    required this.data,
  });

  factory TablesLocation.fromJson(Map<String, dynamic> json) => TablesLocation(
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
  List<Location> locations;

  Data({
    required this.locations,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        locations: List<Location>.from(
            json["locations"].map((x) => Location.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "locations": List<dynamic>.from(locations.map((x) => x.toJson())),
      };
}

class Location {
  String location;

  Location({
    required this.location,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        location: json["Location"],
      );

  Map<String, dynamic> toJson() => {
        "Location": location,
      };
}

////////////////////////////////////////////////table balcony/////////////////////////////////////////////

class TableResponse {
  final bool error;
  final String message;
  final TableDataResponse data;

  TableResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  factory TableResponse.fromJson(Map<String, dynamic> json) {
    return TableResponse(
      error: json['error'] as bool,
      message: json['message'] as String,
      data: TableDataResponse.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class TableDataResponse {
  final List<Table> tables;

  TableDataResponse({
    required this.tables,
  });

  factory TableDataResponse.fromJson(Map<String, dynamic> json) {
    final tablesData = json['tables'] as List<dynamic>;
    final tables = tablesData
        .map((tableData) => Table.fromJson(tableData as Map<String, dynamic>))
        .toList();
    return TableDataResponse(tables: tables);
  }
}

class Table {
  final String name;
  final int noOfSeats;
  final int id;
  final int priceGroupID;
  final List<Seat> seats;

  Table({
    required this.name,
    required this.noOfSeats,
    required this.id,
    required this.priceGroupID,
    required this.seats,
  });

  factory Table.fromJson(Map<String, dynamic> json) {
    final seatsData = json['seats'] as List<dynamic>;
    final seats = seatsData
        .map((seatData) => Seat.fromJson(seatData as Map<String, dynamic>))
        .toList();

    return Table(
      name: json['name'] as String,
      noOfSeats: json['NoOfSeats'] as int,
      id: json['id'] as int,
      priceGroupID: json['PriceGroupID'] as int,
      seats: seats,
    );
  }
}

class Seat {
  final String seatName;
  final bool isVacant;

  Seat({
    required this.seatName,
    required this.isVacant,
  });

  factory Seat.fromJson(Map<String, dynamic> json) {
    return Seat(
      seatName: json['SeatName'] as String,
      isVacant: json['IsVacant'] as bool,
    );
  }
}

/////////////////////////////sub categories//////////////////////////////////

class mainSubCategories {
  bool error;
  String message;
  List<Subcategory> subcategories;

  mainSubCategories({
    required this.error,
    required this.message,
    required this.subcategories,
  });

  factory mainSubCategories.fromJson(Map<String, dynamic> json) {
    return mainSubCategories(
      error: json["error"],
      message: json["message"],
      subcategories: List<Subcategory>.from(
          json["data"]["subcategories"].map((x) => Subcategory.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": {
          "subcategories":
              List<dynamic>.from(subcategories.map((x) => x.toJson())),
        },
      };
}

class Subcategory {
  int id;
  String name;
  String imageUrl;

  Subcategory({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    return Subcategory(
      id: json["id"],
      name: json["name"],
      imageUrl: json["image_url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image_url": imageUrl,
      };
}

////////////////////////////////////////active orders//////////////////////////////

class OrderResponse {
  final bool error;
  final String message;
  final OrderData data;

  OrderResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
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
  final String billingName;
  final double grandTotal;
  final List<dynamic> details;

  OrderData({
    required this.invoiceNumber,
    required this.orderId,
    required this.noOfItems,
    required this.billingName,
    required this.grandTotal,
    required this.details,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      invoiceNumber: json['InvoiceNumber'],
      orderId: json['order_id'],
      noOfItems: json['NoOfItems'],
      billingName: json['BillingName'],
      grandTotal: json['GrandTotal'].toDouble(),
      details: json['details'],
    );
  }
}

/////////////////////////////////// create cart///////////////////////////////

class CreateCartResponse {
  bool error;
  String message;
  CartData data;

  CreateCartResponse({
    required this.error,
    required this.message,
    required this.data,
  });

  factory CreateCartResponse.fromJson(Map<String, dynamic> json) {
    return CreateCartResponse(
      error: json['error'],
      message: json['message'],
      data: CartData.fromJson(json['data']),
    );
  }
}

class CartData {
  int cartMasterID;
  int tableID;
  String seatNumbers;
  String deliveryType;
  List<CartItem> details;

  CartData({
    required this.cartMasterID,
    required this.tableID,
    required this.seatNumbers,
    required this.deliveryType,
    required this.details,
  });

  factory CartData.fromJson(Map<String, dynamic> json) {
    var detailsList = json['details'] as List;
    List<CartItem> cartItems =
        detailsList.map((item) => CartItem.fromJson(item)).toList();

    return CartData(
      cartMasterID: json['CartMasterID'],
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

/////////////////////////////////////////////cart_confirm_order///////////////////////////

class Orders {
  final bool error;
  final String message;
  final OrderData data;

  Orders({
    required this.error,
    required this.message,
    required this.data,
  });

  factory Orders.fromJson(Map<String, dynamic> json) {
    return Orders(
      error: json['error'],
      message: json['message'],
      data: OrderData.fromJson(json['data']),
    );
  }
}

class OrderDatas {
  final int invoiceNumber;
  final int orderId;
  final int noOfItems;
  final String billingName;
  final double grandTotal;
  final List<OrderDetail> details;

  OrderDatas({
    required this.invoiceNumber,
    required this.orderId,
    required this.noOfItems,
    required this.billingName,
    required this.grandTotal,
    required this.details,
  });

  factory OrderDatas.fromJson(Map<String, dynamic> json) {
    var detailsList = <OrderDetail>[];
    if (json['details'] != null) {
      json['details'].forEach((detail) {
        detailsList.add(OrderDetail.fromJson(detail));
      });
    }

    return OrderDatas(
      invoiceNumber: json['InvoiceNumber'],
      orderId: json['order_id'],
      noOfItems: json['NoOfItems'],
      billingName: json['BillingName'],
      grandTotal: json['GrandTotal'],
      details: detailsList,
    );
  }
}

class OrderDetail {
  final int nonTradeDetailId;
  final int tradeDetailId;
  final int nonTradeMasterId;
  final int barcode;
  final double qty;
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
      nonTradeDetailId: json['NonTradeDetailID'],
      tradeDetailId: json['TradeDetailID'],
      nonTradeMasterId: json['NonTradeMasterID'],
      barcode: json['Barcode'],
      qty: json['Qty'],
      unitId: json['UnitID'],
      unitPrice: json['UnitPrice'],
      rate: json['Rate'],
      grossValue: json['GrossValue'],
      taxPerc: json['TaxPerc'],
      tax: json['Tax'],
      taxable: json['Taxable'],
      netAmount: json['NetAmount'],
      itemId: json['ItemID'],
      itemCode: json['ItemCode'],
      itemName: json['ItemName'],
      unitCode: json['UnitCode'],
      cessPerc: json['CessPerc'],
      cess: json['Cess'],
      sgstPerc: json['SGSTPerc'],
      sgst: json['SGST'],
      cgstPerc: json['CGSTPerc'],
      cgst: json['CGST'],
      igstPerc: json['IGSTPerc'],
      igst: json['IGST'],
      scannedBarcode: json['ScannedBarcode'],
      cess1Perc: json['Cess1Perc'],
      cess1: json['Cess1'],
      cess2Perc: json['Cess2Perc'],
      cess2: json['Cess2'],
      salesPrice2: json['SalesPrice2'],
      salesPrice3: json['SalesPrice3'],
      msp: json['MSP'],
      specification: json['Specification'],
      itemStatus: json['ItemStatus'],
    );
  }
}
