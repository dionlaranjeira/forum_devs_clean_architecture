import 'package:test/test.dart';

abstract class FieldValidation{
  String get field;
  String validate(String value);
}

class RequiredFieldValidation implements FieldValidation {
  final String field;

  RequiredFieldValidation(this.field);

  String validate(String value) {
    return value.isEmpty ? 'Campo obrigatório' : null;
  }
  
}

void main(){

  RequiredFieldValidation sut;

  setUp((){
    sut = RequiredFieldValidation('any_field');
  });

  test('Show return null if value is not empty', (){
    final error = sut.validate('any_field');

    expect(error, null);
  });

  test('Show return error if value is not empty', (){
    final error = sut.validate('');

    expect(error, 'Campo obrigatório');
  });
  
  
}