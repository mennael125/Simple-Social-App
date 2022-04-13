import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:social/modules/login&register%20screens/loginscreen.dart';
import 'package:social/modules/new_post/new_post.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/constatnt/constant.dart';
import 'package:social/shared/cubits/social_cubit/social_cubit.dart';
import 'package:social/shared/cubits/social_cubit/social_states.dart';
import 'package:social/shared/network/local/cach_helper.dart';
import 'package:social/shared/styles/icon_broken.dart';

class SocialLayoutScreen extends StatelessWidget {
  const SocialLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {


        if (state is AddPostPageState){

          navigateTo(context: context, widget: NewPostScreen())
;        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(actions: [

            IconButton(
                onPressed: () {}, icon: const Icon(IconBroken.Notification)),
            IconButton(onPressed: () {}, icon: const Icon(IconBroken.Search)),
            const SizedBox(
              width: 5,
            ),
          ], context: context, title: cubit.titles[cubit.currentIndex]),
          //******************************____________________*********************************
          //this comment belong to email verification
          // body: Conditional.single(
          //   context: context,
          //   conditionBuilder: (context) => cubit.model != null,
          //   widgetBuilder: (context) {
          //     return Column(
          //       children: [
          //         //check the verify
          //         !FirebaseAuth.instance.currentUser!.emailVerified?
          //         Container(
          //           width: double.infinity,
          //           height: 150,
          //           color: Colors.amber.withOpacity(.6),
          //           child: Row(
          //             children: [
          //               Icon(Icons.info_outline),
          //               SizedBox(
          //                 width: 15,
          //               ),
          //               Text('please verify your mail'),
          //               SizedBox(
          //                 width: 15,
          //               ),
          //               textButton(
          //                   text: 'send',
          //                   fun: () async {
          //                     //send verify to your email
          //                     await FirebaseAuth.instance.currentUser!
          //                         .sendEmailVerification()
          //                         .then((value) {
          //                       toast(text: 'Check Your mail', state: ToastState.success);
          //                     })
          //                         .catchError((onError) {});
          //                   })
          //             ],
          //           ),
          //         ) : const Text('welcome ')
          //       ],
          //     );
          //   },
          //   fallbackBuilder: (context) =>
          //       const Center(child: CircularProgressIndicator()),
          // ),
          //___________________________________
          //bottomNavBar
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.bottomNavChange(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Chat), label: 'Chats'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Paper_Upload), label: 'Add Post'),
              //BottomNavigationBarItem(
              //     icon: Icon(IconBroken.User), label: 'Users'),
              BottomNavigationBarItem(
                  icon: Icon(IconBroken.Setting), label: 'Settings'),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
