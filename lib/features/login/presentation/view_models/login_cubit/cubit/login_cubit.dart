import 'package:bloc/bloc.dart';
import 'package:fcai_gpt/core/utils/cache_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);

  void signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(LoginWithEmailAndPasswordLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );


      // preferences.setString("email", FirebaseAuth.instance.currentUser!.uid);
      
      CacheHelper.putData(key: 'email', value:  FirebaseAuth.instance.currentUser!.email!);

      emit(LoginSuccess());
    } on FirebaseAuthException catch (error) {
      emit(LoginError(error.message.toString()));
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }

  void signInWithGoogle() async {
    emit(LoginWithGoogleLoading());
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      CacheHelper.putData(key: 'email', value:  FirebaseAuth.instance.currentUser!.email!);

      emit(LoginSuccess());
    } catch (error) {
      emit(LoginError(error.toString()));
    }
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changeSuffix() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangeSuffix());
  }
}
