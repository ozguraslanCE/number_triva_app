import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
@GenerateNiceMocks([MockSpec<NumberTriviaRepository>()])
import 'get_concrete_number_trivia_test.mocks.dart';
///Lose coupling ... FOR Testing -- Get-it



void main() {
  late GetConcreteNumberTrivia usecase;
  late MockNumberTriviaRepository mockNumberTriviaRepository;
  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
  });
  const int tNumber = 1;
  const tNumberTrivia = NumberTrivia(text: 'test', number: 1);
  test('should get trivia for the number from the repository', () async {
    //arrange
    when(mockNumberTriviaRepository.getConcreteNumberTrivia(1))
        .thenAnswer((final realInvocation) async => const Right(tNumberTrivia));
    //act
    final result = await usecase(const Params(number: tNumber));
    //assert
    expect(result, const Right(tNumberTrivia));
    verify(mockNumberTriviaRepository.getConcreteNumberTrivia(tNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
