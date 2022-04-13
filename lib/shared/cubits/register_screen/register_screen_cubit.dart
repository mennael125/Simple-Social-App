import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/modeles/user_model/user_model.dart';
import 'package:social/shared/constatnt/constant.dart';

import 'package:social/shared/cubits/register_screen/register_screen__states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

//is password visibility
  bool isPassword = true;

  IconData suffix = Icons.visibility;

  void passwordVisibility() {
    isPassword = !isPassword;

    suffix = isPassword ? Icons.visibility : Icons.visibility_off;
    emit(RegisterPasswordShowState());
  }

  //register fun firebase
  void registerFun(
      {required email, required password, required phone, required userName}) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      //to create user in fire store we call this method
      registerFunUserCreate(
        email: email,
        //get user uid
        uid:  value.user!.uid,
        phone: phone,
        userName: userName,

      );

      emit(RegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      print('-----------------------------');

      emit(RegisterErrorState(error));
    });
  }

  //register fun user create in fireStore
  void registerFunUserCreate(
      {required email, required uid, required phone, required userName }) {
    //create user mode
    UserModel model = UserModel(
        email: email,
        phone: phone,
        name: userName,
        image:
            'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?t=st=1649212840~exp=1649213440~hmac=9567d49b1f3f5f28dca9b7ca9bfb7bb745787eeb3efd16630b25bef6e9f1d646&w=740',
        cover:
            'https://img.freepik.com/free-vector/abstract-colorful-hand-painted-wallpaper_52683-61599.jpg?w=740',
        bio: 'Write your bio .....',
        uID: uid,
      // isEmailVerified: false,
        );

    emit(USerCreateLoadingState());
// to send data to fire store
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(model.toMap())
        .then((value) {
      emit(USerCreateSuccessState());
    }).catchError((error) {
      emit(USerCreateErrorState(error));
    });
  }
}
