import 'package:forum_devs_clean_architecture/domain/helpers/domain_error.dart';
import 'package:forum_devs_clean_architecture/domain/usecases/authentication.dart';
import 'package:forum_devs_clean_architecture/ui/pages/login/login_presenter.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:forum_devs_clean_architecture/ui/presentation/presenters/protocols/protocols.dart';


class GetxLoginPresenter extends GetxController implements LoginPresenter {
  final Validation validation;
  final Authentication authentication;


  String _email;
  String _password;
  var _emailError = RxString();
  var _passwordError = RxString();
  var _mainError = RxString();
  var _isFormValid = false.obs;
  var _isLoading = false.obs;


  Stream<String> get emailErrorStream => _emailError.stream;
  Stream<String> get passwordErrorStream => _passwordError.stream;
  Stream<String> get mainErrorStream => _mainError.stream;
  Stream<bool> get isFormValidStream => _isFormValid.stream;
  Stream<bool> get isLoadingStream => _isLoading.stream;

  GetxLoginPresenter({@required this.validation, @required this.authentication});


  void validateEmail(String email){
    _email = email;
    _emailError.value = validation.validate(field: 'email', value: email);
    _validateForm();
  }

  void validatePassword(String password){
    _password = password;
    _passwordError.value = validation.validate(field: 'password', value: password);
    _validateForm();
  }

  void _validateForm(){
    _isFormValid.value = _emailError.value == null
        && _passwordError.value == null
        && _email != null
        && _password != null;
  }


  Future<void> auth() async {
    _isLoading.value = true;


    try{
      await authentication.auth(AuthenticationParams(email: _email, password: _password));
    } on DomainError catch(error){
      _mainError.value = error.description;
    }
    _isLoading.value = false;

  }

  //Get não precisa de dispose, só está aqui por conta da interface de stream que precisa e foi criada inicialmente
  void dispose(){}

}
