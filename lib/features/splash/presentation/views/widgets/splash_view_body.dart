import 'package:fcai_gpt/constants.dart';
import 'package:fcai_gpt/core/utils/cache_helper.dart';
import 'package:fcai_gpt/features/home/presentation/views/home.dart';
import 'package:fcai_gpt/features/login/presentation/views/login_page.dart';
import 'package:flutter/material.dart';

import 'sliding_text.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAniimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    navigateToHome();
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset('assets/images/logo2.png'),
        SlidingText(slidingAniimation: slidingAniimation),
      ],
    );
  }

  void initSlidingAnimation() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    slidingAniimation =
        Tween<Offset>(begin: const Offset(0, 8), end: Offset.zero)
            .animate(animationController);
    animationController.forward();
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 2), () async {
      email = CacheHelper.getData(key: 'email');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => email==null ?LoginScreen():const HomeScreen()));
    });
  }
}
