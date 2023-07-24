import 'package:bloc/bloc.dart';

import 'event.dart';
import 'state.dart';

class Number_triviaBloc extends Bloc<Number_triviaEvent, Number_triviaState> {
  Number_triviaBloc() : super(Number_triviaState().init());

  @override
  Stream<Number_triviaState> mapEventToState(Number_triviaEvent event) async* {
    if (event is InitEvent) {
      yield await init();
    }
  }

  Future<Number_triviaState> init() async {
    return state.clone();
  }
}
