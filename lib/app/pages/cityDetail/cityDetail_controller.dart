import 'package:city_guide_firebase/app/pages/cityDetail/cityDetail_presenter.dart';
import 'package:city_guide_firebase/app/pages/home/home_view.dart';
import 'package:city_guide_firebase/domain/repositories/city_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:lottie/lottie.dart';

class CityDetailController extends Controller {
  final CityDetailPresenter _presenter;

  CityDetailController(CityRepository _cityRepository)
      : _presenter = CityDetailPresenter(_cityRepository);

  @override
  void initListeners() {
    _presenter.removeCityOnComplete = () {
      Navigator.push(
        getContext(),
        MaterialPageRoute(
          builder: (context) => HomeView(),
        ),
      );
    };
    _presenter.removeCityOnError = (error) {
      showDialog(
          context: getContext(),
          builder: (getContext) => AlertDialog(
                title: Text("Something went wrong. Try again."),
                content: Lottie.asset(
                  'assets/animations/somethingWentWrong.json',
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(getContext);
                      },
                      child: Text("Close"))
                ],
              ));
    };
  }

  void removeCity(String uid) {
    _presenter.removeCity(uid);
    refreshUI();
  }
}
