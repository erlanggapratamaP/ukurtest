import 'package:dio/dio.dart';
import 'package:fake_json/data/data.dart';
import 'package:fake_json/presentation/bloc/user_bloc.dart';
import 'package:fake_json/presentation/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  var dio = Dio();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ukur User',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => UserBloc(UserRepository(dio: dio)),
        child: const UserPage(),
      ),
    );
  }
}
