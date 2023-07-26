import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../bloc/number_trivia_bloc.dart';
import '../widgets/loading_widget.dart';
import '../widgets/message_display.dart';
import '../widgets/trivia_controls.dart';
import '../widgets/trivia_display.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Trivia Text'),
      ),
      body: buildBody(context),
    );
  }

  SingleChildScrollView buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: BlocProvider(
        create: (_) => sl<NumberTriviaBloc>(),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              //Top half
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return const MessageDisplay(message: 'Start Searching');
                  }
                  if (state is Error) {
                    return MessageDisplay(message: state.message);
                  }
                  if (state is Loading) {
                    return const LoadingWidget();
                  }
                  if (state is Loaded) {
                    return TriviaDisplay(numberTrivia: state.trivia);
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 20),
              //Bottom Half
              const TriviaControl(),
            ],
          ),
        ),
      ),
    );
  }
}
