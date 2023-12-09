import 'package:chef_connect_project/API/Stateprovider.dart';
import 'package:chef_connect_project/FoodItemCategories/ProductCategories.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class QuantityDialog extends StatefulWidget {
  final String productName;
  final int initialQuantity;
  final int index;

  QuantityDialog({
    required this.productName,
    required this.initialQuantity,
    required this.index,
  });

  @override
  _QuantityDialogState createState() => _QuantityDialogState();
}

class _QuantityDialogState extends State<QuantityDialog> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialQuantity;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Change Quantity"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Product: ${widget.productName}"),
          SizedBox(height: 10),
          Text("Current Quantity: $quantity"),
          SizedBox(height: 10),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "New Quantity",
            ),
            onChanged: (newValue) {
              setState(() {
                quantity = int.tryParse(newValue) ?? quantity;
              });
            },
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text("OK"),
          onPressed: () {
            // Use the 'quantity' variable as needed, e.g., update it in your provider
            Provider.of<Stateprovider>(context, listen: false)
                .updateQuantity(widget.index, quantity);

            Provider.of<Stateprovider>(context, listen: false)
                .calculateGrandTotal(selectedProducts);

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
