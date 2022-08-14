import 'dart:async';

import 'package:city_guide_firebase/domain/repositories/user_repository.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class CreateUser extends UseCase<void, CreateUserParams> {
  final UserRepository _userRepository;

  CreateUser(this._userRepository);

  @override
  Future<Stream<void>> buildUseCaseStream(CreateUserParams? params) async {
    StreamController<void> controller = StreamController();
    try {
      await _userRepository.createUser(
          params!.firstName, params.lastName, params.email, params.password);
      controller.close();
    } catch (error, stackTrace) {
      print(error);
      print(stackTrace);
      controller.addError(error, stackTrace);
    }
    return controller.stream;
  }
}

class CreateUserParams {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  CreateUserParams(
    this.firstName,
    this.lastName,
    this.email,
    this.password,
  );
}
