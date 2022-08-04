abstract class LoginPresenter{
  Stream get emailErrorStream;
  Stream get passwordErrorStream;
  Stream get isFormValidControler;

  void validateEmail(String email);
  void validatePassword(String password);
}