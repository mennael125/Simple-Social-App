import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social/modeles/msg_model/msg_model.dart';
import 'package:social/modeles/post_model/post_model.dart';
import 'package:social/modeles/user_model/user_model.dart';
import 'package:social/modules/chats/chats.dart';
import 'package:social/modules/home/home.dart';
import 'package:social/modules/login&register%20screens/loginscreen.dart';
import 'package:social/modules/new_post/new_post.dart';
import 'package:social/modules/settings/settings.dart';
import 'package:social/modules/users/users.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/constatnt/constant.dart';
import 'package:social/shared/cubits/social_cubit/social_states.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(InitialSocialState());

  static SocialCubit get(context) => BlocProvider.of(context);

//bottom navBar
  int currentIndex = 0;

  //Toggle Between Screens
  List<Widget> screens = [
    const HomesScreen(),
    const ChatsScreen(),
    const NewPostScreen(),
    //const UsersScreen(),
    const SettingsScreen(),
  ];

//titles in AppBar
  List<String> titles = ['Home', 'Chats', 'Add Post'

    //'Users'


    , 'Settings'];

//fun to change Screens
  void bottomNavChange(int index) {
    //put the value of current index in index
    if (index == 1) {
      getAllUsers();
    }
    if (index == 2) {
      emit(AddPostPageState());
    } else
      currentIndex = index;
    emit(NavBarChangeState());
  }

  //to get user data from fireStore

  UserModel? model;

  void getUserData() {
    emit(GetDataLoadingState());

//get data of user from firebase
    FirebaseFirestore.instance.collection('users').doc(uID).get().then((value) {
      //get data from firebase throw fromJson
      model = UserModel.fromJson(value.data()!);
      print(uID);
      print('-----------------');
      print(value.data());
      emit(GetDataSuccessState());
    }).catchError((onError) {
      print('___________________________________________');
      print(onError.toString());
      emit(GetDataErrorState(onError.toString()));
    });
  }

//pick Profile photo
  File? profileImage;
  var imagePicker = ImagePicker();

  Future<void> getProfileImage() async {
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      profileImage = File(pickedImage.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      emit(ProfileImagePickedErrorState());

      print('error in profile image pick');
    }
  }

  //pick Cover photo
  File? coverImage;
  var coverPicker = ImagePicker();

  Future<void> getCoverImage() async {
    //open imageSource (gallery , camera ,.....)
    XFile? pickedImage =
        await coverPicker.pickImage(source: ImageSource.gallery);
    //get photo from gallery

    if (pickedImage != null) {
      coverImage = File(pickedImage.path);
      emit(CoverImagePickedSuccessState());
    } else {
      emit(CoverImagePickedErrorState());

      print('error in profile image pick');
    }
  }

  String? profileImageUrl;

//upload and update profile image to fire storage
  updateProfileImage({required phone, required bio, required name}) async {
    //upload image to fire Storage
    emit(UpdateProfileImageLoadingState());
    await FirebaseStorage.instance
        .ref('profileImage')
        .child('profileImage ${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) async {
      // emit(UpdateProfileImageSuccessState());
      //to get the url of image
      await value.ref.getDownloadURL().then((value) {
        //get url
        profileImageUrl = value;
        updateProfile(
            name: name, bio: bio, phone: phone, profileImage: profileImageUrl);

        emit(UpdateProfileImageSuccessState());

        // emit(GetUrlProfileImageSuccessState());
      })
          //error in get url

          .catchError((onError) {
        print('Error is in get url  $onError ');
        print('--------------------------');
        emit(GetUrlProfileImageErrorState());
      });
    })
        //error in upload to fire storage
        .catchError((onError) {
      print('Error is in uploading profile image $onError ');
      print('--------------------------');
      emit(UpdateProfileImageErrorState());
    });
  }

  String? coverImageUrl;

