import 'dart:core';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stdbook/core/utils/media_quiers.dart';
import 'package:stdbook/core/widgets/booked_tile.dart';
import 'package:stdbook/core/widgets/custom_app_bar.dart';

class BookedRequestsScreen extends StatefulWidget {
  const BookedRequestsScreen({Key key}) : super(key: key);

  @override
  _BookedRequestsScreenState createState() => _BookedRequestsScreenState();
}

class _BookedRequestsScreenState extends State<BookedRequestsScreen> {
  double hor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff54c56d),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: SafeArea(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    child: const Text(
                      'Requests',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Container()
                ],
              ),
            ),
          ),
          Spacer(
            flex: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: const Text(
                      'Requests total',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  Container(
                    child: const Text(
                      '50',
                      style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: const Text(
                      'Funds',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                  Container(
                    child: const Text(
                      '\$500',
                      style: TextStyle(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(
            flex: 3,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
              height: height(context) * .7,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Material(
                      elevation: 20.0,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: TextField(
                        cursorColor: Color(0xff54c56d),
                        decoration: InputDecoration(
                            hintText: 'Search...',
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              borderSide: BorderSide(width: 1, color: Color(0xff54c56d)),
                            ),
                            focusColor: Colors.green,
                            hoverColor: Colors.green,
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [for (int i = 0; i < 10; i++) BookedTile()],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class Hor extends StatefulWidget {
//   const Hor({Key key}) : super(key: key);

//   @override
//   _HorState createState() => _HorState();
// }

// class _HorState extends State<Hor> {
//   @override
//   double hor = 0;
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 30),
//       child: GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         onHorizontalDragCancel: () {},
//         onHorizontalDragUpdate: (drag) {
//           hor = (drag.localPosition.dx);
//           setState(() {});
//         },
//         child: Transform.translate(
//           offset: Offset(hor, 0),
//           child: Container(
//             height: 50,
//             width: 70,
//             color: Colors.red,
//           ),
//         ),
//       ),
//     );
//   }
// }
