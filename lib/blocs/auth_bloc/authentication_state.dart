part of 'authentication_bloc.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationState extends Equatable {
  final AuthenticationStatus status;

  final User? user;

  const AuthenticationState(
      {this.status = AuthenticationStatus.unknown, this.user});

  const AuthenticationState.unknown()
      : this(); //if state is unknown return empty state

  const AuthenticationState.authenticated(User user)
      : this(status: AuthenticationStatus.authenticated, user: user);

  const AuthenticationState.unauthenticated()
      : this(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object?> get props => [status, user];
}

class GoogleSignUpSuccess extends AuthenticationState {
  @override
  final User? user;
  final MyUser myUser;

  const GoogleSignUpSuccess({required this.myUser, this.user})
      : super(status: AuthenticationStatus.authenticated, user: user);

  @override
  List<Object?> get props => [status, user];
}

class SaveUserToFirestoreSuccess extends AuthenticationState {}

class EmailSignupRequestedSuccess extends AuthenticationState {
  final User? user;
  @override
  final MyUser myUser;

  const EmailSignupRequestedSuccess({required this.myUser, this.user})
      : super(status: AuthenticationStatus.authenticated, user: user);

  @override
  List<Object?> get props => [status, user];
}

class AuthenticationError extends AuthenticationState {
  final String message;

  const AuthenticationError(this.message)
      : super(status: AuthenticationStatus.unauthenticated);

  @override
  List<Object?> get props => [status, message];
}

class LogoutSuccess extends AuthenticationState {}
