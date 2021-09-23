import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationProvider {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthenticationProvider(this._firebaseAuth);

  Stream<User?> getAuthStates() {
    return _firebaseAuth.authStateChanges();
  }

  Future<User?> firebaseLogin(AuthCredential credential) async {
    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);

    return userCredential.user;
  }

  Future<void> firebaseLogout() async {
    await _firebaseAuth.signOut();
  }
}
