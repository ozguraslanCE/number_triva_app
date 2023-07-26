import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/number_trivia_bloc.dart';

class TriviaControl extends StatefulWidget {
  const TriviaControl({
    super.key,
  });

  @override
  State<TriviaControl> createState() => _TriviaControlState();
}

class _TriviaControlState extends State<TriviaControl> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Text Field
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: 'Input a number',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (_) {
            dispatchConcrete();
          },
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: dispatchConcrete,
                child: const Text('Search'),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightGreen.shade200)),
                onPressed: dispatchRandom,
                child: const Text('Get random trivia'),
              ),
            ),
          ],
        )
      ],
    );
  }

  void dispatchConcrete() {
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(GetTriviaForConcreteNumber(controller.text));
    controller.clear();
  }

  void dispatchRandom() {
    BlocProvider.of<NumberTriviaBloc>(context)
        .add(const GetTriviaForRandomNumber());
    controller.clear();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<TextEditingController>('controller', controller),
    );
  }
}
