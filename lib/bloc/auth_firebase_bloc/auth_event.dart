

import 'package:equatable/equatable.dart';

abstract class AuthEvent{}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;

  RegisterEvent({
    required this.email,
    required this.password,
  });

}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  SignInEvent({
    required this.email,
    required this.password,
  });

}

class SignOutEvent extends AuthEvent {}
