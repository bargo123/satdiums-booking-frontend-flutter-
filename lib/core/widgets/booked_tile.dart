import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BookedTile extends StatelessWidget {
  final String image;
  final String name;
  final String date;
  final String hours;
  const BookedTile({this.image, this.name, this.date, this.hours});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '1998/18/1',
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 5)]),
            child: ListTile(
              dense: true,
              title: Text(
                'Zaid Barghouthi',
                style: TextStyle(color: Color(0xff54c56d), fontSize: 18),
              ),
              isThreeLine: false,
              subtitle: Text(
                '2 Hours',
                style: TextStyle(color: Colors.grey[400], fontSize: 16),
              ),
              trailing: const Text(
                'Pending',
                style: TextStyle(color: Colors.orange, fontSize: 15),
              ),
              leading: ClipOval(
                  child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.person),
                      ))),
            ),
          ),
        ],
      ),
    );
  }
}
