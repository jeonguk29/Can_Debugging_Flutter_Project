import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mbti_storage/Layout/WelcomeScreen.dart';
import 'package:mbti_storage/Layout/layout.dart';
import 'package:mbti_storage/shared/bloc/cubit.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch:Colors.deepOrange ,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: BlocProvider(
        create: (context) => appCubit(),
        child: WelcomeScreen(),
      ),
    );
  }
}


