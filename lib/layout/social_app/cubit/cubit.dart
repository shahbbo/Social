import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/layout/social_app/cubit/states.dart';
import 'package:project/models/social_app/social_messagemodel.dart';
import 'package:project/models/social_app/social_postmodel.dart';
import 'package:project/models/social_app/social_usermdoel.dart';
import 'package:project/modules/social_app/chats/chats_screen.dart';
import 'package:project/modules/social_app/feeds/feeds_screen.dart';
import 'package:project/modules/social_app/newPost/newPost_screen.dart';
import 'package:project/modules/social_app/settings/settings_screen.dart';
import 'package:project/modules/social_app/users/users_screen.dart';
import 'package:project/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit() : super(SocialIinitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model ;

  void getUserData() {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.
    collection('users')
    .doc(uid)
    .snapshots()
    .listen((event)
    {
      model = SocialUserModel.fromJson(event.data());
      emit(SocialGetUserSuccessState());
    });
  }

  int currentIndex = 0 ;

  List<Widget> screens =
  [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles =
  [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];
  void changeBottomnav(int index)
  {
    if(index == 1)
      {
        GetAllUsers();
      }
    if(index == 2)
    {
      emit(SocialPostState());
      }
      else {
        currentIndex = index ;
        emit(SocialChangeBottomNav());
      }
  }



  File? ProfileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null) {
      ProfileImage = File(pickedFile.path) ;
      emit(SocialProfileImagePickedSuccessState());
    }
    else {
      print('No image selected');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? CoverImage;
  Future<void> getCoverImage() async  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null) {
      CoverImage = File(pickedFile.path) ;
      emit(SocialCoverImagePickedSuccessState());
    }
    else {
      print('No image selected');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    required String name ,
    required String phone,
    required String bio ,})  {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(ProfileImage!.path).pathSegments.last}')
        .
    putFile(ProfileImage!)
    .then((value)
    {
      value
          .ref
          .getDownloadURL()
          .then((value) {
            emit(SocialUploadProfileImageSuccessState());
        print(value);
        updateUser(phone: phone, name:name, bio:bio , image:  value);
      }
      ).catchError((error)
      {
        emit(SocialUploadProfileImageErrorState());
        print(error.toString());
      }) ;
    })
    .catchError((error)
    {
      emit(SocialUploadProfileImageErrorState());
      print(error.toString());
    });
  }

  void uploadCoverImage({
    required String name ,
    required String phone,
    required String bio ,})  {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('users/${Uri.file(CoverImage!.path).pathSegments.last}').
    putFile(CoverImage!)
        .then((value)
    {
      value
          .ref
          .getDownloadURL()
          .then((value) {
        emit(SocialUploadCoverImageSuccessState());
        print(value);
        updateUser(name: name, phone: phone, bio: bio , cover:  value);
      }
      ).catchError((error)
      {
        emit(SocialUploadCoverImageErrorState());
        print(error.toString());
      }) ;
    })
        .catchError((error)
    {
      emit(SocialUploadCoverImageErrorState());
      print(error.toString());
    });
  }

 void updateUserImage({
    required String name ,
    required String phone,
    required String bio ,}) {
    emit(SocialUserUpdateLoadingState());
    if(CoverImage != null)
    {
      uploadCoverImage(bio: bio, phone: phone, name: name);
    }
    else if(ProfileImage != null)
    {
      uploadProfileImage(phone: phone, name: name , bio: bio );
    }
    else if(CoverImage != null && ProfileImage != null) {}
    else
    {
      updateUser(
          name: name,
          phone: phone,
          bio: bio
      );
    }
  }

  void updateUser({
    required String name ,
    required String phone,
    required String bio ,
    String? cover ,
    String? image,}) {
    SocialUserModel up = SocialUserModel
      (
      name: name,
      phone: phone,
      uid: model!.uid,
      email: model!.email,
      cover: cover ?? model!.cover,
      image: image ?? model!.image,
      bio: bio,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance.collection('users').doc(model!.uid).update(up.toMap()).then((value)
    {
      getUserData();
    }
    ).catchError((error)
    {
      print(error.toString());
    });
  }

  File? PostImage ;

  Future<void> getPostImage() async  {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);


    if(pickedFile != null) {
      PostImage = File(pickedFile.path) ;
      emit(SocialPostImagePickedSuccessState());
    }
    else {
      print('No image selected');
      emit(SocialPostImagePickedErrorState());
    }
  }
  void removePostImage() {
    PostImage = null ;
    emit(SocialRemovePostImageState());
  }


  void uploadNewPost({
    required String dateTime,
    required String text,})  {
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance.ref().child('posts/${Uri.file(PostImage!.path).pathSegments.last}').
    putFile(PostImage!)
        .then((value)
    {
      value
          .ref
          .getDownloadURL()
          .then((value) {
        print(value);
        createpost(
          dateTime: dateTime,
          text: text,
          PostImage: value ,
        );
      }
      ).catchError((error)
      {
        emit(SocialCreatePostErrorState());
        print(error.toString());
      }) ;
    })
        .catchError((error)
    {
      emit(SocialCreatePostErrorState());
      print(error.toString());
    });
  }

  void createpost({
    required String dateTime,
    required String text,
    String? PostImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostUserModel up = PostUserModel
      (
      name: model!.name,
      image: model!.image,
      uid: model!.uid,
      dateTime : dateTime,
      text: text,
      PostImage : PostImage ?? '' ,
    );
    FirebaseFirestore.instance.collection('posts').add(up.toMap()).then((value)
    {
      emit(SocialCreatePostSuccessState());
    }
    ).catchError((error)
    {
      emit(SocialCreatePostErrorState());
      print(error.toString());
    });
  }

  List<PostUserModel> posts = [];
  List<String> postid = [] ;
  List<int> likes = [] ;
  List<int> comments = [] ;

  void getPosts() {
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      posts = [];
      event.docs.forEach((element)
      {
        element.reference
            .collection('likes')
            .snapshots()
        .listen((event)
        {
          likes.add(event.docs.length);
          postid.add(element.id);
          posts.add(PostUserModel.fromJson(element.data()));
        });
      });
      });
    /*FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value)  {
          value.docs.forEach((element)
          {
            element.reference
            .collection('likes')
            .get()
            .then((value)
            {
              likes.add(value.docs.length);
              postid.add(element.id);
              posts.add(PostUserModel.fromJson(element.data()));
            })
            .catchError((error) {});
          });

        });*/
  }

  void likePost(String PostId)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(PostId)
        .collection('likes')
        .doc(model!.uid)
        .set(
        {
          'like' : true ,
        })
        .then((value)
    {
      emit(SocialLikePostsSuccessState());
    })
        .catchError((error)
    {
      emit(SocialLikePostsErrorState(error.toString()));
    });
  }

 void CommentPost(String PostId)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(PostId)
        .collection('comments')
        .doc(model!.uid)
        .set(
        {
          'comment' : true ,
        })
        .then((value)
    {
      emit(SocialCommentPostsSuccessState());
    })
        .catchError((error)
    {
      emit(SocialCommentPostsErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void GetAllUsers() {

    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((event)
    {
      users = [] ;
      event.docs.forEach((element)
      {
        if(element.data()['uid'] != model!.uid)
          users.add(SocialUserModel.fromJson(element.data()));
      });
      emit(SocialGetAllUserSuccessState());
    });
   /* users = [] ;
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if(element.data()['uid'] != model!.uid)
          users.add(SocialUserModel.fromJson(element.data()));
      });
      emit(SocialGetAllUserSuccessState());
    })
        .catchError((error) {
      emit(SocialGetAllUserErrorState(error.toString()));
    });*/
  }

  void sendMessage({
    required String? receiverId,
    required String dateTime,
    required String text,
})
  {
    MessageModel Message = MessageModel(
      text: text,
      senderId: model!.uid,
      recieverId: receiverId,
      dateTime: dateTime
    );

    FirebaseFirestore.instance
        .collection('users')
    .doc(model!.uid)
    .collection('chats')
    .doc(receiverId)
    .collection('message')
    .add(Message.toMap())
    .then((value)
    {
      emit(SocialSendMessageSuccessState());
    }).catchError((error)
    {
      emit(SocialSendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(model!.uid)
        .collection('message')
        .add(Message.toMap())
        .then((value)
    {
      emit(SocialSendMessageSuccessState());
    }).catchError((error)
    {
      emit(SocialSendMessageErrorState());
    });
  }

  List<MessageModel> messages = [];

  void getMessage({
    required String? receiverId,
})
  {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uid)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
    .orderBy('dateTime')
        .snapshots()
        .listen((event) {
            messages = [];
          event.docs.forEach((element)
          {
            messages.add(MessageModel.fromJson(element.data()));
          });
          emit(SocialGetMessageSuccessState());
    });
  }


}