import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia_app/features/number_trivia/domain/usecases/get_concreate_number_trivia.dart';

///TODO:Lose coupling ... FOR Testing

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  GetConcreteNumberTrivia? usecase;
  MockNumberTriviaRepository? mockNumberTriviaRepository;
  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository!);
  });
  const int tNumber = 1;
  const tNumberTrivia = NumberTrivia(text: 'test', number: 1);
  test('should get trivia for the number from the repository', () async {
    //arrange
    when(mockNumberTriviaRepository?.getConcreteNumberTrivia(1))
        .thenAnswer((realInvocation) async => const Right(tNumberTrivia));
    //act
    final result = await usecase!(const Params(number: tNumber));
    //assert
    expect(result, const Right(tNumberTrivia));
    verify(mockNumberTriviaRepository?.getConcreteNumberTrivia(tNumber));
    verifyNoMoreInteractions(mockNumberTriviaRepository);
  });
}
