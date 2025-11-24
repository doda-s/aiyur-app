import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationModule {
  static Future<UserCredential?> createUserWithEmailAndPassword(String emailAddress,
      String password) async {
    try {
      print("Ai, estou registrando");
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print("Usuário registrado XD");
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<UserCredential?> signInUserWithEmailAndPassword(String emailAddress,
      String password) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("Esse usuário não existe.");
      } else if (e.code == 'wrong-password') {
        print("Senha errada, guerreiro.");
      }
    }
    return null;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}