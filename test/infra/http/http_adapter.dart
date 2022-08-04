import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';

import 'package:forum_devs_clean_architecture/data/http/http.dart';
import 'package:forum_devs_clean_architecture/infra/http/http.dart';


class ClientSpy extends Mock implements Client{

}

void main(){
  HttpAdapter sut;
  ClientSpy client;
  String url;

  setUp((){
    client = ClientSpy();
    sut = HttpAdapter(client);
    url = faker.internet.httpUrl();
  });

  group('shared', (){
    test('Should throw ServerError if invalid method is provides', () async {

      final future = sut.request(url: url, method: "invalid_method");

      expect(future, throwsA(HttpError.serverError));

    });
  });

  group('post', (){

    PostExpectation mockRequest() => when(client.post(any, body: anyNamed('body'), headers: anyNamed('headers')));

    void mockResponse(int statusCode, {String body = '{"any_key":"any_value"}'}){
      mockRequest()..thenAnswer((_) async => Response(body, statusCode));
    }

    void mockError(){
      mockRequest().thenThrow(Exception);
    }

    setUp((){
      mockResponse(200);
    });

    test('Should call post with corrects values', () async {

      await sut.request(url: url, method: "post", body: {"any_key": "any_value"});

      verify(client.post(
          Uri.parse(url),
          headers: {
            "content-type": "application/json",
            "accept": "application/json"
          },
          body: '{"any_key":"any_value"}'
      ));

    });

    test('Should call post without body', () async {

      await sut.request(url: url, method: "post");

      verify(client.post(
          any,
          headers: anyNamed('headers'),
      ));

    });

    test('Should return data if status code 200', () async {

      final response = await sut.request(url: url, method: "post");

      expect(response,{'any_key':'any_value'});

    });

    test('Should return null if status code 200 without data', () async {
      mockResponse(200, body:'');
      
      final response = await sut.request(url: url, method: "post");

      expect(response,null);

    });

    test('Should return null if status code 204', () async {
      mockResponse(204, body:'');

      final response = await sut.request(url: url, method: "post");

      expect(response,null);

    });

    test('Should return null if status code 204 and body contains data', () async {
      mockResponse(204);

      final response = await sut.request(url: url, method: "post");

      expect(response,null);

    });

    test('Should return BadRequestError if status code 400', () async {
      mockResponse(400);

      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(HttpError.badRequest));

    });

    test('Should return BadRequestError if status code 400', () async {
      mockResponse(400, body: '');

      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(HttpError.badRequest));

    });

    test('Should return ServerError if status code 500', () async {
      mockResponse(500);

      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(HttpError.serverError));

    });

    test('Should return Unauthorized if status code 401', () async {
      mockResponse(401);

      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(HttpError.unauthorized));

    });

    test('Should return Forbidden Error if status code 403', () async {
      mockResponse(403);

      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(HttpError.forbidden));

    });

    test('Should return Not found Error if status code 404', () async {
      mockResponse(404);

      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(HttpError.notFound));

    });

    test('Should return Server error if post throws', () async {
      mockError();

      final future = sut.request(url: url, method: "post");

      expect(future, throwsA(HttpError.serverError));

    });

  });

}

