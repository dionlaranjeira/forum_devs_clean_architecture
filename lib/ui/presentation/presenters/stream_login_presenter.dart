import 'dart:async';

import 'package:meta/meta.dart';
import 'package:forum_devs_clean_architecture/ui/presentation/presenters/protocols/protocols.dart';

class LoginState{
  String emailError;
  String passqwordError;
  bool get isFormValid => false;
}

class StreamLoginPresenter{
  final Validation validation;
  final _controller = StreamController<LoginState>.broadcast();

  var _state = LoginState();

  Stream<String> get emailErrorStream => _controller.stream.map((state) => state.emailError).distinct();
  Stream<String> get passwordErrorStream => _controller.stream.map((state) => state.passqwordError).distinct();
  Stream<bool> get isFormValidStream => _controller.stream.map((state) => state.isFormValid).distinct();

  StreamLoginPresenter({@required this.validation});

  void _update() =>  _controller.add(_state);

  void validateEmail(String email){
    _state.emailError = validation.validate(field: 'email', value: email);
    _update();
  }

  void validatePassword(String password){
    _state.passqwordError = validation.validate(field: 'password', value: password);
    _update();
  }

}