//upload  and update cover image to fire storage
  updateCoverImage({required phone, required bio, required name}) {
    //upload cover image to fire Storage
    emit(UpdateCoverImageLoadingState());
    FirebaseStorage.instance
        .ref('coverImage')
        .child('coverImage ${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      //to get the url of cover image
      value.ref.getDownloadURL().then((value) {
        coverImageUrl = value;

        updateProfile(
            name: name, bio: bio, phone: phone, coverImage: coverImageUrl);
        emit(UpdateCoverImageSuccessState());
      })
          //error in get url

          .catchError((onError) {
        print('Error is in get url  $onError ');
        print('--------------------------');
        emit(GetUrlCoverImageErrorState());
      });
    })
        //error in upload to fire storage
        .catchError((onError) {
      print('Error is in uploading cover image $onError ');
      print('--------------------------');
      emit(UpdateCoverImageErrorState());
    });
  }

//update data in fire base
  updateProfile(
      {required name,
      required phone,
      required bio,
      String? profileImage,
      String? coverImage}) {
    UserModel userModel = UserModel(
      cover: coverImage ?? model!.image,
      phone: phone,
      image: profileImage ?? model!.image,
      bio: bio,
      email: model!.email,
      name: name,
      uID: model!.uID,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel.uID)
        .update(userModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((onError) {
      print('Error in update in fire store $onError ');
      print('--------------------------');
      emit(UpdateProfileErrorState());
    });
  }

  //pick postImage

  File? postImage;
  var pickPostImage = ImagePicker();

  Future<void> getPostImage() async {
    //open imageSource (gallery , camera ,.....)
    XFile? pickedProfileImage =
        await pickPostImage.pickImage(source: ImageSource.gallery);
    //get photo from gallery

    if (pickedProfileImage != null) {
      postImage = File(pickedProfileImage.path);
      emit(PostImagePickedSuccessState());
    } else {
      emit(PostImagePickedErrorState());

      print('error in post image pick');
    }
  }

  //get post image url and upload it
  String? postImageUrl;

  uploadPostImage({required image, required text, required dateTime}) {
    //UploadPost image to fire Storage
    emit(UploadPostLoadingState());
    FirebaseStorage.instance
        .ref('postImage')
        .child('postImage ${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      //to get the url of cover image
      value.ref.getDownloadURL().then((value) {
        postImageUrl = value;

        addPost(postImage: postImageUrl, text: text, dateTime: dateTime);
        emit(UploadPostImageSuccessState());
      })
          //error in get url

          .catchError((onError) {
        print('Error is in get url  $onError ');
        print('--------------------------');
        emit(UploadPostImageErrorState());
      });
    })
        //error in upload to fire storage
        .catchError((onError) {
      print('Error is in uploading cover image $onError ');
      print('--------------------------');
      emit(UploadPostImageErrorState());
    });
  }

  //addPost
  addPost({required text, String? postImage, required dateTime}) {
    emit(UploadPostLoadingState());

    PostModel userPostModel = PostModel(
        dateTime: dateTime,
        postImage: postImageUrl ?? '',
        uID: model!.uID,
        postText: text,
        userImage: model!.image,
        name: model!.name);
    FirebaseFirestore.instance
        .collection('post')
        .add(userPostModel.toMap())
        .then((value) {
      emit(UploadPostSuccessState());
    }).catchError((onError) {
      emit(UploadPostErrorState());
    });
  }

  removePostImage() {
    postImage = null;
    emit(RemovePostImage());
  }

  // list of post model to put data in it
  List<PostModel> getPosts = [];

  //list to get post id
  List<String> postId = [];

  //list of number of likes
  List<int> postLikes = [];

