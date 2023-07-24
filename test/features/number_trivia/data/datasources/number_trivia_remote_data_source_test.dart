import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/features/core/error/exceptions.dart';
import 'package:number_trivia_app/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:number_trivia_app/features/number_trivia/data/models/number_trivia_model.dart';

import '../../../../fixtures/fixture_reader.dart';
@GenerateNiceMocks([MockSpec<http.Client>()])
import 'number_trivia_remote_data_source_test.mocks.dart';

void main() {
  late NumberTriviaRemoteDataSourceImpl dataSource;
  late MockClient mockClient;
  setUp(() {
    mockClient = MockClient();
    dataSource = NumberTriviaRemoteDataSourceImpl(client: mockClient);
  });
  void setUpMockHttpClientSuccess200() {
    when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(fixture('trivia.json'), 200),
    );
  }

  void setUpMockHttpClientFailure404() {
    when(mockClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response('Something went wrong', 404),
    );
  }

  group('getConcreteNumberTrivia', () {
    const tNumber = 1;
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('''
         should perform a Get request on a url with number 
         being the endpoint and with application/json header ''', () async {
      //arrange
      setUpMockHttpClientSuccess200();
      //act
      await dataSource.getConcreteNumberTrivia(tNumber);
      //assert
      final Uri uri = Uri.parse('http://numbersapi.com/$tNumber');
      verify(
        mockClient.get(uri, headers: {'Content-Type': 'application/json'}),
      );
    });
    test('should  return NumberTrivia when the response code is 200(success)',
        () async {
      //arrange
      setUpMockHttpClientSuccess200();
      //act
      final result = await dataSource.getConcreteNumberTrivia(tNumber);
      //assert
      expect(result, equals(tNumberTriviaModel));
    });
    test(
        'should  return a ServerException '
        'when the response code is 404(success)', () async {
      //arrange
      setUpMockHttpClientFailure404();
      //act
      final call = dataSource.getConcreteNumberTrivia;
      //assert
      expect(call(tNumber), throwsA(const TypeMatcher<ServerException>()));
    });
  });
  group('getRandomNumberTrivia', () {
    final tNumberTriviaModel =
        NumberTriviaModel.fromJson(json.decode(fixture('trivia.json')));

    test('''
         should perform a Get request on a url with number 
         being the endpoint and with application/json header ''', () async {
      //arrange
      setUpMockHttpClientSuccess200();
      //act
      await dataSource.getRandomNumberTrivia();
      //assert
      final Uri uri = Uri.parse('http://numbersapi.com/random');
      verify(
        mockClient.get(uri, headers: {'Content-Type': 'application/json'}),
      );
    });
    test('should  return NumberTrivia when the response code is 200(success)',
        () async {
      //arrange
      setUpMockHttpClientSuccess200();
      //act
      final result = await dataSource.getRandomNumberTrivia();
      //assert
      expect(result, equals(tNumberTriviaModel));
    });
    test(
        'should  return a ServerException '
        'when the response code is 404(success)', () async {
      //arrange
      setUpMockHttpClientFailure404();
      //act
      final call = dataSource.getRandomNumberTrivia;
      //assert
      expect(call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
