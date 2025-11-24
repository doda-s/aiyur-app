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
        return null;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}