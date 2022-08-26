import 'package:forum_devs_clean_architecture/validations/validators/protocols/protocols.dart';

class EmailValidation implements FieldValidation {
  final String field;

  EmailValidation(this.field);

  String validate(String value){

    // var emailRegex = /^[a-z0-9.]+@[a-z0-9]+\.[a-z]+\.([a-z]+)?$/i;
    final regex = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');

    final isValid = value?.isNotEmpty != true || regex.hasMatch(value);
    return isValid ? null : "Campo inválido";
  }

}