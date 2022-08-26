import 'package:forum_devs_clean_architecture/validations/validators/protocols/protocols.dart';

class RequiredFieldValidation implements FieldValidation {
  final String field;

  RequiredFieldValidation(this.field);

  String validate(String value) {

    return value?.isNotEmpty == true ? null : 'Campo obrigatório';
  }

}