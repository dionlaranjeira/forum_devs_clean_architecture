import 'package:forum_devs_clean_architecture/ui/presentation/presenters/protocols/protocols.dart';
import 'package:forum_devs_clean_architecture/validations/validators/protocols/field_validation.dart';
import 'package:forum_devs_clean_architecture/validations/validators/validators.dart';

Validation makeLoginValidation() {

  return ValidationComposite(makeLoginValidations());

}

List <FieldValidation> makeLoginValidations(){
  return [
    RequiredFieldValidation('email'),
    EmailValidation('email'),
    RequiredFieldValidation('password')
  ];
}