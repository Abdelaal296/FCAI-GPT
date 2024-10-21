import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fcai_gpt/core/widgets/custom_button.dart';
import 'package:fcai_gpt/core/widgets/custom_flutter_toast.dart';
import 'package:fcai_gpt/core/widgets/custom_text_field.dart';
import 'package:fcai_gpt/features/chat/presentation/views/chat.dart';
import 'package:fcai_gpt/features/home/presentation/views/home.dart';
import 'package:fcai_gpt/features/login/presentation/view_models/login_cubit/cubit/login_cubit.dart';
import 'package:fcai_gpt/features/signUp/presentation/views/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var formkey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            showToast(text: "Login successfully", state: ToastStates.SUCCESS);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => const HomeScreen()));
          } else if (state is LoginError) {
            showToast(text: state.error, state: ToastStates.ERROR);
          }
        },
        builder: (context, state) {
          return Scaffold(
              body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Image.asset(
                      'assets/images/logo2.png',
                      width: 200,
                    ),
                    const Text(
                      'FCAI-GPT',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                          color: Colors.white,
                          fontFamily: 'Philosopher'),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Row(
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(fontSize: 24, color: Colors.white,fontFamily: 'Philosopher'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomTextField(
                      prefix: Icons.email_outlined,
                      controller: emailController,
                      hintText: 'Email',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      prefix: Icons.lock_outline,
                      obsecure: LoginCubit.get(context).isPassword,
                      controller: passwordController,
                      hintText: 'Password',
                      suffix: LoginCubit.get(context).suffix,
                      suffixPressed: () =>
                          LoginCubit.get(context).changeSuffix(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ConditionalBuilder(
                      condition: state is! LoginWithEmailAndPasswordLoading,
                      builder: (context) => CustomButton(
                        text: 'Login',
                        onTap: () {
                          if (formkey.currentState!.validate()) {
                            LoginCubit.get(context).signInWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text,
                            );
                          }
                        },
                      ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 155, 192, 232),)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ConditionalBuilder(
                      condition: state is! LoginWithGoogleLoading,
                      builder: (context) => MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: Color.fromARGB(255, 155, 192, 232),
                        height: 50,
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () {
                          LoginCubit.get(context).signInWithGoogle();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon(FontAwesomeIcons.google,color: Color.fromARGB(255, 21, 94, 134),),
                          Image.asset(
                        'assets/images/google2.png',
                        height: 40,
                      ),
                          const SizedBox(width: 10,),
                          const Text(
                            'Login with Google',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              fontFamily: 'Philosopher'
                            ),
                          )
                        ]),
                      ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 155, 192, 232),)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don\'t have an account ?',
                            style: TextStyle(color: Colors.white)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child: const Text('Sign Up',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 155, 192, 232),
                                  fontSize: 16)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
