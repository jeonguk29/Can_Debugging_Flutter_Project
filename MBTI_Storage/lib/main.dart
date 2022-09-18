import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:mbti_storage/Layout/WelcomeScreen.dart';
import 'package:mbti_storage/Layout/layout.dart';
import 'package:mbti_storage/shared/bloc/cubit.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> main() async {
  KakaoSdk.init(nativeAppKey: 'fd4de13a72c8b70ef6a69ee1f599e3da');
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
        fontFamily: 'RoundWind',
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: BlocProvider(
        create: (context) => appCubit(),
        child: WelcomeScreen(),
      ),
    );
  }
}


