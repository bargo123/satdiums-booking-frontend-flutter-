import 'package:flutter/material.dart';
import 'package:stdbook/core/widgets/custom_app_bar.dart';
import 'package:stdbook/core/widgets/home_page_widgets/stadium_list_view.dart';
import 'package:stdbook/models/home_page_model.dart';
import 'package:stdbook/screens/home_page.dart/home_page_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePageBloc bloc = HomePageBloc();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await bloc.getTheDataFromFireStore();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(),
        backgroundColor: Color(0xfff6f6f6),
        body: Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 16),
          child: Column(
            children: [
              StreamBuilder<HomePageModel>(
                  stream: bloc.homePageModelController,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return StadiumListViwe(
                        homePageModel: snapshot.data,
                      );
                    } else {
                      return Expanded(child: Center(child: CircularProgressIndicator()));
                    }
                  })
            ],
          ),
        ));
  }
}
