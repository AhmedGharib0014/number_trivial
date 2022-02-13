import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:number_trivial/dependency_container.dart';
import 'package:number_trivial/features/numbertrivial/presentatoion/pages/number_trivial_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  GetIt.I.isReady<SharedPreferences>().then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Trivia',
      theme: ThemeData(
        primaryColor: Colors.green.shade800,
      ),
      home: NumberTrivialPage(),
    );
  }
}
