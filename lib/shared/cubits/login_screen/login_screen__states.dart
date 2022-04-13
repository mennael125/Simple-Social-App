
abstract class LoginStates{}
class ShopAppInitialState extends LoginStates{}




class ShopAppPasswordShowState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
  //send uID To save it in cash helper easily
  final String uID;

  LoginSuccessState(this.uID);
}
class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState(this.error);
}
