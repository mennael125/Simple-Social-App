import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/layouts/social_layout.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/constatnt/colors.dart';
import 'package:social/shared/cubits/social_cubit/social_cubit.dart';
import 'package:social/shared/cubits/social_cubit/social_states.dart';
import 'package:social/shared/styles/icon_broken.dart';

var postController = TextEditingController();

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is UploadPostSuccessState) {
          backTo(context: context, widget: SocialLayoutScreen());
        }
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var now = DateTime.now();
        return Scaffold(
            appBar:
                defaultAppBar(context: context, title: "Create Post", actions: [
              textButton(
                  text: "Add post",
                  fun: () {
                    if (cubit.postImageUrl != null) {
                      cubit.uploadPostImage(
                          image: cubit.postImageUrl,
                          text: postController.text,
                          dateTime: now.toString());
                    } else
                      cubit.addPost(
                          text: postController.text, dateTime: now.toString());
                  }),
              SizedBox(
                width: 5,
              )
            ]),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is UploadPostLoadingState)
                    Column(
                      children: [
                        LinearProgressIndicator(),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 27,
                        backgroundColor: defaultColor,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(cubit.model!.image!),
                          radius: 25,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Column(
                        children: [
                          Text(
                            cubit.model!.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(height: 1.4),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            now.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(height: 1.4),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: postController,
                      keyboardType: TextInputType.multiline,
                      // user keyboard will have a button to move cursor to next line
                      minLines: 1,
                      maxLines: 30,
                      maxLength: 2000,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          label: Text(
                              ' What\'s on your mind , ${cubit.model!.name}')),
                    ),
                  ),
                  if (cubit.postImage != null)
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          //container of post
                          Container(
                            height: 160,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    // image: NetworkImage(
                                    //     'https://img.freepik.com/free-vector/abstract-colorful-hand-painted-wallpaper_52683-61599.jpg?w=740') ,
                                    image: FileImage(cubit.postImage!),
                                    fit: BoxFit.cover)),
                          ),
                          //widget of get post image
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                //remove post method
                                cubit.removePostImage();
                              },
                              child: CircleAvatar(
                                  radius: 25,
                                  backgroundColor: defaultColor.withOpacity(.7),
                                  child: Icon(
                                    IconBroken.Close_Square,
                                    size: 23,
                                    color: Colors.black,
                                  )),
                            ),
                          )
                        ],
                      ),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            cubit.getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 5,
                              ),
                              Text("Add photo"),
                            ],
                          )),
                      Expanded(
                        child:
                            TextButton(onPressed: () {}, child: Text("# Tags")),
                      )
                    ],
                  )
                ],
              ),
            ));
      },
    );
  }
}
