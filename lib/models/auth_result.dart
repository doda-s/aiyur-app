import 'package:firebase_auth/firebase_auth.dart';

class AuthResult {
  final UserCredential? userCredential;
  final String? errorCode;

  AuthResult({this.userCredential, this.errorCode});
}