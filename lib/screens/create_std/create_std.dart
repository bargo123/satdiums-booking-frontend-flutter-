import 'package:flutter/material.dart';
import 'package:stdbook/constants/color_constants.dart';
import 'package:stdbook/core/enums/loading_Status_enum.dart';
import 'package:stdbook/core/utils/formater.dart';
import 'package:stdbook/core/utils/media_quiers.dart';
import 'package:stdbook/core/widgets/bottom_sheets.dart';
import 'package:stdbook/core/widgets/custom_app_bar.dart';
import 'package:stdbook/core/widgets/custom_container.dart';
import 'package:stdbook/core/widgets/custom_dropdown.dart';
import 'package:stdbook/models/create_stadium_model.dart';
import 'package:stdbook/screens/create_std/create_Std_bloc.dart';
import 'package:stdbook/screens/create_std/create_std_widgets.dart';

class CreateStadiumScreen extends StatefulWidget {
  const CreateStadiumScreen({Key key}) : super(key: key);

  @override
  _CreateStadiumScreenState createState() => _CreateStadiumScreenState();
}

class _CreateStadiumScreenState extends State<CreateStadiumScreen> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await bloc.fireStoreData();
      fieldNameController = TextEditingController(text: bloc.fieldName);
      priceController = TextEditingController(text: bloc.selectedPrices);
    });
  }

  CreateStadiumBloc bloc = CreateStadiumBloc();
  TextEditingController fieldNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  FocusNode faieldNameNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.grey[100],
        appBar: CustomAppBar(),
        body: StreamBuilder<LoadingStatus>(
            initialData: LoadingStatus.IN_PROGRESS,
            stream: bloc.loadindStatusController,
            builder: (context, snapshot) {
              return snapshot.data == LoadingStatus.Finished
                  ? Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            faieldNameNode.unfocus();
                          },
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 25, right: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: height(context) * 0.02,
                                  ),
                                  addImages(),
                                  Divider(
                                    height: height(context) * 0.04,
                                    thickness: 2,
                                    color: Colors.grey[200],
                                  ),
                                  Text(
                                    'Field Name',
                                    style: TextStyle(color: ColorConstants.darkGreen, fontSize: 20),
                                  ),
                                  SizedBox(
                                    height: height(context) * 0.02,
                                  ),
                                  TextField(
                                    focusNode: faieldNameNode,
                                    controller: fieldNameController,
                                    onChanged: (val) {
                                      bloc.fieldName = val;
                                    },
                                    cursorColor: Color(0xff54c56d),
                                    decoration: InputDecoration(
                                        hintText: 'Field Name...',
                                        prefixIcon: Icon(
                                          Icons.keyboard,
                                          color: Colors.grey,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          borderSide: BorderSide(width: 1, color: Color(0xff54c56d)),
                                        ),
                                        focusColor: Colors.green,
                                        hoverColor: Colors.green,
                                        filled: true,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)),
                                  ),
                                  SizedBox(
                                    height: height(context) * 0.02,
                                  ),
                                  price(),
                                  SizedBox(
                                    height: height(context) * 0.02,
                                  ),
                                  features(),
                                  Divider(
                                    height: height(context) * 0.04,
                                    thickness: 2,
                                    color: Colors.grey[200],
                                  ),
                                  duration(),
                                  Divider(
                                    height: height(context) * 0.04,
                                    thickness: 2,
                                    color: Colors.grey[200],
                                  ),
                                  SizedBox(
                                    height: height(context) * 0.08,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: whidth(context) * 0.8,
                                height: height(context) * 0.07,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(
                                            bloc.isButtonEnabled() ? ColorConstants.darkGreen : Colors.grey)),
                                    onPressed: () async {
                                      await bloc.uploadDataToFireStore();
                                    },
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height(context) * 0.02,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Center(child: CircularProgressIndicator());
            }));
  }

  Widget addImages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add Images',
          style: TextStyle(color: ColorConstants.darkGreen, fontSize: 20),
        ),
        SizedBox(
          height: height(context) * 0.02,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: StreamBuilder<List<String>>(
              initialData: [],
              stream: bloc.imagesController,
              builder: (context, snapshot) {
                return Row(
                  children: [
                    for (int i = 0; i < snapshot.data.length; i++)
                      StadiumImages(
                        imageSrc: snapshot.data[i],
                        useLocalImage: bloc.checkisUrl(snapshot.data[i]),
                        onTap: () async {
                          BottomSheetUtil().showDeleteAndChangeBottomSheet(context, deleteButtonCallBack: () {
                            bloc.removeImage(snapshot.data[i]);
                          }, changeButtonCallBack: () {
                            bloc.changeImage(i, snapshot.data[i]);
                          });
                        },
                      ),
                    InkWell(
                      onTap: () async {
                        await bloc.addImage();
                      },
                      child: CustomContainer(
                        child: Icon(
                          Icons.add,
                          color: ColorConstants.darkGreen,
                          size: 50,
                        ),
                        height: height(context) * 0.2,
                        backgroundColor: Colors.white,
                        width: whidth(context) * 0.4,
                      ),
                    )
                  ],
                );
              }),
        ),
      ],
    );
  }

  Widget features() {
    return StreamBuilder<List<String>>(
        stream: bloc.featuresController,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Features',
                style: TextStyle(color: ColorConstants.darkGreen, fontSize: 20),
              ),
              SizedBox(
                height: height(context) * 0.02,
              ),
              CustomContainer(
                  child: CustomDropDown(
                hintText: "Select a feature",
                menu: bloc.featurs,
                callBack: (newValue) {
                  if (bloc.addedFeature.contains(newValue)) return;
                  bloc.addedFeature.add(newValue);
                  bloc.featuresController.sink.add(bloc.addedFeature);
                },
              )),
              snapshot.data != null && snapshot.data.isNotEmpty
                  ? Wrap(
                      children: [
                        for (int i = 0; i < snapshot.data.length; i++)
                          Features(
                            featureType: snapshot.data[i],
                          )
                      ],
                    )
                  : Container()
            ],
          );
        });
  }

  Widget price() {
    print(bloc.pricePerHour);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price per hour',
          style: TextStyle(color: ColorConstants.darkGreen, fontSize: 20),
        ),
        SizedBox(
          height: height(context) * 0.02,
        ),
        CustomContainer(
          child: TextField(
            controller: priceController,
            onChanged: (val) {
              bloc.setPrice("$val");
            },
            cursorColor: Color(0xff54c56d),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: "Price  ",
                prefixIcon: Icon(
                  Icons.money,
                  color: Colors.grey,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(width: 1, color: Color(0xff54c56d)),
                ),
                suffix: Text("JD"),
                focusColor: Colors.green,
                hoverColor: Colors.green,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none)),
          ),
        ),
      ],
    );
  }

  Widget duration() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Durations',
          style: TextStyle(color: ColorConstants.darkGreen, fontSize: 20),
        ),
        SizedBox(
          height: height(context) * 0.02,
        ),
        dayChanger(false),
        SizedBox(
          height: height(context) * 0.02,
        ),
        dayChanger(true),
        SizedBox(
          height: height(context) * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            timeChanger(true),
            timeChanger(false),
          ],
        ),
      ],
    );
  }

  Widget timeChanger(bool isFrom) {
    return GestureDetector(
      onTap: () {
        _selectTime(context, isFrom);
      },
      child: CustomContainer(
        width: whidth(context) * 0.35,
        child: Center(
            child: StreamBuilder<From>(
                stream: bloc.timeOfDayController.stream.map((event) => isFrom ? event.from : event.to).distinct(),
                builder: (context, snapshot) {
                  return FittedBox(
                    fit: BoxFit.contain,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        snapshot.hasData ? Formater().durationToString(snapshot.data.hour, snapshot.data.min) : 'Time',
                        style: TextStyle(color: ColorConstants.darkGreen),
                      ),
                    ),
                  );
                })),
        backgroundColor: Colors.white,
        height: 50,
      ),
    );
  }

  Widget dayChanger(bool isFrom) {
    return StreamBuilder<String>(
        stream: bloc.daysController.stream.map((event) => isFrom ? event.fromDay : event.toDay).distinct(),
        builder: (context, snapshot) {
          return CustomContainer(
            child: CustomDropDown(
              hintText: "Select Day",
              callBack: (newDay) {
                bloc.checkIsFromDay(newDay, isFrom);
              },
              value: snapshot.data,
              menu: bloc.days,
            ),
          );
        });
  }

  Future<dynamic> _selectTime(BuildContext context, bool isFrom) async {
    final TimeOfDay timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 0, minute: 0),
      initialEntryMode: TimePickerEntryMode.dial,
    );
    bloc.checkIsFromTime(isFrom, timeOfDay);
  }
}
