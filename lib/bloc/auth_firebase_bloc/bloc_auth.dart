import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_streaming_example/bloc/auth_firebase_bloc/auth_event.dart';
import 'package:video_streaming_example/bloc/auth_firebase_bloc/auth_state.dart';
import 'package:video_streaming_example/service/firebase_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  FireBaseService fireBaseService = FireBaseService();

  AuthBloc() : super(AuthStateInitial()) {
    on<RegisterEvent>(
          (event, emit) async {
        emit(AuthStateLoading());
        try {
          final user =
          await fireBaseService.registerUser(event.email, event.password);
          emit(AuthStateLoaded(user));
        } catch (e) {
          emit(AuthStateError("Registration failed: $e"));
        }
      },
    );
    on<SignInEvent>((event, emit) async {
      emit(AuthStateLoading());
      try {
        final userSignIn =
        await fireBaseService.signInUser(event.password, event.email);
        if (userSignIn != null) {
          emit(AuthStateLoaded(userSignIn));
        }
      } catch (e) {
        emit(AuthStateError("Sign in failed: $e"));
      }
    });
    on<SignOutEvent>((event, emit) async {
      emit(AuthStateLoading());
      try {
        await fireBaseService.signOut();
        emit(AuthStateUnauthenticated());
      } catch (e) {
        emit(AuthStateError("Sign out failed: $e"));
      }
    });
  }
}
