import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/layout/social_app/social_layout.dart';
import 'package:project/modules/social_app/register/register_screen.dart';
import 'package:project/shared/components/components.dart';
import 'package:project/shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>() ;

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginState>(
        listener: (context , state)
        {
          if(state is SocialLoginErrorState)
            {
              Fluttertoast.showToast(msg: state.error);
            }
          if(state  is SocialLoginSuccessState)
            {
              CacheHelper.saveData(
                  key: 'uid',
                  value: state.uid,
              ).then((value) =>
              {
                navigatefisnh(context, SocialLayout()),
              }
              );
            }
        },
        builder: (context , state)
        {
            return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:
                        [
                          Image.asset('assets/images/undraw_Mobile_login_re_9ntv.png'),
                          Center(
                            child: Text(
                              'LOGIN',
                              style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.blue),
                            ),
                          ),
                          Center(
                            child: Text(
                              'login now to communicate with friends',
                              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),
                            ),
                          ),
                          SizedBox(
                            height: 30,),
                          defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String?value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'please enter your email address';
                              }
                            },
                            label: 'Email Address',
                            prefix: Icons.email_rounded,
                          ),
                          SizedBox(
                            height: 30,),
                          defaultFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: SocialLoginCubit.get(context).suffix,
                            onSubmit: (value)
                            {
                              if(formKey.currentState!.validate())
                              {
                                SocialLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                              }
                            },
                            isPassword: SocialLoginCubit.get(context).isPasswordShown,
                            suffixPressed: ()
                            {
                              SocialLoginCubit.get(context).ChangePasswordVisibility() ;
                            },
                            validate: (String?value)
                            {
                              if(value!.isEmpty)
                              {
                                return 'password is too short';
                              }
                            },
                            label: 'Password',
                            prefix: Icons.password_rounded,
                          ),
                          SizedBox(
                            height: 30,),
                          Conditional.single
                            (
                              context: context ,
                              conditionBuilder: (BuildContext  context) => state is! SocialLoginLoadingState ,
                              widgetBuilder: (context)
                              {
                                return defaultButton(
                                    function: ()
                                    {
                                      if(formKey.currentState!.validate())
                                      {
                                        SocialLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);
                                      }
                                    },
                                    text: 'Login',
                                    isUpperCase: true,
                                background: Colors.blue,
                                );
                              },
                              fallbackBuilder: (context)
                              {
                                return Center(child: CircularProgressIndicator()) ;
                              }
                          ),

                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                              [
                                SizedBox(
                                  height: 20,),
                                Text('Don\'t have an account?'),
                                defalutTextButton(
                                  function: ()
                                  {
                                    navigateTo(context,SocialRegisterScreen());
                                  },
                                  text: 'Register',
                                )
                              ]
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
        },
      ),
    );
  }
}
