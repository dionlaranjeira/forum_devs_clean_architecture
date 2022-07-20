import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../lib/data/http/http.dart';
import '../../../lib/data/usecases/usecases.dart';
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
}