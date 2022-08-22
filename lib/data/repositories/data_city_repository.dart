import 'dart:async';

import 'package:city_guide_firebase/domain/repositories/city_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/city.dart';

class DataCityRepository implements CityRepository {
  final firestoreInstance = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late DocumentSnapshot<Map<String, dynamic>> _documentSnapshot;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<City> _cityList = [];
  bool isCitiesFetched = false;

  StreamController<List<City>> _streamController = StreamController.broadcast();

  void _initCity() async {
    try {
      if (isCitiesFetched) return;
      final value = await firestoreInstance.collection("Sehirler").get();

      if (value.docs.isNotEmpty) {
        List<City> cities = [];
        value.docs.forEach((element) {
          cities.add(City.fromJson(element));
        });
        _cityList = cities;

        Future.delayed(Duration.zero)
            .then((_) => _streamController.add(_cityList));

        isCitiesFetched = true;
      }
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> addCity(
      String cityName, String content, String imageUrl, String uid) async {
    try {
      await _firestore.collection("Sehirler").doc(uid).set({
        "cityName": cityName,
        "content": content,
        "imageUrl": imageUrl,
        "uid": uid,
      });
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
    }
  }

  @override
  Stream<List<City>> getCities() {
    try {
      if (!isCitiesFetched) _initCity();

      Future.delayed(Duration.zero)
          .then((value) => _streamController.add(_cityList));

      return _streamController.stream;
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> removeCity(String uid) async {
    try {
      await _firestore.collection("Sehirler").doc(uid).delete();
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
    }
  }

  @override
  Stream<List<City>> getPersonalCities() {
    try {
      if (!isCitiesFetched) _initCity();

      Future.delayed(Duration.zero)
          .then((value) => _streamController.add(_cityList));

      return _streamController.stream;
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      rethrow;
    }
  }
}
