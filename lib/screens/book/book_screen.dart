import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:stdbook/constants/app_constants.dart';
import 'package:stdbook/constants/color_constants.dart';
import 'package:stdbook/core/utils/media_quiers.dart';
import 'package:stdbook/core/widgets/custom_app_bar.dart';
import 'package:stdbook/core/widgets/custom_container.dart';
import 'package:stdbook/core/widgets/custom_dropdown.dart';
import 'package:stdbook/models/create_stadium_model.dart';
import 'package:stdbook/screens/book/book_bloc.dart';

class BookScreen extends StatefulWidget {
  const BookScreen({Key key}) : super(key: key);

  @override
  _BookScreenState createState() => _BookScreenState();
}

class _BookScreenState extends State<BookScreen> {
  BookBloc bloc = BookBloc();
  TimeOfDay fromSelectedTime;
  TimeOfDay toSelectedTime;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await bloc.getTimesFireStore();
      bloc.getAllAvilableTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map;
    bloc.fromTime = (args[AppConstants.fromTime] as From);
    bloc.toTime = (args[AppConstants.toTime] as From);
    bloc.stdiumId = (args[AppConstants.StadiumID] as String);

    return Scaffold(
        backgroundColor: Colors.grey[150],
        appBar: CustomAppBar(),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: StreamBuilder<DateTime>(
                    initialData: DateTime.now(),
                    stream: bloc.dateController.stream.distinct(),
                    builder: (context, snapshot) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: CalendarCarousel<Event>(
                            iconColor: Color(0xff0c3d27),
                            headerTextStyle: TextStyle(color: Color(0xff0c3d27)),
                            onDayPressed: (DateTime date, List<Event> events) {
                              bloc.updateTheSelectedDate(date);
                            },
                            weekendTextStyle: TextStyle(
                              color: Colors.black,
                            ),
                            weekdayTextStyle: TextStyle(color: Colors.black),
                            weekFormat: false,
                            daysHaveCircularBorder: true,
                            selectedDayButtonColor: Color(0xff0c3d27),
                            todayButtonColor: Colors.white,
                            todayBorderColor: Color(0xff54c56d),
                            todayTextStyle: TextStyle(
                                color: snapshot.data.month == DateTime.now().month && snapshot.data.day == DateTime.now().day
                                    ? Colors.white
                                    : Colors.black),
                            selectedDayBorderColor: Color(0xff0c3d27),
                            selectedDateTime: snapshot.data),
                      );
                    }),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomContainer(
                          child: Center(
                              child: StreamBuilder<List<String>>(
                                  initialData: [],
                                  stream: bloc.timesController.stream,
                                  builder: (context, listSnapshot) {
                                    return StreamBuilder<String>(
                                        stream: bloc.selectedFromStream,
                                        builder: (context, snapshot) {
                                          return CustomDropDown(
                                            isNotDeafult: true,
                                            selectedTime: snapshot.data,
                                            menu: listSnapshot.data,
                                            unAvilabletimes: bloc.timeFromunAvailableDates,
                                            callBack: (value) {
                                              bloc.setFromTimes = value;
                                            },
                                            hintText: "From time",
                                          );
                                        });
                                  })),
                          height: height(context) * 0.07,
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Expanded(
                        flex: 2,
                        child: CustomContainer(
                          child: Center(
                              child: StreamBuilder<List<String>>(
                                  initialData: [],
                                  stream: bloc.timesController.stream.distinct(),
                                  builder: (context, listSnapshot) {
                                    return StreamBuilder<String>(
                                        stream: bloc.selectedToStream,
                                        builder: (context, snapshot) {
                                          return CustomDropDown(
                                            menu: listSnapshot.data,
                                            isNotDeafult: true,
                                            selectedTime: snapshot.data,
                                            hintText: "To time",
                                            unAvilabletimes: bloc.timeTounAvailableDates,
                                            callBack: (value) {
                                              bloc.setToTimes = value;
                                            },
                                          );
                                        });
                                  })),
                          height: height(context) * 0.07,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: whidth(context) * 0.8,
              height: height(context) * 0.07,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(bloc.bookCheck() ? ColorConstants.darkGreen : Colors.grey)),
                  onPressed: () async {
                    if (bloc.bookCheck()) {
                      await bloc.setDuration();
                    } else {
                      return null;
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height(context) * 0.05,
            )
          ],
        ));
  }
}
