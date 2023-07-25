part of 'number_trivia_bloc.dart';

abstract class NumberTriviaEvent extends Equatable {
  const NumberTriviaEvent();
}

class GetTriviaForConcreteNumber extends NumberTriviaEvent {
  ///Solid principles : Principle of single responsibility
  ///Should not be converting data
  /// event should be just passing data to the bloc and
  /// We should not put this logic inside ui
  /// int get number => int.parse(numberString);
  /// According to  the single the principle ui should display data
  /// and dispatch events they should not have any presentation logic
  /// inside of them even as simple presentation logic as this one of parsing an
  /// integer
  /// Never put any kind of logic inside classes where doesn't belong
  ///  //int get number => int.parse(numberString);
  //Text field get string thus we used numberString
  final String numberString;

  const GetTriviaForConcreteNumber(this.numberString);

  @override
  List<Object?> get props => [numberString];
}

class GetTriviaForRandomNumber extends NumberTriviaEvent {
  final String numberString;

  const GetTriviaForRandomNumber(this.numberString);
  @override
  List<Object?> get props => [numberString];
}
