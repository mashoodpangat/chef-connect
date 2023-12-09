import 'package:chef_connect_project/API/cartOrderModel.dart';
import 'package:chef_connect_project/FoodItemCategories/ProductCategories.dart';
import 'package:chef_connect_project/kitchenOrderlogin.dart';
import 'package:chef_connect_project/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Stateprovider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  void setApidomine(String newValue) {
    apidomine = newValue;
    notifyListeners();
  }

  String get apiKey => storedApi;

  String storedApi = '';
  String storedUsername = "";

  Future<void> getApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    storedApi = prefs.getString("api_key") ?? '';
    storedUsername = prefs.getString("UserName") ?? "";
    apikey = storedApi;
    username = storedUsername;

    notifyListeners();
    print("api:" + apikey);
    print("storedUsername" + storedUsername);
  }

  ////////////grand total//////////
  double grandTotal = 0.0;
  void calculateGrandTotal(List<Map<String, dynamic>> selectedProducts) {
    _isLoading = true;
    double total = 0.0;
    for (var product in selectedProducts) {
      total += product["Qty"] * product["SalesPrice"];
    }
    grandTotal = total;
    _isLoading = false;
    notifyListeners();
  }

  void updateQuantity(int index, int quantity) {
    _isLoading = true;
    selectedProducts[index]["Qty"] = quantity;
    _isLoading = false;
    notifyListeners();
  }
}
