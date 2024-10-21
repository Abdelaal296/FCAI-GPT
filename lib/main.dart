import 'package:fcai_gpt/constants.dart';
import 'package:fcai_gpt/core/utils/cache_helper.dart';
import 'package:fcai_gpt/features/Splash/presentation/views/splash_view.dart';
import 'package:fcai_gpt/features/home/presentation/views/home.dart';
import 'package:fcai_gpt/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fcai_gpt/core/utils/api_service.dart';
import 'package:flutter/material.dart';
import 'package:dcdg/dcdg.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  DioHelper.init();
  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FCAI-GPT',
      theme: ThemeData(
        scaffoldBackgroundColor: KPrimaryColor,
      ),
      home:  const SplashView(),
    );
  }
}

