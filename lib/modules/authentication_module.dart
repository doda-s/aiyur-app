import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationModule {
  static UserCredential? _userCredential;

  static UserCredential? getUserCredential() {
    return _userCredential;
  }

  static Future<AuthResult> createUserWithEmailAndPassword(String emailAddress,
      String password) async {
    String exceptionCode;
    try {
      print("Ai, estou registrando");
      _userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      print("Usuário registrado XD");
      return AuthResult(userCredential: _userCredential);
    } on FirebaseAuthException catch (e) {
      exceptionCode = e.code;
    }
    return AuthResult(errorCode: exceptionCode);
  }

  static Future<AuthResult> signInUserWithEmailAndPassword(String emailAddress,
      String password) async {
    String errorCode;
    try {
      final _userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      return AuthResult(userCredential: _userCredential);
    } on FirebaseAuthException catch (e) {
      errorCode = e.code;
    }
    return AuthResult(errorCode: errorCode);
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

class AuthResult {
  final UserCredential? userCredential;
  final String? errorCode;

  AuthResult({this.userCredential, this.errorCode});
}