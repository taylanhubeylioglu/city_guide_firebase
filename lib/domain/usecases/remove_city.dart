import 'dart:async';

import 'package:city_guide_firebase/domain/repositories/city_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class RemoveCity extends UseCase<void, RemoveCityParams> {
  final CityRepository _cityRepository;

  RemoveCity(this._cityRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(RemoveCityParams? params) async {
    StreamController<void> controller = StreamController();

    try {
      await _cityRepository.removeCity(params!.uid);
      controller.close();
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
    }
    return controller.stream;
  }
}

class RemoveCityParams {
  String uid;
  RemoveCityParams(this.uid);
}
