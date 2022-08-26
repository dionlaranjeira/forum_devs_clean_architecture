import 'package:forum_devs_clean_architecture/validations/validators/validators.dart';
import 'package:test/test.dart';

void main(){

  RequiredFieldValidation sut;

  setUp((){
    sut = RequiredFieldValidation('any_field');
  });

  test('Show return null if value is not empty', (){
    final error = sut.validate('any_field');

    expect(error, null);
  });

  test('Show return error if value is empty', (){
    final error = sut.validate('');

    expect(error, 'Campo obrigatório');
  });

  test('Show return error if value is null', (){
    final error = sut.validate(null);

    expect(error, 'Campo obrigatório');
  });
  
}