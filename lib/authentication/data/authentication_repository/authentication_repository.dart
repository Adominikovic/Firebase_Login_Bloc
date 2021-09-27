import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/authentication/data/providers/firebase_auth_provider.dart';
import 'package:firebase_login/authentication/data/providers/google_sign_in_provider.dart';
import 'package:firebase_login/authentication/models/user_auth_details.dart';

class AuthenticationRepository {
  final FirebaseAuthenticationProvider _authenticationFirebaseProvider;
  final GoogleSignInProvider _googleSignInProvider;

  AuthenticationRepository(
      this._authenticationFirebaseProvider, this._googleSignInProvider);

  Stream<UserAuthDetails> getAuthDetailStream() {
    return _authenticationFirebaseProvider.getAuthStates().map((user) {
      return _getAuthCredentialFromFirebaseUser(user: user);
    });
  }

  Future<UserAuthDetails> getCredentialWithGoogle() async {
    User? user = await _authenticationFirebaseProvider
        .firebaseLogin(await _googleSignInProvider.googleLogIn());
    return _getAuthCredentialFromFirebaseUser(user: user);
  }

  Future<void> unAuthenticate() async {
    await _googleSignInProvider.googleLogOut();
    await _authenticationFirebaseProvider.firebaseLogout();
  }

  UserAuthDetails _getAuthCredentialFromFirebaseUser({required User? user}) {
    UserAuthDetails authDetail;
    if (user != null) {
      authDetail = UserAuthDetails(
        true,
        user.uid,
        user.email,
        user.photoURL,
        user.displayName,
      );
    } else {
      authDetail = UserAuthDetails(false, '', '', '', '');
    }
    return authDetail;
  }
}
