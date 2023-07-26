import 'package:flutter/material.dart';

import 'features/number_trivia/presentation/pages/number_trivia_page.dart';
import 'injection_container.dart' as di; //Dependency Injection

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
          colorScheme: ColorScheme(
              primary: Colors.green.shade50,
              brightness: Brightness.light,
              onPrimary: Colors.green.shade800,
              secondary: Colors.red.shade800,
              onSecondary: Colors.green.shade800,
              error: Colors.green.shade800,
              onError: Colors.green.shade800,
              background: Colors.green.shade800,
              onBackground: Colors.green.shade800,
              surface: Colors.green.shade800,
              onSurface: Colors.green.shade800)),
      home: const NumberTriviaPage(),
    );
  }
}
