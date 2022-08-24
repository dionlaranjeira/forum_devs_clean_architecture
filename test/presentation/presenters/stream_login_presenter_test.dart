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
  String password;

  PostExpectation mockValidationCall(String fiel) =>
      when(validation.validate(field: fiel == null ? anyNamed('field'):fiel, value: anyNamed('value')));

  void mockValidation({String field, String value}){
    mockValidationCall(field).thenReturn(value);
  }

  setUp((){
    validation = ValidationSpy();
    sut = StreamLoginPresenter(validation: validation);
    email = faker.internet.email();
    password = faker.internet.password();
    mockValidation();
  });

  test('Should call Validation with correct email', (){

    sut.validateEmail(email);
    verify(validation.validate(field: 'email', value: email)).called(1);
    
  });

  test('Should emit email error if validation fails', (){
    mockValidation(value: 'error');

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);

  });


  test('Should emit null if validation suceeds', (){
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateEmail(email);
    sut.validateEmail(email);

  });

  test('Should call Validation with correct password', (){

    sut.validatePassword(password);
    verify(validation.validate(field: 'password', value: password)).called(1);

  });

  test('Should emit password error if validation fails', (){
    mockValidation(value: 'error');

    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, 'error')));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);

  });

  test('Should emit null if password valid', (){

    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.isFormValidStream.listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validatePassword(password);
    sut.validatePassword(password);

  });

  test('Should emits form valid event if form is valid', () async {

    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));
    sut.passwordErrorStream.listen(expectAsync1((error) => expect(error, null)));
    
    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));
    
    sut.validateEmail(email);
    await Future.delayed(Duration.zero);
    sut.validatePassword(password);

  });



}