import 'package:city_guide_firebase/domain/repositories/city_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../../../domain/usecases/add_city.dart';

class AddCityPresenter extends Presenter {
  late Function addCityOnComplete;
  late Function addCityOnError;

  final AddCity _addCity;

  AddCityPresenter(CityRepository _cityRepository)
      : _addCity = AddCity(_cityRepository);

  @override
  void dispose() {
    _addCity.dispose();
  }

  void addCity(String cityName, String content, String imageUrl, String uid) {
    _addCity.execute(_AddCityObserver(this),
        AddCityParams(cityName, content, imageUrl, uid));
  }
}

class _AddCityObserver extends Observer<void> {
  final AddCityPresenter _presenter;

  _AddCityObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.addCityOnComplete();
  }

  @override
  void onError(error) {
    _presenter.addCityOnError(error);
  }

  @override
  void onNext(_) {}
}
