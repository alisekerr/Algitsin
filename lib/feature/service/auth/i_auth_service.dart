import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthService {
  Future<User?> signIn(String email, String password);
  signOut();
  Future<User?> creatPerson(String name, String email, String password);

}
