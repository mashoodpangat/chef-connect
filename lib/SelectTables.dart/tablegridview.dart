import 'package:chef_connect_project/API/ApiProvider.dart';
import 'package:chef_connect_project/API/cartOrderModel.dart';
import 'package:chef_connect_project/SelectTables.dart/selectTables.dart';
import 'package:chef_connect_project/styleUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class Sixseattable extends StatelessWidget {
//   const Sixseattable({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Consumer<DataProvider>(
//           builder: (context, value, child) {
//             return Container(
//               padding: const EdgeInsets.only(
//                 left: 10,
//                 top: 10,
//               ),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           width: 22,
//                           height: 13,
//                           decoration: const BoxDecoration(
//                               color: Color.fromARGB(255, 0, 165, 81),
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(6),
//                                   topRight: Radius.circular(6))),
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         Container(
//                           width: 22,
//                           height: 13,
//                           decoration: const BoxDecoration(
//                               color: Color.fromARGB(255, 0, 165, 81),
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(6),
//                                   topRight: Radius.circular(6))),
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         Container(
//                           width: 22,
//                           height: 13,
//                           decoration: const BoxDecoration(
//                               color: Color.fromARGB(255, 0, 165, 81),
//                               borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(6),
//                                   topRight: Radius.circular(6))),
//                         ),
//                       ],
//                     ),
//                     Container(
//                       width: 95,
//                       height: 70,
//                       decoration: BoxDecoration(
//                           border: Border.all(color: wcolor),
//                           color: Color.fromARGB(255, 58, 62, 74),
//                           borderRadius: BorderRadius.circular(12)),
//                       child: Text(""),
//                     ),
//                     Row(
//                       children: [
//                         const SizedBox(
//                           width: 10,
//                         ),
//                         Container(
//                           width: 22,
//                           height: 13,
//                           decoration: const BoxDecoration(
//                               color: Color.fromARGB(255, 0, 165, 81),
//                               borderRadius: BorderRadius.only(
//                                   bottomLeft: Radius.circular(6),
//                                   bottomRight: Radius.circular(6))),
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         Container(
//                           width: 22,
//                           height: 13,
//                           decoration: const BoxDecoration(
//                               color: Color.fromARGB(255, 0, 165, 81),
//                               borderRadius: BorderRadius.only(
//                                   bottomLeft: Radius.circular(6),
//                                   bottomRight: Radius.circular(6))),
//                         ),
//                         const SizedBox(
//                           width: 5,
//                         ),
//                         Container(
//                           width: 22,
//                           height: 13,
//                           decoration: const BoxDecoration(
//                               color: Color.fromARGB(255, 0, 165, 81),
//                               borderRadius: BorderRadius.only(
//                                   bottomLeft: Radius.circular(6),
//                                   bottomRight: Radius.circular(6))),
//                         ),
//                       ],
//                     )
//                   ]),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

Container sixseat(
  String name, {
  bool isSelected = false,
}) {
  return Container(
    padding: const EdgeInsets.only(
      left: 10,
      top: 10,
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Container(
            width: 22,
            height: 13,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 165, 81),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6))),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            width: 22,
            height: 13,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 165, 81),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6))),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            width: 22,
            height: 13,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 165, 81),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6))),
          ),
        ],
      ),
      Container(
        width: 95,
        height: 70,
        decoration: BoxDecoration(
            border: Border.all(
                color: isSelected ? Colors.green : wcolor,
                width: isSelected ? 3 : 1),
            color: Color.fromARGB(255, 58, 62, 74),
            borderRadius: BorderRadius.circular(12)),
        child: Center(
            child: Text(
          name,
          style: TextStyle(color: Colors.white),
        )),
      ),
      Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          Container(
            width: 22,
            height: 13,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 165, 81),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6))),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            width: 22,
            height: 13,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 165, 81),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6))),
          ),
          const SizedBox(
            width: 5,
          ),
          Container(
            width: 22,
            height: 13,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 165, 81),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6))),
          ),
        ],
      )
    ]),
  );
}

