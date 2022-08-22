import 'package:city_guide_firebase/app/pages/profile/profile_presenter.dart';
import 'package:city_guide_firebase/domain/repositories/city_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../domain/entities/city.dart';

class ProfileController extends Controller {
  final ProfilePresenter _presenter;

  ProfileController(CityRepository _cityRepository)
      : _presenter = ProfilePresenter(_cityRepository);

  List<City>? cities;

  @override
  void onInitState() {
    _presenter.getCity();
    super.onInitState();
  }

  @override
  void initListeners() {
    _presenter.getCityOnNext = (List<City>? response) {
      if (response != null) {
        cities = response;

        refreshUI();
      }
    };

    _presenter.getCityOnError = (error) {
      print(error);
    };
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }
}
