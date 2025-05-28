part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUserChanged extends AuthenticationEvent {
  final User? user;

  const AuthenticationUserChanged(this.user);

  // @override
  // List<Object> get props => [user!]; //cant be sure user wont be null
}

// class AuthenticationLogoutRequested extends AuthenticationEvent {}

// class AuthenticationLoginRequested extends AuthenticationEvent {
//   final String email;
//   final String password;
//   final String username;

//   const AuthenticationLoginRequested(this.email, this.password, this.username);

//   @override
//   List<Object> get props => [email, password, username];
// }

// class AuthenticationSignUpRequested extends AuthenticationEvent {
//   final String email;
//   final String password;
//   final String username;

//   const AuthenticationSignUpRequested(this.email, this.password, this.username);

//   @override
//   List<Object> get props => [email, password, username];
// }

class GoogleSignupRequested extends AuthenticationEvent {
  const GoogleSignupRequested();

  @override
  List<Object> get props => [];
}

class EmailSignupRequested extends AuthenticationEvent {
  final MyUser user;
  final String password;

  const EmailSignupRequested({required this.user, required this.password});

  @override
  List<Object> get props => [user, password];
}

class SaveUserToFirestore extends AuthenticationEvent {
  final MyUser user;

  const SaveUserToFirestore({required this.user});

  @override
  List<Object> get props => [user];
}

class Logout extends AuthenticationEvent {}
