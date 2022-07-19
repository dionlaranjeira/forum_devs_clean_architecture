import 'package:forum_devs_clean_architecture/domain/helpers/helpers.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:faker/faker.dart';

import 'package:forum_devs_clean_architecture/domain/usecases/usecases.dart';
import 'package:forum_devs_clean_architecture/data/usecases/usecases.dart';
import 'package:forum_devs_clean_architecture/data/http/http.dart';

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  late RemoteAuthentication sut;
  late HttpClientSpy httpClient;
  late String url;
  late AuthenticationParams params;

  Map mockValidData() => {'acesssToken': faker.guid.guid(), 'name':faker.person.name()};

  PostExpectation _mockRequest() =>
      when(httpClient.request(
          url: anyNamed('url'),
          method: anyNamed('method'),
          body: anyNamed('body')));

  void mockHttpData(Map data){
    _mockRequest().thenAnswer((_) async => data);
  }

  void mockHttpError(HttpError error){
    _mockRequest().thenThrow(error);
  }

  setUp((){
    httpClient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
    params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());
    mockHttpData(mockValidData());
  });

  test('Should call HttpClient with correct values', () async {
    await sut.auth(params);

    verify(httpClient.request(
        url: url,
        method: 'post',
        body: {"email": params.email, "password": params.password}
    ));
  });

  test('Should throw UnexpectedError if HttpClient returns 400', () async {

    mockHttpError(HttpError.badRequest);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 404', () async {

    mockHttpError(HttpError.notFound);


    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw UnexpectedError if HttpClient returns 500', () async {

    mockHttpError(HttpError.serverError);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));
  });

  test('Should throw InvalidCredentialsError if HttpClient returns 401', () async {

    mockHttpError(HttpError.unauthorized);

    final future = sut.auth(params);

    expect(future, throwsA(DomainError.invalidCredentials));
  });


  test('Should return an Account if HttpClient returns 200', () async {

    final validData = mockValidData();
    mockHttpData(validData);

    final acount = await sut.auth(params);

    expect(acount!.token, validData['acessToken']);
  });

  test('Should return an Account if HttpClient returns 200 with invalid data', () async {

    mockHttpData({'invalid_key': 'invalid_value'});

      final future = sut.auth(params);

      expect(future, throwsA(DomainError.unexpected));
  });


}