import 'package:flutter/material.dart';
import 'package:stdbook/constants/app_constants.dart';
import 'package:stdbook/constants/route_constants.dart';
import 'package:stdbook/core/widgets/home_page_widgets/stadium_tile.dart';
import 'package:stdbook/models/home_page_model.dart';
import 'package:stdbook/screens/home_page.dart/home_page_screen.dart';

class StadiumListViwe extends StatelessWidget {
  const StadiumListViwe({Key key, this.homePageModel}) : super(key: key);
  final HomePageModel homePageModel;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: homePageModel.length,
          itemBuilder: (context, index) {
            return StadiumTile(
              onTap: () {
                Navigator.pushNamed(context, RouteConstants.stadium_screen,
                    arguments: {AppConstants.StadiumID: homePageModel.stadiums[index].createdBy});
              },
              image: homePageModel.stadiums[index].images.first,
              price: homePageModel.stadiums[index].price,
              stadiumName: homePageModel.stadiums[index].name,
            );
          }),
    );
  }
}
