class SigninServiceInterface {
  Future<bool> signUser(String email, String password) {
    return Future.delayed(const Duration(seconds: 1), () => true );
  }
}