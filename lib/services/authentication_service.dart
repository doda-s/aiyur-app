import 'package:aiyurapp/modules/authentication_module.dart';

Future<String?> createUserWithEmailAndPassword(String emailAddress, password) async {
  return await AuthenticationModule.createUserWithEmailAndPassword(emailAddress, password);
}

Future<void> signOutUser() async {
  await AuthenticationModule.signOut();
}