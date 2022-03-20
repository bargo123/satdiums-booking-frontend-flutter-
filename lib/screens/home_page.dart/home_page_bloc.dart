import 'package:rxdart/subjects.dart';
import 'package:stdbook/models/home_page_model.dart';
import 'package:stdbook/screens/home_page.dart/home_page_screen.dart';
import 'package:stdbook/services/firebase_services.dart/firestore_service.dart';

class HomePageBloc {
  StadiumsService service = StadiumsService();
  BehaviorSubject<HomePageModel> homePageModelController = BehaviorSubject<HomePageModel>();

  Future getTheDataFromFireStore() async {
    var data = await service.getHomePageData();
    homePageModelController.sink.add(data);
  }
}
