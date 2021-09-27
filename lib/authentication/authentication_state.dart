part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationFailed extends AuthenticationState {
  final String message;

  AuthenticationFailed(this.message);

  @override
  List<Object> get props => [message];
}

class AuthenticationSuccess extends AuthenticationState {
  final UserAuthDetails userAuthDetails;

  AuthenticationSuccess(this.userAuthDetails);

  @override
  List<Object> get props => [userAuthDetails];
}
