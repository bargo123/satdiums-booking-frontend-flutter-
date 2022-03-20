import 'package:flutter/material.dart';

class Reservations extends StatefulWidget {
  const Reservations({Key key}) : super(key: key);

  @override
  _ReservationsState createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Flutter layout demo'),
        ),
        body: ListTile(
          leading: Icon(
            Icons.access_alarm_outlined,
            size: 60,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'dsadasdasdsad',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Text('dsadasdasdsad'),
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'dsadasdasdsad',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Text('dsadasdasdsad'),
            ],
          ),
        ));
  }
}
