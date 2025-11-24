import 'package:aiyurapp/modules/authentication_module.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<UserCredential?> createUserWithEmailAndPassword(String emailAddress, password) async {
  return await AuthenticationModule.createUserWithEmailAndPassword(emailAddress, password);
}

Future<void> signOutUser() async {
  await AuthenticationModule.signOut();
}