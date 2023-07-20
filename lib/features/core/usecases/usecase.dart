import 'package:dartz/dartz.dart';
import '../error/failures.dart';

///Avoid defining a one-member abstract class when a simple function will do.
///usecase should always have a call method

abstract class UseCase<Type, Params>{

  Future <Either<Failure,Type>> call(final Params params);
}

class NoParams{}