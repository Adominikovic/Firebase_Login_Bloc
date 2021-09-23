import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/authentication/data/providers/firebase_auth_provider.dart';
import 'package:firebase_login/authentication/data/providers/google_sign_in_provider.dart';
import 'package:firebase_login/authentication/models/user_auth_details.dart';

class AuthenticationRepository {
  final FirebaseAuthenticationProvider _firebaseAuthenticationProvider;
  final GoogleSignInProvider _googleSignInProvider;

  AuthenticationRepository(
      this._firebaseAuthenticationProvider, this._googleSignInProvider);

  UserAuthDetails _getFirebaseCredential(User user) {
    UserAuthDetails details;
    details = UserAuthDetails(
        true, user.uid, user.photoURL, user.displayName, user.email);
    return details;
  }

  Stream<UserAuthDetails> getUserAuthDetails() {
    return _firebaseAuthenticationProvider
        .getAuthStates()
        .map((user) => _getFirebaseCredential(user!));
  }

  Future<UserAuthDetails> getCredentialWithGoogle() async {
    User? user = await _firebaseAuthenticationProvider
        .firebaseLogin(await _googleSignInProvider.googleLogIn());
    return _getFirebaseCredential(user!);
  }

  Future<void> logoutUser() async {
    await _googleSignInProvider.googleLogOut();
    await _firebaseAuthenticationProvider.firebaseLogout();
  }
}
