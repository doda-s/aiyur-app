import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationModule {
  static Future<String?> createUserWithEmailAndPassword(String emailAddress,
      String password) async {
    try {
      print("Ai, estou registrando");
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print("Usuário registrado XD");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return 'The account already exists for that email.';
      }
    } catch (e) {
      print(e);
      return 'Internal error ocurred.';
    }
    return null;
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}