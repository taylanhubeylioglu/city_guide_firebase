import 'package:city_guide_firebase/app/pages/home/home_view.dart';
import 'package:city_guide_firebase/app/pages/login/login_presenter.dart';
import 'package:city_guide_firebase/domain/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

class LoginController extends Controller {
  final LoginPresenter _presenter;

  LoginController(UserRepository _userRepository)
      : _presenter = LoginPresenter(_userRepository);

  String? email;
  String? password;

  // Test için direkt sayfaya geçiş
  // @override
  // void onInitState() {
  //   FirebaseAuth.instance.authStateChanges().listen((User? user) {
  //     if (user != null) {
  //       Navigator.pushAndRemoveUntil(
  //           getContext(),
  //           CupertinoPageRoute(builder: (context) => HomeView()),
  //           (route) => false);
  //     }
  //   });
  //   super.onInitState();
  // }

  @override
  void initListeners() {
    _presenter.signInWithEmailOnComplete = () {
      Navigator.push(
          getContext(), MaterialPageRoute(builder: (context) => HomeView()));
    };
  }

  void onEmailTextChanged(String value) {
    email = value;
    refreshUI();
  }

  void onPasswordTextChanged(String value) {
    password = value;
    refreshUI();
  }

  void signIn() {
    _presenter.signInWithEmail(email!, password!);
    refreshUI();
  }
}
