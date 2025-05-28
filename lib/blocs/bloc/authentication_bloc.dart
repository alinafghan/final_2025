import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:final_2025/models/my_user.dart';
import 'package:final_2025/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthRepository authRepository;
  late final StreamSubscription<User?> _userSubscription;

  AuthenticationBloc({required this.authRepository})
      : super(const AuthenticationState.unknown()) {
    _userSubscription = authRepository.user.listen((authUser) {
      //authentication usre event
      add(AuthenticationUserChanged(authUser));
      // add(AuthenticationLogoutRequested()); cant do this here because havent created an event handler as below
    });

    on<AuthenticationUserChanged>((event, emit) {
      //the pipeline here is FirebaseAuth.instance.authStateChanges().listen((User? user)
      if (event.user != null) {
        emit(AuthenticationState.authenticated(event.user!));
      } else {
        emit(const AuthenticationState.unauthenticated());
      }
    });
    on<GoogleSignupRequested>((event, emit) async {
      try {
        UserCredential user = await authRepository.signUpWithGoogle();
        if (user.user != null) {
          MyUser user2 = MyUser(
            userId: user.user!.uid,
            username: user.user!.displayName,
            email: user.user!.email!,
            profileUrl: user.user!.photoURL,
          );
          emit(GoogleSignUpSuccess(myUser: user2, user: user.user));
        }
      } catch (e) {
        emit(AuthenticationError(e.toString()));
      }
    });
    on<SaveUserToFirestore>((event, emit) async {
      try {
        await authRepository.saveUserToFirestore(event.user);
        emit(SaveUserToFirestoreSuccess());
      } catch (e) {
        emit(AuthenticationError(e.toString()));
      }
    });
    on<EmailSignupRequested>((event, emit) async {
      try {
        MyUser? user =
            await authRepository.emailSignUp(event.user, event.password);
        if (user != null) {
          add(SaveUserToFirestore(user: user));
        }
        emit(EmailSignupRequestedSuccess(myUser: user!));
      } catch (e) {
        emit(AuthenticationError(e.toString()));
      }
    });
    on<Logout>((event, emit) async {
      try {
        User? user = await authRepository.signOut();
        emit(LogoutSuccess());
      } catch (e) {
        emit(AuthenticationError(e.toString()));
      }
    });
  }
  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
