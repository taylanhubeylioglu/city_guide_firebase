import 'dart:async';

import 'package:city_guide_firebase/domain/repositories/city_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../entities/city.dart';

class GetCity extends UseCase<List<City>, void> {
  final CityRepository _cityRepository;
  final StreamController<List<City>> _controller;

  GetCity(this._cityRepository) : _controller = StreamController.broadcast();

  @override
  Future<Stream<List<City>?>> buildUseCaseStream(void params) async {
    try {
      _cityRepository.getCities().listen((List<City> cities) {
        if (!_controller.isClosed) {
          _controller.add(cities);
        }
      });
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      _controller.addError(error, stackTrace);
    }
    return _controller.stream;
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
