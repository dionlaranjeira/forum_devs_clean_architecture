import 'package:forum_devs_clean_architecture/main/factories/factories.dart';
import 'package:forum_devs_clean_architecture/validations/validators/validators.dart';
import 'package:test/test.dart';

void main(){
  
  test('Should return the correct validations', (){
    final validations = makeLoginValidations();

    expect(validations, [
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password')
    ]);

  });
  
}