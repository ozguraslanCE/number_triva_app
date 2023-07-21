import '../../../core/error/exceptions.dart';
import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  ///Calls the http://numbersapi.com/{number} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getConcreteNumberTrivia(
    final int number,
  );

  ///Calls the http://numbersapi.com/random endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<NumberTriviaModel> getRandomNumberTrivia();
}
