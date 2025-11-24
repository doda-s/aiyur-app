import 'package:aiyurapp/modules/authentication_module.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<AuthResult> createUserWithEmailAndPassword(String emailAddress, password) async {
  return await AuthenticationModule.createUserWithEmailAndPassword(emailAddress, password);
}

Future<AuthResult> signInUserWithEmailAndPassword(String emailAddress, password) async {
  return await AuthenticationModule.signInUserWithEmailAndPassword(emailAddress, password);
}

Future<void> signOutUser() async {
  await AuthenticationModule.signOut();
}

UserCredential getUserCredential() {
  UserCredential? userCredential = AuthenticationModule.getUserCredential();

  if (userCredential != null) {
    return userCredential;
  }

  // TODO force user to authenticate
  throw Exception("User autentication not implemented");
}