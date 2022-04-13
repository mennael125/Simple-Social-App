import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:social/modeles/post_model/post_model.dart';
import 'package:social/modeles/user_model/user_model.dart';
import 'package:social/shared/constatnt/colors.dart';
import 'package:social/shared/cubits/social_cubit/social_cubit.dart';
import 'package:social/shared/cubits/social_cubit/social_states.dart';
import 'package:social/shared/styles/icon_broken.dart';
var commentController =TextEditingController();
class HomesScreen extends StatelessWidget {
  const HomesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var now = DateTime.now();
        var model = SocialCubit.get(context).model;
        var PostsModel = SocialCubit.get(context).getPosts;
        var PostId = SocialCubit.get(context).postId;
        var PostCommentId = SocialCubit.get(context).postCommentId;

        return Scaffold(
          body: Conditional.single(
              fallbackBuilder: (BuildContext context)
              =>  const Center(child:CircularProgressIndicator(),),

              context: context,
              conditionBuilder: (BuildContext context)

            =>  PostsModel.isNotEmpty ,


              widgetBuilder: (BuildContext context) {
               return SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      //this widget belong to the first card in the page
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          const Card(
                            child: Image(
                              image: NetworkImage(
                                  'https://img.freepik.com/free-photo/embarrassed-shocked-european-man-points-index-finger-copy-space-recommends-service-shows-new-product-keeps-mouth-widely-opened-from-surprisement_273609-38455.jpg?w=740'),
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            elevation: 5,
                            margin: EdgeInsets.all(8),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'Communicate With your friend',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      //________________________________________

                      ListView.separated(
                        physics: NeverScrollableScrollPhysics(),

                        itemCount: PostsModel.length,


                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return pageBuilder( model: model!, dateTime: now, context: context, postModel: PostsModel[index] , postID: PostId[index] , index: index ,postCommentID:PostCommentId[index]);
                        }, separatorBuilder: (BuildContext context, int index) =>                Container(color: Colors.grey[300],width: double.infinity, child: SizedBox(height: 5,),)
                        ,
                      ),
                    ],
                  ),
                );
              }),
        );
      },
    );
  }
}
// widget of page builder

Widget pageBuilder(
        {required context, required UserModel model, required dateTime , required PostModel postModel , required String postID , required index , required String postCommentID}) =>
    Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 8),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                //widget of circle picture
                CircleAvatar(
                  radius: 27,
                  backgroundColor: defaultColor,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/man-tries-be-speechless-cons-mouth-with-hands-checks-out-big-new-wears-round-spectacles-jumper-poses-brown-witnesses-disaster-frightened-make-sound_273609-56296.jpg?size=626&ext=jpg'),
                    radius: 25,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //row of name
                    Row(
                      children: [
                        Text(
                          model.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(height: 1.4),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.check_circle,
                          color: Colors.amber,
                          size: 16,
                        ),
                      ],
                    ),

                    Text(
                      dateTime.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .caption!
                          .copyWith(height: 1.4),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                  ],
                )),
                SizedBox(
                  width: 15,
                ),

                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_horiz_outlined),
                  iconSize: 16,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.grey[300],
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                // 'orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.'
                postModel.postText,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(height: 1.2),
              ),
            ),

            //container of tags
            Container(
              width: double.infinity,
              child: Wrap(
                children: [
                  Container(
                    height: 25,
                    child: MaterialButton(
                        minWidth: 1,
                        onPressed: () {},
                        child: Text(
                          '#software',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: defaultColor),
                        )),
                  ),
                  Container(
                    height: 25,
                    child: MaterialButton(
                        minWidth: 1,
                        onPressed: () {},
                        child: Text(
                          '#software',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: defaultColor),
                        )),
                  ),
                  Container(
                    height: 25,
                    child: MaterialButton(
                        minWidth: 1,
                        onPressed: () {},
                        child: Text(
                          '#software',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: defaultColor),
                        )),
                  ),
                  Container(
                    height: 25,
                    child: MaterialButton(
                        minWidth: 1,
                        onPressed: () {},
                        child: Text(
                          '#software',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: defaultColor),
                        )),
                  ),
                  Container(
                    height: 25,
                    child: MaterialButton(
                        minWidth: 1,
                        onPressed: () {},
                        child: Text(
                          '#software',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: defaultColor),
                        )),
                  ),
                  Container(
                    height: 25,
                    child: MaterialButton(
                        minWidth: 1,
                        onPressed: () {},
                        child: Text(
                          '#software',
                          style: Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: defaultColor),
                        )),
                  ),
                ],
              ),
            ),
            //containe of image in post
            if(postModel.postImage.isNotEmpty)
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(image: NetworkImage(
                      //'https://img.freepik.com/free-photo/embarrassed-shocked-european-man-points-index-finger-copy-space-recommends-service-shows-new-product-keeps-mouth-widely-opened-from-surprisement_273609-38455.jpg?w=740'
                      //
                      postModel.postImage), fit: BoxFit.cover)),
            ),
            SizedBox(
              height: 10,
            ),
            //row of comments and likes
            Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        size: 15,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        '${SocialCubit.get(context).postLikes[index]} Likes}',
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        IconBroken.Chat,
                        size: 15,
                        color: Colors.amber,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                       Text(
 '${SocialCubit.get(context).postComments[index]} Comment}',
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                ),
              ],
            ),
            //divider
            Container(
              color: Colors.grey[300],
              width: double.infinity,
            ),
            SizedBox(
              height: 10,
            ),
            // row of writing a comment
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {

                      SocialCubit.get(context).postComment(postCommentID);
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: defaultColor,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                // 'https://img.freepik.com/free-photo/man-tries-be-speechless-cons-mouth-with-hands-checks-out-big-new-wears-round-spectacles-jumper-poses-brown-witnesses-disaster-frightened-make-sound_273609-56296.jpg?size=626&ext=jpg'
                              // ),
                        model.image! ), radius: 20,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0),
                            child: TextFormField(
                              //controller: commentController,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Write Your comment'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    SocialCubit.get(context).likePost(postID);

                  },
                  child: Row(
                    children: [
                      Icon(
                        IconBroken.Heart,
                        size: 15,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        '${SocialCubit.get(context).postLikes[index]} Likes}',
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),

                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),






          ],
        ),
      ),
    );


