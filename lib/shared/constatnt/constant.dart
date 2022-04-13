//use uID in all app
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social/shared/network/local/cach_helper.dart';

 String? uID =  FirebaseAuth.instance.currentUser?.uid;
