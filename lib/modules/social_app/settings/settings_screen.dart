import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/layout/social_app/cubit/cubit.dart';
import 'package:project/layout/social_app/cubit/states.dart';
import 'package:project/modules/social_app/edit_profile/edit_profile.dart';
import 'package:project/shared/components/components.dart';
import 'package:project/shared/components/constants.dart';
import 'package:project/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {} ,
      builder: (context, state)
      {
        var  userModel = SocialCubit.get(context).model;
        return  Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children:
            [
              Container(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children:
                  [
                    Align(
                      child: Container(
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                          image: DecorationImage(
                            image: NetworkImage('${userModel!.cover}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      alignment: AlignmentDirectional.topCenter,
                    ),
                    CircleAvatar(
                      radius: 55,
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            '${userModel.image}',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                '${userModel.name}',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                '${userModel.bio}',
                style: Theme.of(context).textTheme.caption,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Row(
                  children:
                  [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children:
                          [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Posts',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children:
                          [
                            Text(
                              '25',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Photos',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children:
                          [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Followers',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children:
                          [
                            Text(
                              '100',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                            Text(
                              'Following',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                        onTap: (){},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children:
                [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: (){},
                      child: Text(
                        'Add photos',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  OutlinedButton(
                    onPressed: ()
                    {
                      navigateTo(context, EditProfileScreen());
                    },
                    child: Icon(
                      IconBroken.Edit_Square,
                      size: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              defaultButton(function: ()
              {
                sinout(context);
              }
                  , text: 'LOGOUT'),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    OutlinedButton(
                      onPressed: ()
                      {
                        FirebaseMessaging.instance.subscribeToTopic('announcements');
                      },
                      child: Text(
                        'Subscribe',
                      ),),
                    SizedBox(
                      width: 20,
                    ),
                    OutlinedButton(
                      onPressed: ()
                      {
                        FirebaseMessaging.instance.unsubscribeFromTopic('announcements');
                      },
                      child: Text(
                        'UnSubscribe',
                      ),),

                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
