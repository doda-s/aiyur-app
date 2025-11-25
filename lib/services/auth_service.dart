import 'package:aiyurapp/models/auth_result.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  AuthService._();
  static final AuthService instance = AuthService._();

  final _auth = FirebaseAuth.instance;

  Future<AuthResult> createUserWithEmailAndPassword(String emailAddress,
      String password) async {
    String exceptionCode;
    try {
      print("Ai, estou registrando");
      final UserCredential _userCredential = await _auth
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

  Future<AuthResult> signInUserWithEmailAndPassword(String emailAddress,
      String password) async {
    String errorCode;
    try {
      final UserCredential _userCredential = await _auth.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      return AuthResult(userCredential: _userCredential);
    } on FirebaseAuthException catch (e) {
      errorCode = e.code;
    }
    return AuthResult(errorCode: errorCode);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }

}