Container fourseat(
  String name, {
  bool isSelected = false,
}) {
  return Container(
    padding: EdgeInsets.only(left: 10, top: 10),
    color: Colors.transparent,
    width: 100,
    height: 107,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 18,
            ),
            Container(
              width: 23,
              height: 13,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 124, 178, 195),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6))),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 23,
              height: 13,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 124, 178, 195),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6))),
            ),
          ],
        ),
        Container(
          width: 90,
          height: 70,
          decoration: BoxDecoration(
              border: Border.all(
                  color: isSelected ? Colors.green : Colors.white,
                  width: isSelected ? 3 : 1),
              color: Color.fromARGB(255, 58, 62, 74),
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Text(
              name,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Row(
          children: [
            const SizedBox(
              width: 18,
            ),
            Container(
              width: 23,
              height: 13,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 124, 178, 195),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6))),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 23,
              height: 13,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 124, 178, 195),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6))),
            ),
          ],
        )
      ],
    ),
  );
}

Container TwoSeat(
  String name, {
  bool isSelected = false,
}) {
  return Container(
    color: Colors.transparent,
    width: 50,
    height: 100,
    padding: EdgeInsets.only(left: 10, top: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Container(
              width: 23,
              height: 13,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 124, 178, 195),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6))),
            ),
          ],
        ),
        Container(
          width: 60,
          height: 70,
          decoration: BoxDecoration(
              border: Border.all(
                  color: isSelected ? Colors.green : Colors.white,
                  width: isSelected ? 3 : 1),
              color: Color.fromARGB(255, 58, 62, 74),
              borderRadius: BorderRadius.circular(12)),
          child: Center(
              child: Text(
            name,
            style: TextStyle(color: Colors.white),
          )),
        ),
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Container(
              width: 23,
              height: 13,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 124, 178, 195),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6))),
            ),
          ],
        )
      ],
    ),
  );
}

Container fourseathomepage(index) {
  return Container(
    color: Colors.transparent,
    width: 100,
    height: 50,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 25,
            ),
            Container(
              width: 22,
              height: 7,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 124, 178, 195),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6))),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 22,
              height: 7,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 124, 178, 195),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6))),
            ),
          ],
        ),
        Consumer<DataProvider>(
          builder: (context, value, child) {
            return Container(
              width: 83,
              height: 33,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: Color.fromARGB(255, 58, 62, 74),
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Text(
                  value.data2.data.ongoing_tables[index].table_no,
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            );
          },
        ),
        Row(
          children: [
            const SizedBox(
              width: 25,
            ),
            Container(
              width: 22,
              height: 7,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 124, 178, 195),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6))),
            ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: 22,
              height: 7,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 124, 178, 195),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6))),
            ),
          ],
        )
      ],
    ),
  );
}

Container table(index) {
  return Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
        color: Color.fromARGB(255, 216, 216, 216),
        borderRadius: BorderRadius.circular(12)),
    child: Column(children: [
      SizedBox(
        height: 2,
      ),
      Row(
        children: [
          const SizedBox(
            width: 21,
          ),
          Container(
            width: 18,
            height: 8,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 58, 62, 74),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6))),
          ),
        ],
      ),
      Consumer<DataProvider>(
        builder: (context, value, child) {
          return Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: Color.fromARGB(255, 58, 62, 74),
                borderRadius: BorderRadius.circular(12)),
            child: Center(
                child: Text(
              value.ActiveOrders.data.orders[index].tableNo,
              style: TextStyle(color: Colors.white, fontSize: 13),
            )),
          );
        },
      ),
      Row(
        children: [
          const SizedBox(
            width: 21,
          ),
          Container(
            width: 18,
            height: 8,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 58, 62, 74),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6))),
          ),
        ],
      )
    ]),
  );
}
