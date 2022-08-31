import 'package:forum_devs_clean_architecture/ui/presentation/presenters/protocols/protocols.dart';
import 'package:forum_devs_clean_architecture/validations/validators/validators.dart';

Validation makeLoginValidation() {

  return ValidationComposite([
    RequiredFieldValidation('email'),
    EmailValidation('email'),
    RequiredFieldValidation('password')
  ]);

}