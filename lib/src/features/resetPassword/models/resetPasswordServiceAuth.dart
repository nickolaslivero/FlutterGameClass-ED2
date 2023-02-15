import 'package:empreendedorismodigital2/src/features/resetPassword/models/resetPasswordServiceInterface.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordServiceAuth implements ResetPasswordServiceInterface {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  void resetPasswordWithEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      // TODO
    }
  }
}