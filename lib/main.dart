import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/layout/social_app/cubit/cubit.dart';
import 'package:project/layout/social_app/social_layout.dart';
import 'package:project/shared/bloc_observer.dart';
import 'package:project/shared/components/constants.dart';
import 'package:project/shared/cubit/cubit.dart';
import 'package:project/shared/cubit/states.dart';
import 'package:project/shared/network/local/cache_helper.dart';
import 'package:project/shared/styles/themes.dart';
import 'modules/social_app/social-app_login_screen/social_app_login_screen.dart';
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  print(message.data.toString());

  Fluttertoast.showToast(
      msg: 'on Background Messaging App',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0
  );
}
void main() async
{
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var Token =  await FirebaseMessaging.instance.getToken();
  print("Device token");
  print(Token) ;
  FirebaseMessaging.onMessage.listen((event)
  {
    print(event.data.toString());

    Fluttertoast.showToast(
        msg: 'onMessage',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    print(event.data.toString());

    Fluttertoast.showToast(
        msg: 'on Message Opened App',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark') ;
  Widget widget ;

   uid = CacheHelper.getData(key: 'uid') ;

  if(uid != null)
    {
      widget = SocialLayout();
    }
  else
    {
      widget = SocialLoginScreen();
    }
  runApp
    (MyApp(isDark, widget,));
}
//stateless
//stateful

// class MyApp

class MyApp extends StatelessWidget
  {
      final bool? isDark ;
      final Widget startWidget ;

      MyApp(this.isDark , this.startWidget);

  @override
  Widget build(BuildContext context)  {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(create: (context) => AppCubit()..changeAppMode(fromShared: isDark),),
        BlocProvider(create: (context) => SocialCubit()..getUserData()..getPosts()),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state) {} ,
        builder: (context,state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit().get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }

}