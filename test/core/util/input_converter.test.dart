import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia_app/features/core/util/input_converter.dart';

void main() {
  late InputConverter inputConverter;
  setUp(() {
    inputConverter = InputConverter();
  });
  group('stringToUnsignedInt', () {
    test(
        'should return an integer when '
        'the string represents an unsigned integer ', () async {
      //arrange
      const str = '12';
      //act
      final result = inputConverter.stringToUnsignedInt(str);
      //assert
      expect(result, const Right(12));
    });
    test(
        'should return a Failure when '
        'the string is not an integer ', () async {
      //arrange
      const str = 'abc12'; //1.0 same
      //act
      final result = inputConverter.stringToUnsignedInt(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
    test(
        'should return a Failure when '
        'the string is negative integer ', () async {
      //arrange
      const str = '-12'; //1.0 same
      //act
      final result = inputConverter.stringToUnsignedInt(str);
      //assert
      expect(result, Left(InvalidInputFailure()));
    });
  });
}
