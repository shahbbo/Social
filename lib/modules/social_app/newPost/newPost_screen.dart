import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/layout/social_app/cubit/cubit.dart';
import 'package:project/layout/social_app/cubit/states.dart';
import 'package:project/shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {

  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context,state)
    {
      var pimage = SocialCubit.get(context).PostImage;
      var  userModel = SocialCubit.get(context).model;

      return Scaffold(
        appBar: AppBar(
          title: Text('Create Post'),
          actions:
          [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: OutlinedButton(
                onPressed: ()
                {
                  var now = DateTime.now();

                  if(SocialCubit.get(context).PostImage == null )
                  {
                    SocialCubit.get(context).createpost(dateTime: now.toString(), text: textController.text);
                  }
                  else
                  {
                    SocialCubit.get(context).uploadNewPost(dateTime: now.toString(), text: textController.text);
                  }
                  Navigator.pop(context);
                },
              child: Text('Post',style: TextStyle(color: Colors.blue),),
              ),
            )
            /*defalutTextButton(
                function: ()
                {

                },
                text: 'Post'
            )*/
          ],
          leading: IconButton(
            onPressed: ()
            {
              Navigator.pop(context);
            },
            icon: Icon(
                IconBroken.Arrow___Left_Circle
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children:
            [
              if(state is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
              if(state is SocialCreatePostLoadingState)
                SizedBox(
                height: 10.0,
              ),
              Row(
                children:
                [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage('${userModel!.image}'),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  Expanded(
                    child: Text(
                      '${userModel.name}',
                      style: TextStyle(
                        height:1.4,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
                Expanded(
                child: TextFormField(
                  controller:  textController,
                  decoration: InputDecoration(
                    hintText: 'what is on your mind... ?',
                    border: InputBorder.none,
                  ),
                ),
              ),
              if(SocialCubit.get(context).PostImage != null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                          image: FileImage(pimage!) ,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: ()
                      {
                        SocialCubit.get(context).removePostImage();
                      },
                      icon: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Icon(IconBroken.Close_Square,
                            size: 20,
                            color: Colors.blue,)),
                    ),
                  ],
                ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(onPressed:
                        ()
                    {
                      SocialCubit.get(context).getPostImage();
                    },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            Icon(
                              IconBroken.Image_2
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              'Add photo',

                            ),
                          ],
                        ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(onPressed: (){},
                      child:  Text(
                        '# Tags',

                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
    );
  }
}
