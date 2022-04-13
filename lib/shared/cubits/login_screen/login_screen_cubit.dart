import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_screen__states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(ShopAppInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

//is pass fun visibility
  bool isPassword = true;

  IconData suffix = Icons.visibility;

  void passwordVisibility() {
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(ShopAppPasswordShowState());
  }

  //login fun firebase
  Future<UserCredential?> loginFun({required email, required password}) async {
    emit(LoginLoadingState());

    try {
     await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
// to receive user uid
        emit(LoginSuccessState(value.user!.uid));
      }).catchError((error) {
        emit(LoginErrorState(error));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        emit(LoginErrorState(e.toString()));

      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        emit(LoginErrorState(e.toString()));

      }
    } catch (e) {
      print(e);
    }
  }}