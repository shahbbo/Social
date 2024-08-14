import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:project/layout/social_app/social_layout.dart';
import 'package:project/shared/components/components.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';

class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>() ;

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterState>(
        listener:(context,state)
        {
         if(state is SocialCreateUserSuccessState)
           {
             navigatefisnh(context, SocialLayout());
           }
        },
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(),
            body:  Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text(
                          'Register',
                          style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black),
                        ),
                        Text(
                          'Register now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,),
                        defaultFormField(
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String?value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'please enter your name ';
                            }
                          },
                          label: 'USER NAME',
                          prefix: Icons.drive_file_rename_outline,
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
                          suffix: SocialRegisterCubit.get(context).suffix,
                          onSubmit: (value)
                          {
                            if(formKey.currentState!.validate())
                            {
                              SocialRegisterCubit.get(context).userlogin(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text,);
                            }
                          },
                          isPassword: SocialRegisterCubit.get(context).isPasswordShown,
                          suffixPressed: ()
                          {
                            SocialRegisterCubit.get(context).ChangePasswordVisibility() ;
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
                        defaultFormField(
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String?value)
                          {
                            if(value!.isEmpty)
                            {
                              return 'please enter your PHONE';
                            }
                          },
                          label: 'PHONE',
                          prefix: Icons.phone,
                        ),
                        SizedBox(
                          height: 30,),
                        Conditional.single
                          (
                            context: context ,
                            conditionBuilder: (context) => state is! SocialRegisterLoadingState ,
                            widgetBuilder: (context)
                            {
                              return defaultButton(
                                  function: ()
                                  {
                                    if(formKey.currentState!.validate())
                                    {
                                      SocialRegisterCubit.get(context).userlogin(
                                        name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                        phone: phoneController.text,
                                      );
                                    }
                                  },
                                  text: 'register',
                                  isUpperCase: true);
                            },
                            fallbackBuilder: (context)
                            {
                              return Center(child: CircularProgressIndicator()) ;
                            }
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
