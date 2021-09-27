part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStarted extends AuthenticationEvent {}

class AuthenticationStateChange extends AuthenticationEvent {
  final UserAuthDetails userAuthDetails;

  AuthenticationStateChange(this.userAuthDetails);

  @override
  List<Object> get props => [userAuthDetails];
}

class GoogleAuthenticationStarted extends AuthenticationEvent {}

class AuthenticationEnded extends AuthenticationEvent {}
