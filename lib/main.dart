import 'package:fake_json/presentation/pages/user_page.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //check connection
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ukur User',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: isLoading
          ? const Scaffold(
              body: Center(
                  child: CircularProgressIndicator(
                color: Colors.blue,
              )),
            )
          : const UserPage(),
    );
  }
}
