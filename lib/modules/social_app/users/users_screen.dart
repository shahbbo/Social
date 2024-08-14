import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:project/layout/social_app/cubit/cubit.dart';
import 'package:project/layout/social_app/cubit/states.dart';
import 'package:project/models/social_app/social_usermdoel.dart';

class UsersScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit , SocialStates>(
      listener:(context , state) {},
      builder: (context , state)
      {
        return Conditional.single(
          conditionBuilder: (BuildContext context) => SocialCubit.get(context).users.length > 0 ,
          context: context,
          widgetBuilder: (BuildContext context) => ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context , index) => bulidChatItem(SocialCubit.get(context).users[index],context),
            itemCount: SocialCubit.get(context).users.length,
            separatorBuilder: (BuildContext context, int index) => SizedBox(
              height: 10,
            ),
          ),
          fallbackBuilder: (BuildContext context) => Center(child: CircularProgressIndicator()),

        );
      },
    );  }
}
Widget bulidChatItem(SocialUserModel model, context) =>  Padding(
  padding: const EdgeInsets.all(10.0),
  child:   Row (
    children:
    [
      CircleAvatar(
        radius: 35,
        backgroundImage: NetworkImage('${model.image}'),
      ),
      SizedBox(

        width: 15.0,

      ),
      Expanded(

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Row(
              children: [
                Text(
                  '${model.name}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.withOpacity(0.5),
                  ),
                ),
              ],

            ),
          ],

        ),

      ),
    ],
  ),
);