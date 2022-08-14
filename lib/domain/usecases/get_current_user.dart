import 'dart:async';

import 'package:city_guide_firebase/domain/repositories/user_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import '../entities/user.dart';

class GetCurrentUser extends UseCase<User, void> {
  final UserRepository _userRepository;

  GetCurrentUser(this._userRepository);

  @override
  Future<Stream<User?>> buildUseCaseStream(void params) async {
    StreamController<User> controller = StreamController();

    try {
      User currentUser = await _userRepository.getCurrentUser();
      controller.add(currentUser);
      controller.close();
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      controller.addError(error, stackTrace);
    }
    return controller.stream;
  }
}
