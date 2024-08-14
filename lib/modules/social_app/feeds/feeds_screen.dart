import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:project/layout/social_app/cubit/cubit.dart';
import 'package:project/layout/social_app/cubit/states.dart';
import 'package:project/models/social_app/social_postmodel.dart';
import 'package:project/shared/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state) {},
      builder: (context,state)
      {
            return Conditional.single(
                fallbackBuilder: (BuildContext context) => Center(child: CircularProgressIndicator()),
                widgetBuilder: (BuildContext context) => SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children:
                    [
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 5.0,
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children:
                          [
                            Image(
                              image: NetworkImage('${SocialCubit.get(context).model!.cover}'),
                              fit: BoxFit.cover,
                              height: 200.0,
                              width: double.infinity,
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Counmmation With Friend',
                                  style: TextStyle(
                                      fontFamily: 'Janna',
                                      fontSize: 15,
                                      color: Colors.white
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => buildPostItem(SocialCubit.get(context).posts[index],context , index),
                        itemCount: SocialCubit.get(context).posts.length,
                      ),
                    ],
                  ),
                ),
                context: context,
                conditionBuilder: (BuildContext context) => SocialCubit.get(context).posts.length >= 0 && SocialCubit.get(context).model != null,
            );
          },
        );
  }

  Widget buildPostItem(PostUserModel model , context , index) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    child: Padding(
      padding: const EdgeInsetsDirectional.only(
        bottom: 10,
        top: 5,
      ),
      child: Column(
        children:
        [
          Row (
            children:
            [
              CircleAvatar(
                radius: 25,
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
                            height:1.4,
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.blue,
                          size: 17,
                        ),
                      ],
                    ),
                    Text(
                      '${model.dateTime}',
                      style: Theme.of(context).textTheme.caption!.copyWith(
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 15,
              ),
              IconButton(
                onPressed: ()
                {
                },
                icon: Icon(
                  IconBroken.Close_Square,
                  size: 19,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 15
            ),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              '${model.text}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          if(model.PostImage != '')
            Padding(
            padding: const EdgeInsets.only(
              top: 20 ,
            ),
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image: DecorationImage(
                  image: NetworkImage('${model.PostImage}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 5
            ),
            child: Row(
              children:
              [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5
                      ),
                      child: Row(
                        children:
                        [
                          Icon(
                            IconBroken.Heart,
                            size: 20,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${SocialCubit.get(context).likes[index]}',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: ()
                    {}
                    ,
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end ,
                        children:
                        [
                          Icon(
                            IconBroken.Chat,
                            size: 20,
                            color: Colors.amber,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'comment',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: ()
                    {}
                    ,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom: 10.0
            ),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children:
            [
              Expanded(
                child: InkWell(
                  child: Row (
                    children:
                    [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).model!.image}'
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'Write a Comment....',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            height: 1.4
                        ),
                      ),
                    ],
                  ),
                  onTap: ()
                  {
                  // SocialCubit.get(context).CommentPost(SocialCubit.get(context).postid[index]);
                  },
                ),
              ),
              InkWell(
                child: Row(
                  children:
                  [
                    Icon(
                      IconBroken.Heart,
                      size: 20,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Like',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                onTap: ()
                {
                  SocialCubit.get(context).likePost(SocialCubit.get(context).postid[index]);
                }
                ,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
