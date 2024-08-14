import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/models/social_app/social_usermdoel.dart';
import 'package:project/modules/social_app/register/cubit/state.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterState> {

  SocialRegisterCubit(): super(SocialRegisterInitialState()) ;

  static SocialRegisterCubit get(context) => BlocProvider.of(context) ;

  void userlogin({
    required String name ,
    required String email,
    required String password,
    required String phone ,
  }) {
    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword
      (
        email: email,
        password: password,
      
    ).then((value) {
      userCreate
          (
            phone: phone,
            name: name ,
            uid: value.user!.uid,
            email: email
          );
    }).catchError((error)
    {
      emit(SocialRegisterErrorState(error.toString()));
    }
    );
  }

  void userCreate({
    required String name ,
    required String email,
    required String uid ,
    required String phone ,

  }) {
    SocialUserModel us  = SocialUserModel
      (name: name,
      email: email,
      phone: phone,
      uid: uid,
      bio: 'Write you bio.... ',
      image: 'https://image.freepik.com/free-photo/man-jumping-neon-are-you-ready-sign_23-2149074277.jpg',
      cover: 'https://image.freepik.com/free-photo/close-up-young-woman-hiding-her-face-with-yellow-ballon-against-gray-wall-color-trends-2021-positive-concept_101125-1917.jpg',
      isEmailVerified: false,
    );
    FirebaseFirestore.instance.
    collection('users')
        .doc(uid)
        .set(us.toMap()
    ).then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error)
    {
      emit(SocialCreateUserErrorState(error.toString()));
      print(error.toString());
    });
  }
  IconData suffix = Icons.visibility_outlined ;
  bool isPasswordShown = true ;

  void ChangePasswordVisibility() {
    isPasswordShown = !isPasswordShown ;
    suffix =   isPasswordShown ?  Icons.visibility_outlined  : Icons.visibility_off_outlined ;

    emit(SocialRegisterChangePasswordVisibilityState());

  }
}