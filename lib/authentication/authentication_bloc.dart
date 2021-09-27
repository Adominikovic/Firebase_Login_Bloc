import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_login/authentication/data/authentication_repository/authentication_repository.dart';
import 'package:firebase_login/authentication/models/user_auth_details.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;

  AuthenticationBloc(this._authenticationRepository)
      : super(AuthenticationInitial());

  StreamSubscription<UserAuthDetails>? authDetailsStream;

  @override
  Future<void> close() {
    authDetailsStream?.cancel();
    return super.close();
  }

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStarted) {
      try {
        yield AuthenticationLoading();
        authDetailsStream = _authenticationRepository
            .getAuthDetailStream()
            .listen((authDetails) {
          add(
            AuthenticationStateChange(authDetails),
          );
        });
      } catch (error) {
        print(
            'Error has occurred while trying to authenticate: ${error.toString()}');
        yield AuthenticationFailed('Authentication failed.');
      }
    } else if (event is AuthenticationStateChange) {
      if (event.userAuthDetails.isValid) {
        yield AuthenticationSuccess(event.userAuthDetails);
      } else {
        yield AuthenticationFailed('User logged out.');
      }
    } else if (event is GoogleAuthenticationStarted) {
      try {
        yield AuthenticationLoading();
        UserAuthDetails userAuthDetails =
            await _authenticationRepository.getCredentialWithGoogle();
        if (userAuthDetails.isValid) {
          yield AuthenticationSuccess(userAuthDetails);
        } else {
          yield AuthenticationFailed('User auth details not found.');
        }
      } catch (error) {
        print('Error has occurred with Google login: ${error.toString()}');
        yield AuthenticationFailed('Authentication failed.');
      }
    } else if (event is AuthenticationEnded) {
      try {
        yield AuthenticationLoading();
        await _authenticationRepository.unAuthenticate();
      } catch (error) {
        print('Error has occurred during logout: ${error.toString()}');
        yield AuthenticationFailed('Logout failed.');
      }
    }
  }
}
