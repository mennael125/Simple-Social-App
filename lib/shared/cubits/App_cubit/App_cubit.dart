import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'App_states.dart';


class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(InitialAppState());
  static AppCubit get(context)=>BlocProvider.of(context);


}