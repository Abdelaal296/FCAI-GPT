import 'package:fcai_gpt/constants.dart';
import 'package:fcai_gpt/core/utils/cache_helper.dart';
import 'package:fcai_gpt/core/widgets/custom_flutter_toast.dart';
import 'package:fcai_gpt/features/courses/presentation/views/courses.dart';
import 'package:fcai_gpt/features/chat/presentation/views/chat.dart';
import 'package:fcai_gpt/features/home/presentation/views/widgets/chat_container.dart';
import 'package:fcai_gpt/features/home/presentation/views/widgets/recommend_courses_container.dart';
import 'package:fcai_gpt/features/login/presentation/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: KPrimaryColor,
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () async {
              try {
                await FirebaseAuth.instance.signOut();
                await CacheHelper.removeData(key: 'email');
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              } catch (error) {
                showToast(text: "Error signing out: $error", state: ToastStates.ERROR);
              }
            },
            child: const Row(
              children: [
                Text(
                  'Logout',
                  style: TextStyle(
                      fontFamily: 'Philosopher',
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
        title: const Text(
          'Home',
          style: TextStyle(
              fontFamily: 'Philosopher',
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Color.fromARGB(255, 155, 192, 232)
            ], 
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0.05, 1.5],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/FCAILOGO.png',
                      height: 180,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Welcome to FCAI-GPT',
                      style: TextStyle(
                          fontFamily: 'Philosopher',
                          fontWeight: FontWeight.bold,
                          fontSize: 26),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Academic advisor chatbot for students',
                      style: TextStyle(
                          fontFamily: 'Philosopher',
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const Text(
                      'in the faculty of computers and artificial',
                      style: TextStyle(
                          fontFamily: 'Philosopher',
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const Text(
                      'intelligence at Cairo University to help',
                      style: TextStyle(
                          fontFamily: 'Philosopher',
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                    const Text(
                      'in their journey in college.',
                      style: TextStyle(
                          fontFamily: 'Philosopher',
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const ChatContainer(),
              const SizedBox(
                height: 20,
              ),
              const RecommendCoursesContainer(),
            ],
          ),
        ),
      ),
    );
  }
}

