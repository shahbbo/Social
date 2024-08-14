import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/modules/social_app/social-app_login_screen/cubit/state.dart';

class SocialLoginCubit extends Cubit<SocialLoginState>
{
  SocialLoginCubit(): super(SocialLoginInitialState()) ;

  static SocialLoginCubit get(context) => BlocProvider.of(context) ;

  void userLogin({
  required String email,
    required String password,
})

  {
    emit(SocialLoginLoadingState());

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value)
    {
      emit(SocialLoginSuccessState(value.user!.uid));
    }).catchError((error)
        {
          emit(SocialLoginErrorState(error.toString()));
        }
    );
  }

  IconData suffix = Icons.visibility_outlined ;
  bool isPasswordShown = true ;
  void ChangePasswordVisibility()
  {
    isPasswordShown = !isPasswordShown ;
    suffix =   isPasswordShown ?  Icons.visibility_outlined  : Icons.visibility_off_outlined ;

    emit(SocialChangePasswordVisibilityState());

  }
}