import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social/modeles/user_model/user_model.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/constatnt/colors.dart';
import 'package:social/shared/cubits/social_cubit/social_cubit.dart';
import 'package:social/shared/cubits/social_cubit/social_states.dart';

import 'chat_detail.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var allUsers = SocialCubit
        .get(context)
        .allUsers;
    return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(

              body: Padding(
              padding: const EdgeInsets.all(8.0),
          child: Conditional.single(
          widgetBuilder: (BuildContext context) =>
            ListView.separated(
                itemCount: allUsers.length, itemBuilder: (BuildContext
                context, int index)
            =>
                chatPageBuilder(context: context, userModel: allUsers[index])
            , separatorBuilder: (BuildContext context, int index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(width: double.infinity, color: Colors.grey[300],),
            )
            ,),

            context: context,
            conditionBuilder: (BuildContext context) => allUsers.isNotEmpty,
            fallbackBuilder: (BuildContext context) =>
            Center(child: CircularProgressIndicator(),)
          )
    )
    );

  }

  ,

);}


Widget chatPageBuilder({required context, required UserModel userModel}) =>
    InkWell(onTap: () {

      navigateTo(context: context  , widget:  ChatDetailUi(receiver:userModel ,));
    },
      child: Row(
          children: [
            //widget of circle picture
            CircleAvatar(
              radius: 27,
              backgroundColor: defaultColor,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    // 'https://img.freepik.com/free-photo/man-tries-be-speechless-cons-mouth-with-hands-checks-out-big-new-wears-round-spectacles-jumper-poses-brown-witnesses-disaster-frightened-make-sound_273609-56296.jpg?size=626&ext=jpg'),
                    userModel.image!),  radius: 25,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              userModel.name,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(height: 1.4),
            ),
          ]
      ),
    );}