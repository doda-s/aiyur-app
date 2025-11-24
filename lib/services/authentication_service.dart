import 'package:aiyurapp/modules/authentication_module.dart';

Future<AuthResult> createUserWithEmailAndPassword(String emailAddress, password) async {
  return await AuthenticationModule.createUserWithEmailAndPassword(emailAddress, password);
}

Future<AuthResult> signInUserWithEmailAndPassword(String emailAddress, password) async {
  return await AuthenticationModule.signInUserWithEmailAndPassword(emailAddress, password);
}

Future<void> signOutUser() async {
  await AuthenticationModule.signOut();
}