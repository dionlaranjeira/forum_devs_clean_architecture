import 'package:forum_devs_clean_architecture/validations/validators/protocols/field_validation.dart';
import 'package:test/test.dart';


class EmailValidation implements FieldValidation {
  final String field;

  EmailValidation(this.field);

  String validate(String){
    return null;
  }

}


void main(){

  test('Show return null if email is empty', (){
    final sut = EmailValidation('any_field');
    
    final error = sut.validate('');

    expect(error, null);

  });

  test('Show return null if email is empty', (){
    final sut = EmailValidation('any_field');

    final error = sut.validate(null);

    expect(error, null);

  });


}