//get post and Likes of it
  getPostLikesFun() {
    FirebaseFirestore.instance.collection('post').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection("Likes").get().then((value) {
          //get number of docs in value
          postLikes.add(value.docs.length);
          //make a loop to get posts is
          postId.add(element.id);

          //make a loop in posts docs
          getPosts.add(PostModel.fromJson(element.data()));
        }).catchError((onError) {});
      });
      emit(GetPostSuccessState());
    }).catchError((onError) {
      emit(GetPostErrorState(onError.toString()));
    });
  }

  //likePost
  likePost(String postId) {
    emit(PostLikesLoadingState());

    FirebaseFirestore.instance
        .collection('post')
        .
        //enter in postId
        doc(postId)
        .collection('Likes')
        .doc(model!.uID)
        .set({'Like': true}).then((value) {
      emit(PostLikesSuccessState());
    }).catchError((onError) {
      emit(PostLikesErrorState(onError.toString()));
    });
  }

  //Comment in Post
  postComment(String postId) {
    emit(PostCommentLoadingState());

    FirebaseFirestore.instance
        .collection('post')
        .
        //enter in postId
        doc(postId)
        .collection('Comments')
        .doc(model!.uID)
        .set({'Comments': true}).then((value) {
      emit(PostCommentSuccessState());
    }).catchError((onError) {
      emit(PostCommentErrorState(onError.toString()));
    });
  }

  //comments
  List<int> postComments = [];
  List<String> postCommentId = [];
  List<PostModel> getPostsComments = [];

  getCommentsFun() {
    FirebaseFirestore.instance.collection('post').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection("Comments").get().then((value) {
          //get number of docs in value
          postComments.add(value.docs.length);
          //make a loop to get posts is
          postCommentId.add(element.id);

          //make a loop in posts docs
          getPostsComments.add(PostModel.fromJson(element.data()));
        }).catchError((onError) {});
      });
      emit(GetPostSuccessState());
    }).catchError((onError) {
      emit(GetPostErrorState(onError.toString()));
    });
  }

//get all users
  List<UserModel> allUsers = [];

  getAllUsers() {
    if (allUsers.isEmpty) {
      emit(GetAllUsersDataLoadingState());

      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
//to remove my acc from list
          if (element.data()['uID'] != model!.uID)
            allUsers.add(UserModel.fromJson(element.data()));
          emit(GetAllUsersDataSuccessState());
        });
      }).catchError((onError) {
        emit(GetAllUsersDataErrorState(onError.toString()));
      });
    }
  }

  //fun to log out  firebase
  Future<void> logOut({required context}) async {
    await FirebaseAuth.instance.signOut().then((value) {
      emit(LogOutLoadingState());
      navigateAndRemove(context: context, widget: LoginScreen());
      emit(LogOutSuccessState());
    }).catchError((onError) {
      emit(LogOutErrorState());
    });
  }

  MsgModel? msgModel;

  //get msg
  sendMSG({required receiverID, required text, required dateTime}) {
    emit(SendMSGLoadingState());
    MsgModel msgModel = MsgModel(
        senderID: model!.uID,
        text: text,
        dateTime: dateTime,
        receiverID: receiverID);
//set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uID)
        .collection('chats')
        .doc(receiverID)
        .collection('MSG')
        .add(msgModel.toMap())
        .then((value) {
      emit(SendMSGSuccessState());
    }).catchError((onError) {
      emit(SendMSGErrorState(onError.toString()));
    });

    //set receiverID chats

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverID)
        .collection('chats')
        .doc(model!.uID)
        .collection('MSG')
        .add(msgModel.toMap())
        .then((value) {
      emit(SendMSGSuccessState());
    }).catchError((onError) {
      emit(SendMSGErrorState(onError.toString()));
    });
  }

  //get message
  //list of msages to put all msg in it
  List<MsgModel> getMSG = [];

  getMSGFun({required receiverID}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(model!.uID)
        .collection('chats')
        .doc(receiverID)
        .collection('MSG').orderBy('dateTime')
        .snapshots()
        .listen((event) {

//listen in every time receive all data again so  you should make list empty
      getMSG=[];
      event.docs.forEach((element) {

        getMSG.add(MsgModel.fromJson(element.data()));
      });
    });
  }
}
