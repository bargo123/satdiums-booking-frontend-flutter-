import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stdbook/constants/app_constants.dart';
import 'package:stdbook/constants/route_constants.dart';
import 'package:stdbook/core/utils/formater.dart';
import 'package:stdbook/models/create_stadium_model.dart';
import 'package:stdbook/screens/stadium/stadium_bloc.dart';

class StadiumScreen extends StatefulWidget {
  const StadiumScreen({Key key}) : super(key: key);

  @override
  _StadiumScreenState createState() => _StadiumScreenState();
}

class _StadiumScreenState extends State<StadiumScreen> {
  StadiumBloc bloc = StadiumBloc();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await bloc.getStadiumData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map;
    bloc.stadiumIdSetter = (args[AppConstants.StadiumID] as String);
    return Scaffold(
      body: StreamBuilder<CreateStadiumModel>(
          stream: bloc.stadiumControllerGetter,
          builder: (context, stadiumsnapshot) {
            if (stadiumsnapshot.data != null) {
              return Stack(
                children: [
                  StreamBuilder<CreateStadiumModel>(
                      stream: bloc.stadiumControllerGetter,
                      builder: (context, snapshot) {
                        return Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(stadiumsnapshot.data.stadiums.images[0]),
                                  )),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                          ],
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            Expanded(
                              child: Container(),
                              flex: 2,
                            )
                          ],
                        );
                      }),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50)),
                      ),
                      height: 450,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                stadiumsnapshot.data.stadiums.name,
                                style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Wehdat, Amman ',
                                style: TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                              SizedBox(height: 8),
                              Divider(
                                height: 2,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.orange,
                                            size: 30,
                                          ),
                                          Text(
                                            '0.0',
                                            style: TextStyle(fontSize: 20, color: Colors.black),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '0 Ratings',
                                        style: TextStyle(fontSize: 15, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Icons.lock_open,
                                            color: Color(0xff0c3d27),
                                            size: 30,
                                          ),
                                          Text(
                                            '${stadiumsnapshot.data.stadiums.days.fromDay} - ${stadiumsnapshot.data.stadiums.days.toDay}',
                                            style: TextStyle(fontSize: 20, color: Colors.black),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        Formater().durationToString(stadiumsnapshot.data.stadiums.timesOfDay.from.hour,
                                                stadiumsnapshot.data.stadiums.timesOfDay.from.min) +
                                            " - " +
                                            Formater().durationToString(
                                                stadiumsnapshot.data.stadiums.timesOfDay.to.hour,
                                                stadiumsnapshot.data.stadiums.timesOfDay.to.min),
                                        style: TextStyle(fontSize: 15, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Divider(
                                height: 2,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 15),
                              Text(
                                'Features',
                                style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(child: featureBuilder(stadiumsnapshot.data.stadiums.features)),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 200,
                                color: Colors.green,
                              ),
                              SizedBox(
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 100,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    stadiumsnapshot.data.stadiums.price,
                                    style:
                                        TextStyle(fontSize: 25, color: Color(0xff0c3d27), fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '/Hour',
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Expanded(child: Container()),
                                  Center(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: ElevatedButton(
                                        style:
                                            ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0xff0c3d27))),
                                        onPressed: () {
                                          Navigator.pushNamed(context, RouteConstants.book_screen, arguments: {
                                            AppConstants.fromTime: stadiumsnapshot.data.stadiums.timesOfDay.from,
                                            AppConstants.toTime: stadiumsnapshot.data.stadiums.timesOfDay.to,
                                            AppConstants.StadiumID: bloc.stadiumId
                                          });
                                        },
                                        child: Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(19),
                                            child: Text(
                                              'Book Now',
                                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Widget featureBuilder(List<String> features) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var feature in features)
          Text(
            '\n - $feature\n',
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
      ],
    );
  }
}
