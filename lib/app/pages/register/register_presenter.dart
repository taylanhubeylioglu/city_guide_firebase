import 'package:city_guide_firebase/domain/repositories/user_repository.dart';
import 'package:city_guide_firebase/domain/usecases/create_user.dart';
import 'package:city_guide_firebase/domain/usecases/sign_in_with_email.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class RegisterPresenter extends Presenter {
  late Function createUserOnComplete;
  late Function createUserOnError;

  late Function signWithEmailOnComplete;
  late Function signInWithEmailOnError;

  final SignInWithEmail _signInWithEmail;
  final CreateUser _createUser;

  RegisterPresenter(UserRepository _userRepository)
      : _createUser = CreateUser(_userRepository),
        _signInWithEmail = SignInWithEmail(_userRepository);

  @override
  void dispose() {
    _createUser.dispose();
    _signInWithEmail.dispose();
  }

  void createUser(
      String firstName, String lastName, String email, String password) {
    _createUser.execute(CreateUserObserver(this),
        CreateUserParams(firstName, lastName, email, password));
  }

  void signInWithEmail(String email, String password) {
    _signInWithEmail.execute(
        _SignInWithEmailObserver(this), SignInWithEmailParams(email, password));
  }
}

class CreateUserObserver extends Observer<void> {
  final RegisterPresenter _presenter;

  CreateUserObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.createUserOnComplete();
  }

  @override
  void onError(error) {
    _presenter.createUserOnError(error);
  }

  @override
  void onNext(_) {}
}

class _SignInWithEmailObserver extends Observer<void> {
  final RegisterPresenter _presenter;

  _SignInWithEmailObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.signWithEmailOnComplete();
  }

  @override
  void onError(error) {
    _presenter.signInWithEmailOnError(error);
  }

  @override
  void onNext(_) {}
}
