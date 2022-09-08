import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_thoughts/bloc/tasks_bloc.dart';
import 'package:my_thoughts/pages/home/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JIGI Challenge', // Done by Assylzhan
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF333333),
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => TasksBloc(repo: Repo()),
        child: const MainPage(),
      ),
    );
  }
}
