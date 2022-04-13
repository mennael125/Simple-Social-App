import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social/modeles/msg_model/msg_model.dart';
import 'package:social/modeles/user_model/user_model.dart';
import 'package:social/shared/constatnt/colors.dart';
import 'package:social/shared/cubits/social_cubit/social_cubit.dart';
import 'package:social/shared/cubits/social_cubit/social_states.dart';
import 'package:social/shared/styles/icon_broken.dart';

var msgController = TextEditingController();

class ChatDetailUi extends StatelessWidget {
  const ChatDetailUi({Key? key, this.receiver}) : super(key: key);
  final UserModel? receiver;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMSGFun(receiverID: receiver!.uID);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SocialCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 2,
              title: appBarTitle(receiver: receiver!, context: context),
              leading: IconButton(
                icon: Icon(IconBroken.Arrow___Left_2),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Conditional.single(
                conditionBuilder: (BuildContext context) =>
                cubit .model !=null  ,
                widgetBuilder: (BuildContext context) {

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                //define msg by the index num
                                var MSGNum = cubit.getMSG[index];
                                if (receiver!.uID == MSGNum.receiverID)
                                  return Align(
                                      alignment: AlignmentDirectional.topEnd,
                                      child: mSG(      msgText: MSGNum ,
                                          color: defaultColor.withOpacity(.5),
                                          topRight: Radius.circular(0),
                                          context: context,
                                          topLeft: Radius.circular(5)));
else
                                  return
                                  //sender msg
                                  Align(
                                      alignment:
                                      AlignmentDirectional.topStart,
                                      child: mSG(
                                          msgText: MSGNum ,
                                          color: Colors.grey[300],
                                          topRight: Radius.circular(5),
                                          context: context,
                                          topLeft: Radius.circular(0)));

                                //my message

                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 5,
                                  ),
                              itemCount: cubit.getMSG.length),
                        ),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border:
                                  Border.all(width: 1, color: defaultColor)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: TextFormField(
                                    controller: msgController,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Write Your Message'),
                                  ),
                                ),
                              ),
                              MaterialButton(
                                  onPressed: () {
                                    SocialCubit.get(context).sendMSG(
                                        receiverID: receiver!.uID,
                                        text: msgController.text,
                                        dateTime: DateTime.now().toString());

                                    msgController.text="";
                                  },
                                  child: Icon(
                                    IconBroken.Send,
                                    size: 25,
                                    color: defaultColor,
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                context: context,
                fallbackBuilder: (BuildContext context) => Center(
                      child: CircularProgressIndicator(),
                    )),
          );
        },
      );
    });
  }
}

//appBar design
appBarTitle({required UserModel receiver, required context }) => Row(children: [
//widget of circle picture
      CircleAvatar(
        radius: 27,
        backgroundColor: defaultColor,
        child: CircleAvatar(
          backgroundImage: NetworkImage(
// 'https://img.freepik.com/free-photo/man-tries-be-speechless-cons-mouth-with-hands-checks-out-big-new-wears-round-spectacles-jumper-poses-brown-witnesses-disaster-frightened-make-sound_273609-56296.jpg?size=626&ext=jpg'),
              receiver.image!),
          radius: 25,
        ),
      ),
      SizedBox(
        width: 10,
      ),
      Text(
        receiver.name,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(height: 1.4),
      ),
    ]);
//Message design
mSG({required color, required context, required topLeft, required topRight , required MsgModel msgText}) =>
    Container(
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(5),
                topLeft: topLeft,
                bottomLeft: Radius.circular(5),
                topRight: topRight)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Text(
            msgText.text,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ));
