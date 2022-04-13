abstract class SocialStates {}

class InitialSocialState extends SocialStates {}

class NavBarChangeState extends SocialStates {}

class AddPostPageState extends SocialStates {}

class GetDataLoadingState extends SocialStates {}

class GetDataErrorState extends SocialStates {
  final String error;

  GetDataErrorState(this.error);
}

class GetDataSuccessState extends SocialStates {}

class ProfileImagePickedSuccessState extends SocialStates {}

class ProfileImagePickedErrorState extends SocialStates {}

class CoverImagePickedSuccessState extends SocialStates {}

class CoverImagePickedErrorState extends SocialStates {}

class GetUrlProfileImageErrorState extends SocialStates {}

class GetUrlProfileImageSuccessState extends SocialStates {}

class UpdateProfileImageErrorState extends SocialStates {}

class UpdateProfileImageSuccessState extends SocialStates {}

class UpdateProfileImageLoadingState extends SocialStates {}

class GetUrlCoverImageErrorState extends SocialStates {}

class GetUrlCoverImageSuccessState extends SocialStates {}

class UpdateCoverImageErrorState extends SocialStates {}

class UpdateCoverImageSuccessState extends SocialStates {}

class UpdateCoverImageLoadingState extends SocialStates {}

class UpdateProfileErrorState extends SocialStates {}

// create post states
class PostImagePickedSuccessState extends SocialStates {}

class PostImagePickedErrorState extends SocialStates {}

class UploadPostImageErrorState extends SocialStates {}

class UploadPostImageSuccessState extends SocialStates {}

class UploadPostLoadingState extends SocialStates {}

class UploadPostErrorState extends SocialStates {}

class UploadPostSuccessState extends SocialStates {}

class RemovePostImage extends SocialStates {}

class GetPostLoadingState extends SocialStates {}

class GetPostErrorState extends SocialStates {
  final String error;

  GetPostErrorState(this.error);
}

class GetPostSuccessState extends SocialStates {}

//post like states
class PostLikesLoadingState extends SocialStates {}

class PostLikesErrorState extends SocialStates {
  final String error;

  PostLikesErrorState(this.error);
}

class PostLikesSuccessState extends SocialStates {}

//post comment states
class PostCommentLoadingState extends SocialStates {}

class PostCommentErrorState extends SocialStates {
  final String error;

  PostCommentErrorState(this.error);
}

class PostCommentSuccessState extends SocialStates {}

//get all user
class GetAllUsersDataLoadingState extends SocialStates {}

class GetAllUsersDataErrorState extends SocialStates {
  final String error;

  GetAllUsersDataErrorState(this.error);
}

class GetAllUsersDataSuccessState extends SocialStates {}
//log out
class LogOutLoadingState extends SocialStates {}

class LogOutSuccessState extends SocialStates {}

class LogOutErrorState extends SocialStates {}
//send msg
class SendMSGLoadingState extends SocialStates {}

class SendMSGErrorState extends SocialStates {
  final String error;

  SendMSGErrorState(this.error);
}

class SendMSGSuccessState extends SocialStates {}
class GetMSGSuccessState extends SocialStates {}