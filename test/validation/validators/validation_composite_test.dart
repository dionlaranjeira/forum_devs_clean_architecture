import 'package:flutter/cupertino.dart';
import 'package:forum_devs_clean_architecture/ui/presentation/presenters/protocols/protocols.dart';
import 'package:forum_devs_clean_architecture/validations/validators/protocols/field_validation.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);

  @override
  String validate({@required String field, @required String value}) {

    String error;

    for(final validation in validations.where((element) => element.field == field)){
      error = validation.validate(value);

      if(error?.isNotEmpty == true){
        return error;
      }

    }

    return error;

  }
}

class FieldValidationSpy extends Mock implements FieldValidation{

}

void main(){

  ValidationComposite sut;
  FieldValidationSpy validation1;
  FieldValidationSpy validation2;
  FieldValidationSpy validation3;

  void mockValidation1(String error){
    when(validation1.validate(any)).thenReturn(error);
  }

  void mockValidation2(String error){
    when(validation2.validate(any)).thenReturn(error);
  }

  void mockValidation3(String error){
    when(validation3.validate(any)).thenReturn(error);
  }


  setUp((){
    validation1 = FieldValidationSpy();
    validation2 = FieldValidationSpy();
    validation3 = FieldValidationSpy();

    when(validation1.field).thenReturn('other_field');

    mockValidation1(null);

    when(validation2.field).thenReturn('any_field');
    mockValidation2(null);

    when(validation3.field).thenReturn('any_field');
    mockValidation3(null);

    sut= ValidationComposite([validation1, validation2, validation3]);
  });

  test('Should return null if all validations returns null or empty', (){
    mockValidation2('');

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);

  });

  test('Should return the first error of the field', (){
    mockValidation1('error_1');
    mockValidation2('error_2');
    mockValidation3('error_3');

    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, 'error_2');
  });


}
