import 'package:faker/faker.dart';
import 'package:forum_devs_clean_architecture/validations/validators/validators.dart';
import 'package:test/test.dart';

void main(){

  EmailValidation sut;

  setUp((){
    sut = EmailValidation('any_field');
  });

  test('Show return null if email is empty', (){
    final error = sut.validate('');

    expect(error, null);

  });

  test('Show return null if email is null', (){
    final error = sut.validate(null);

    expect(error, null);

  });

  test('Show return null if email is valid', (){
    final error = sut.validate(faker.internet.email());

    expect(error, null);

  });

  test('Show return error if email is inValid', (){
    final error = sut.validate("dion");

    expect(error, "Campo inválido");

  });


}