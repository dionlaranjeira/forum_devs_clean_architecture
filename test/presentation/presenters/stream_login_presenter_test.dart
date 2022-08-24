import 'package:faker/faker.dart';
import 'package:forum_devs_clean_architecture/ui/presentation/presenters/presenters.dart';
import 'package:forum_devs_clean_architecture/ui/presentation/presenters/protocols/protocols.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class ValidationSpy extends Mock implements Validation{}


void main(){
  StreamLoginPresenter sut;
  ValidationSpy validation;
  String email;

  PostExpectation mockValidationCall(String fiel) =>
      when(validation.validate(field: fiel == null ? anyNamed('field'):fiel, value: anyNamed('value')));

  void mockValidation({String field, String value}){
    mockValidationCall(field).thenReturn(value);
  }

  setUp((){
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    mockValidation();
  });

  test('Should call Validation with correct email', (){

    sut.validateEmail(email);
    verify(validation.validate(field: 'email', value: email)).called(1);
    
  });

  test('Should emit email error if validation fails', (){
    mockValidation(value: 'error');

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'error')));

    sut.validateEmail(email);
    sut.validateEmail(email);

  });

}