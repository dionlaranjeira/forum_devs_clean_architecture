import 'package:faker/faker.dart';
import 'package:forum_devs_clean_architecture/validations/validators/protocols/field_validation.dart';
import 'package:test/test.dart';

import 'package:faker/faker.dart';

class EmailValidation implements FieldValidation {
  final String field;

  EmailValidation(this.field);

  String validate(String){
    return null;
  }

}


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


}