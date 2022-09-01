import 'package:forum_devs_clean_architecture/main/builders/builders.dart';
import 'package:forum_devs_clean_architecture/ui/presentation/presenters/protocols/protocols.dart';
import 'package:forum_devs_clean_architecture/validations/validators/protocols/field_validation.dart';
import 'package:forum_devs_clean_architecture/validations/validators/validators.dart';

Validation makeLoginValidation() {

  return ValidationComposite(makeLoginValidations());

}

List <FieldValidation> makeLoginValidations(){
  return [
    ... ValidationBuilder.field('email').required().email().build(),
    ... ValidationBuilder.field('password').required().build(),
  ];
}