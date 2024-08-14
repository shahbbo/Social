import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:project/layout/social_app/cubit/cubit.dart';
import 'package:project/layout/social_app/cubit/states.dart';
import 'package:project/models/social_app/social_messagemodel.dart';
import 'package:project/models/social_app/social_usermdoel.dart';
import 'package:project/shared/styles/icon_broken.dart';

class ChatDetails extends StatelessWidget {
  SocialUserModel? model;
  ChatDetails({
    this.model
});

  var MessageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMessage(receiverId: model!.uid);
        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (context,state) {} ,
          builder: (context , state)
          {
            return  Scaffold(
              appBar: AppBar(
                titleSpacing: 0,
                title: Row(
                  children:
                  [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        '${model!.image}',
                      ),

                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      '${model!.name}',
                      style: TextStyle(
                        fontSize: 15,
                      ),

                    ),
                  ],
                ),
              ),
              body: Conditional.single(
                fallbackBuilder: (BuildContext context) => Center(child: CircularProgressIndicator()),
                  conditionBuilder: (BuildContext context) =>  SocialCubit.get(context).messages.length >= 0,
                  context: context,
                  widgetBuilder: (BuildContext context) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children:
                      [
                        Expanded(
                          child: ListView.separated(
                            controller: controller ,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                              itemBuilder: (context , index)
                              {
                                var message = SocialCubit.get(context).messages[index];
                                  if(SocialCubit.get(context).model!.uid == message.senderId)
                                  {
                                    return buildMyMessage(message);
                                  }
                                else
                                  return buildMessage(message);
                              },
                              separatorBuilder: (context , state) => SizedBox(
                                height: 15,
                              ),
                              itemCount: SocialCubit.get(context).messages.length,
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color : Color(0xFFE0E0E0),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Row(
                              children:
                              [
                                Expanded(
                                  child: TextFormField(
                                    controller: MessageController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: ' Type Your Message here ... ',
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  color: Colors.blue,
                                  child: MaterialButton(
                                    minWidth: 1,
                                    onPressed: ()
                                    {
                                      SocialCubit.get(context).sendMessage(
                                        receiverId: model!.uid,
                                        dateTime: DateTime.now().toString(),
                                        text: MessageController.text,
                                      );
                                      MessageController.text = '';
                                      TextFormField(
                                        controller: MessageController,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: ' Type Your Message here ... ',
                                        ),
                                      );
                                      controller.animateTo(controller.position.maxScrollExtent,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.easeOut);
                                      },
                                    child: Icon
                                      (
                                      IconBroken.Send,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ),
            );
          },
        );
      }
    );
  }

  Widget buildMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadiusDirectional.only(
          bottomEnd: Radius.circular(10),
          topEnd: Radius.circular(10),
          topStart: Radius.circular(10),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Text(
          '${model.text}'
      ),
    ),
  );

  Widget buildMyMessage(MessageModel model) => Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.2),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10),
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
          ),
        ),
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: Text(
            '${model.text}'
        ),
      ),
    ),
  );
}
