import 'package:firebase_auth/firebase_auth.dart';
import '../../../shared/user/userService2.dart';

class ClassService {
  final _userService = AuthService();

  void getClasses() {
    User? user = _userService.currentUser;

  }
}