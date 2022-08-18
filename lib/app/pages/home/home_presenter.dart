import 'package:city_guide_firebase/domain/repositories/city_repository.dart';
import 'package:city_guide_firebase/domain/usecases/get_city.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../domain/entities/city.dart';

class HomePresenter extends Presenter {
  late Function getCityOnNext;
  late Function getCityOnError;

  final GetCity _getCity;

  HomePresenter(CityRepository _cityRepository)
      : _getCity = GetCity(_cityRepository);

  @override
  void dispose() {
    _getCity.dispose();
  }

  void getCity() {
    _getCity.execute(_GetCityObserver(this));
  }
}

class _GetCityObserver extends Observer<List<City>> {
  final HomePresenter _presenter;

  _GetCityObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(error) {
    _presenter.getCityOnError(error);
  }

  @override
  void onNext(List<City>? response) {
    _presenter.getCityOnNext(response);
  }
}
