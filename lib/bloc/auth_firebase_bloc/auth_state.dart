import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState{}
class AuthStateInitial extends AuthState{
}

class AuthStateLoading extends AuthState{
}
class AuthStateLoaded extends AuthState{
  final User? user;
  AuthStateLoaded(this.user);
}

class AuthStateError extends AuthState{
  final String messageError;
  AuthStateError(this.messageError);
}

class AuthStateUnauthenticated extends AuthState {}