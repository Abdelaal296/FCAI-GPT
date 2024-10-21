import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());
  static SignUpCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
  }) async {
    emit(SignUpLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(SignUpSuccess());
    } on FirebaseAuthException catch (error) {
      emit(SignUpError(error.message.toString()));
    } catch (error) {
      emit(SignUpError(error.toString()));
    }
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changeSuffix() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SignUpChangeSuffix());
  }
}
