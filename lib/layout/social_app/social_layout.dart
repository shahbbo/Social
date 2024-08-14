import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/layout/social_app/cubit/cubit.dart';
import 'package:project/layout/social_app/cubit/states.dart';
import 'package:project/modules/social_app/newPost/newPost_screen.dart';
import 'package:project/modules/social_app/search/SocialSearch.dart';
import 'package:project/shared/components/components.dart';
import 'package:project/shared/cubit/cubit.dart';
import 'package:project/shared/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   bool? isDark ;
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context, state)
      {
        if(state is SocialPostState)
          {
            navigateTo(context, NewPostScreen());
          }
      },
      builder: (context, state)
      {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.currentIndex],
            ),
            actions:
            [
              IconButton(onPressed: ()
              {
              }, icon: Icon(IconBroken.Notification)),
              IconButton(onPressed: ()
              {
                navigateTo(context,SocialSearch());
              }, icon: Icon(IconBroken.Search)),
              IconButton(
                onPressed: ()
              {
                AppCubit().get(context).changeAppMode(fromShared: isDark) ;
              },
                icon:  AppCubit().get(context).isDark ?  Icon(
      Icons.brightness_2
      ) : Icon(
                    Icons.brightness_2_outlined
                ) ,
              ),
            ],
          ),
          body:
          cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
              cubit.changeBottomnav(index);
            },
            currentIndex: cubit.currentIndex,
            items:
            [
              BottomNavigationBarItem(
                icon:  Icon(
                  IconBroken.Activity
                ),
                label: 'Feeds' ,
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat),
                label: 'Chats' ,
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Download),
                label: 'Post' ,
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.User1),
                label: 'Users' ,
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Setting),
                label: 'Settings' ,
              ),
            ],
          ),
        );
      },
    );
  }
}