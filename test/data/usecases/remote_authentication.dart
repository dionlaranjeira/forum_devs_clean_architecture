import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../lib/data/http/http.dart';
import '../../../lib/data/usecases/usecases.dart';
import '../../../lib/domain/helpers/helpers.dart';
import '../../../lib/domain/usecases/authentication.dart';


class HttpClientSpy extends Mock implements HttpClient{}

void main(){
  HttpClientSpy httpClient;
  String url;
  RemoteAuthentication sut;

  setUp((){
    httpClient = HttpClientSpy();
    url = faker.internet.httpsUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });

  test('Should call HttpClient with correct values', () async {
    final params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());
    await sut.auth(params);

    verify(httpClient.request(
        url: url,
        method: 'post',
        body: {"email": params.email, "password": params.password}
    ));

  });

  test('Should throw unexpectedError if HttpClient returns 400', () async {

    when(httpClient.request(url: anyNamed('url'), method: anyNamed('method'), body: anyNamed('body')))
    .thenThrow(HttpError.badRequest);


    final params = AuthenticationParams(email: faker.internet.email(), password: faker.internet.password());
    final future = sut.auth(params);

    expect(future, throwsA(DomainError.unexpected));

  });

}