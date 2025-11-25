import 'package:aiyurapp/models/auth_result.dart';
import 'package:aiyurapp/services/auth_service.dart';

class AuthenticationController {
  Future<String?> createUserWithEmailAndPassword(String email, String password) async {
    AuthResult authResult = await AuthService.instance.createUserWithEmailAndPassword(email, password);

    if (authResult.userCredential == null) {
      return authResult.errorCode;
    }

    return null;
  }

  Future<String?> signInUserWithEmailAndPassword(String email, String password) async {
    AuthResult authResult = await AuthService.instance.signInUserWithEmailAndPassword(email, password);

    if (authResult.userCredential == null) {
      return authResult.errorCode;
    }

    return null;
  }
}