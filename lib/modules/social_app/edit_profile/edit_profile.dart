import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/layout/social_app/cubit/cubit.dart';
import 'package:project/layout/social_app/cubit/states.dart';
import 'package:project/shared/components/components.dart';
import 'package:project/shared/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {

  var nameController = TextEditingController();
  var bioCtroller    = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener:(context,state) {},
      builder: (context,state)
      {
        var  PEROFILEImage = SocialCubit.get(context).ProfileImage;
        var  CoverImage = SocialCubit.get(context).CoverImage;
        var userModel = SocialCubit.get(context).model;

        nameController.text = userModel!.name!;
        bioCtroller.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        return Scaffold(
          appBar: AppBar(
            title: Text('Edit Profile'),
            leading: IconButton(
              onPressed: ()
              {
                Navigator.pop(context);
              },
              icon: Icon(
                  IconBroken.Arrow___Left_Circle
              ),
            ),
            actions:
            [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton(
                  onPressed: ()
                  {
                    SocialCubit.get(context).updateUser(
                        name: nameController.text ,
                        phone: phoneController.text,
                        bio: bioCtroller.text);
                    Navigator.pop(context);
                  },
                  child: Text('Update',style: TextStyle(color: Colors.blue),),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children:
                [
                  if(state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                  if(state is SocialUserUpdateLoadingState)
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children:
                      [
                        Align(
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image: CoverImage == null ? NetworkImage('${userModel.cover}'
                                    ) : FileImage(CoverImage) as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              IconButton(
                                  onPressed: ()
                                  {
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: CircleAvatar(
                                    radius: 20,
                                      backgroundColor: Colors.white,
                                      child: Icon(IconBroken.Camera,
                                      size: 20,
                                      color: Colors.blue,)),
                              ),
                            ],
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 55,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage:PEROFILEImage == null ? NetworkImage('${userModel.image}'
                                ) : FileImage(PEROFILEImage) as ImageProvider ,

                              ),
                            ),
                IconButton(
                              onPressed: ()
                              {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: Icon(IconBroken.Camera,
                                    size: 20,
                                    color: Colors.blue,)
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  if(SocialCubit.get(context).ProfileImage != null || SocialCubit.get(context).CoverImage != null)
                      Row(
                        children:
                        [
                          if(SocialCubit.get(context).ProfileImage != null)
                            Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: ()
                                  {
                                    SocialCubit.get(context).uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioCtroller.text,
                                    );
                                  },
                                  text: 'update profile',
                                ),
                                if(state is SocialUserUpdateLoadingState)
                                    SizedBox(
                                  height: 5.0,
                                ),
                                if(state is SocialUserUpdateLoadingState)
                                    LinearProgressIndicator(),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          if(SocialCubit.get(context).CoverImage != null)
                            Expanded(
                            child: Column(
                              children: [
                                defaultButton(
                                  function: ()
                                  {
                                    SocialCubit.get(context).uploadCoverImage(
                                      name: nameController.text,
                                      phone: phoneController.text,
                                      bio: bioCtroller.text,
                                    );
                                  },
                                  text: 'update cover',
                                ),
                                if(state is SocialUserUpdateLoadingState)
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                if(state is SocialUserUpdateLoadingState)
                                  LinearProgressIndicator(),
                              ],
                            ),
                          ),

                        ],
                      ),
                  if(SocialCubit.get(context).ProfileImage != null || SocialCubit.get(context).CoverImage != null)
                      SizedBox(
                        height: 20,
                      ),
                    defaultFormField(controller: nameController,
                      type: TextInputType.name,
                      validate: (String? value)
                    {
                      if(value!.isEmpty)
                        {
                          return 'name must not be empty';
                        }
                      else
                        return null;
                    },
                      label: 'Name',
                      prefix: IconBroken.Add_User,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(controller: bioCtroller,
                    type: TextInputType.text,
                    validate: (String? value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'Bio must not be empty';
                      }
                      else
                        return null;
                    },
                    label: 'Bio',
                    prefix: IconBroken.Info_Circle,
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(controller: phoneController,
                    type: TextInputType.text,
                    validate: (String? value)
                    {
                      if(value!.isEmpty)
                      {
                        return 'phone must not be empty';
                      }
                      else
                        return null;
                    },
                    label: 'phone',
                    prefix: IconBroken.Calling,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
