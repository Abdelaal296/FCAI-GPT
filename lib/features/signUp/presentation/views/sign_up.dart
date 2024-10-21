import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:fcai_gpt/core/widgets/custom_button.dart';
import 'package:fcai_gpt/core/widgets/custom_flutter_toast.dart';
import 'package:fcai_gpt/core/widgets/custom_text_field.dart';
import 'package:fcai_gpt/features/login/presentation/views/login_page.dart';
import 'package:fcai_gpt/features/signUp/presentation/view_models/cubit/sign_up_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  var formkey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if(state is SignUpSuccess){
            showToast(text: "Sign up completed", state: ToastStates.SUCCESS);
            Navigator.pop(context);
          }else if(state is SignUpError){
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
                    Image.asset('assets/images/logo2.png',width: 200,),
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
                          'Sign Up',
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
                      suffix: SignUpCubit.get(context).suffix,
                      suffixPressed:()=> SignUpCubit.get(context).changeSuffix(),
                      obsecure: SignUpCubit.get(context).isPassword,
                      controller: passwordController,
                      hintText: 'Password',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ConditionalBuilder(
                      condition: state is! SignUpLoading ,
                      builder: (context)=>CustomButton(
                        text: 'Sign Up',
                        onTap: () {
                          if (formkey.currentState!.validate()) {
                            SignUpCubit.get(context).userRegister(
                              email: emailController.text.toString().trim(),
                               password: passwordController.text.toString(),
                               );
                          }
                        },
                      ),
                      fallback: (context)=>const Center(child: CircularProgressIndicator()) ,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account ?',
                            style: TextStyle(color: Colors.white)),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: const Text('Login',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 155, 192, 232), fontSize: 16)),
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
