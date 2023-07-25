import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/error/failures.dart';
import '../../../core/util/input_converter.dart';
import '../../domain/entities/number_trivia.dart';
import '../../domain/usecases/get_concrete_number_trivia.dart';
import '../../domain/usecases/get_random_number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';
const String invalidInputFailureMessage =
    'Invalid Input - The Number must be a positive integer or zero  ';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;
  NumberTriviaBloc({
    required this.inputConverter,
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
  }) : super(const Empty()) {
    on<NumberTriviaEvent>(_onEvent);
  }

  FutureOr<void> _onEvent(
    NumberTriviaEvent event,
    Emitter<NumberTriviaState> emit,
  ) {
    if (event is GetTriviaForConcreteNumber) {
      emit(const Empty());
      inputConverter.stringToUnsignedInt(event.numberString).fold(
        (l) {
          emit(const Error(message: invalidInputFailureMessage));
        },
        (number) async {
          emit(const Loading());
          final failureOrTrivia =
              await getConcreteNumberTrivia(Params(number: number));
          failureOrTrivia.fold(
            (failure) {
              emit(Error(message: _mapFailureMessage(failure)));
            },
            (trivia) {
              emit(Loaded(trivia: trivia));
            },
          );
        },
      );
    }
  }

  String _mapFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }
}
