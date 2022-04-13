import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/modeles/user_model/user_model.dart';
import 'package:social/modules/edit_profile/edit_profile.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/constatnt/colors.dart';
import 'package:social/shared/constatnt/constant.dart';
import 'package:social/shared/cubits/social_cubit/social_cubit.dart';
import 'package:social/shared/cubits/social_cubit/social_states.dart';
import 'package:social/shared/network/local/cach_helper.dart';
import 'package:social/shared/styles/icon_broken.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        // instance of model
       var model = SocialCubit.get(context).model;


        return Scaffold(
          body:
          model !=null ?  SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                //container of cover and photo With align
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      //add align to make the cover in the up
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          height: 160,
                          width: double.infinity,
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5)),
                              image: DecorationImage(
                                  // image: NetworkImage(
                                  //     'https://img.freepik.com/free-vector/abstract-colorful-hand-painted-wallpaper_52683-61599.jpg?w=740') ,
                                 image: NetworkImage(
                                '${model.cover}') ,

                                  fit: BoxFit.cover)),
                        ),
                      ),
                       CircleAvatar(
                        radius: 52,
                        backgroundColor: defaultColor,
                        child: CircleAvatar(
                          // backgroundImage: NetworkImage(
                          // 'https://img.freepik.com/free-vector/young-black-girl-avatar_53876-115570.jpg?t=st=1649212806~exp=1649213406~hmac=d4ea9c436ce796f91dae079d8d93dbbd790ef49606427bb1dd387cd7134cebd2&w=740'),

                          backgroundImage: NetworkImage(
                              '${model.image}') ,
                          radius: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                //text of name
                Text(
                  '${model.name}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),

                //text of bio
                Text(
                  '${model.bio}',
                  style: Theme.of(context).textTheme.caption,
                ),
//row of posts , likes , comments
                Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            '100 ',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            'posts ',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            '100 ',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            'photos ',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            '100 ',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            'followers ',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    )),
                    Expanded(
                        child: InkWell(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            '100 ',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Text(
                            'following ',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ))
                  ],
                ),

                SizedBox(
                  height: 8,
                ),
                //button of add photo  and edit
                Row(
                  children: [
                    Expanded(
                        child: OutlinedButton(
                            onPressed: () {}, child: Text('Add Photo'))),
                    OutlinedButton(
                        onPressed: () {
                          navigateTo(context: context, widget: EditProfileScreen());

                        }, child: Icon(IconBroken.Edit))
                  ],
                ),
                SizedBox(height: 5),
                defaultButton(text: 'Log out', fun: (){
                   SocialCubit.get(context).logOut(context: context);
print ('Log Out ___________________$uID');
                })
              ],
            ),
          )) : Center(child:CircularProgressIndicator()),
        );
      },
    );
  }
}
