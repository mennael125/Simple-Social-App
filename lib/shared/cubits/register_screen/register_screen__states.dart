

abstract class RegisterStates{}
class RegisterInitialState extends RegisterStates{}



class RegisterPasswordShowState extends RegisterStates{}
//register state
class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{}
class RegisterErrorState extends RegisterStates{
  final String error;
  RegisterErrorState(this.error);
}
//state for user create
class USerCreateLoadingState extends RegisterStates{}
class USerCreateSuccessState extends RegisterStates{




}
class USerCreateErrorState extends RegisterStates{
  final String error;
  USerCreateErrorState(this.error);
}