import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social/modules/login&register%20screens/loginscreen.dart';
import 'package:social/shared/components/components.dart';
import 'package:social/shared/constatnt/constant.dart';
import 'package:social/shared/cubits/App_cubit/App_cubit.dart';
import 'package:social/shared/cubits/App_cubit/App_states.dart';
import 'package:social/shared/cubits/bloc_observer/bloc_observer.dart';
import 'package:social/shared/cubits/social_cubit/social_cubit.dart';
import 'package:social/shared/network/local/cach_helper.dart';
import 'package:social/shared/styles/styles.dart';

import 'layouts/social_layout.dart';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {



  print ("on thread  ${message.data.toString()}");
  toast(text: 'on thread', state: ToastState.success)  ;}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  //unique id of device
  var token = await FirebaseMessaging.instance.getToken();

  print('token ------------$token');
  FirebaseMessaging.onMessage.listen((event) {
    print ("on message  ${event.data.toString()}");
    toast(text: 'on message', state: ToastState.success)  ;

  });
  //app  open in back ground
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print (" onMessageOpenedApp  ${event.data.toString()}");
    toast(text: 'onMessageOpenedApp', state: ToastState.success)  ;
  });
  //app in Terminated
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await CacheHelper.init();


  BlocOverrides.runZoned(
    () {

      var uID = FirebaseAuth.instance.currentUser?.uid;


      Widget start;
      if (uID != null) {
        start = const SocialLayoutScreen();
        print ("_____________________$uID");
      } else {
        start = LoginScreen();
      }
      runApp(MyApp(start));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget start;

  MyApp(this.start);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
        BlocProvider(create: (context) => SocialCubit()

            ..getUserData()..getPostLikesFun()..getCommentsFun()

        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              theme: lightMode,
              debugShowCheckedModeBanner: false,
              home: start,
            );
          }),
    );
  }
}
