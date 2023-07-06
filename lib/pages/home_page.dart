import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_streaming_example/bloc/auth_firebase_bloc/auth_event.dart';
import 'package:video_streaming_example/bloc/auth_firebase_bloc/auth_state.dart';
import 'package:video_streaming_example/bloc/auth_firebase_bloc/bloc_auth.dart';
import 'package:video_streaming_example/common/validation_rules.dart';
import 'package:video_streaming_example/pages/mosaic_player.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold content
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStateLoaded) {
               Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const MosaicPlayerRtsp(),
              ));
          } else if(state is AuthStateUnauthenticated){
               Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>  LoginScreen(),
                ));
          }
        },
        builder: (context, state) {
          if (state is AuthStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  validator: (value) {
                    return Validator().validateEmail(value ?? 'Bad email');
                  },
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: InputBorder.none,
                    icon: Icon(Icons.email, color: Colors.red),
                  ),
                ),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    return Validator()
                        .validatePassword(value ?? 'Bad password');
                  },
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    border: InputBorder.none,
                    icon: Icon(Icons.lock, color: Colors.red),
                  ),
                ),
                const SizedBox(height: 20.0),
                const SizedBox(height: 10.0),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      if (_validateFields(context)) {
                        String email = _emailController.text;
                        String password = _passwordController.text;
                        BlocProvider.of<AuthBloc>(context).add(
                          RegisterEvent(email: email, password: password),
                        );
                      }
                    },
                    child: const Text('Register'),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      if (_validateFields(context)) {
                        String email = _emailController.text;
                        String password = _passwordController.text;
                        BlocProvider.of<AuthBloc>(context).add(
                          SignInEvent(email: email, password: password),
                        );
                      }
                    },
                    child: const Text('Sign In'),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }

  bool _validateFields(BuildContext context) {
    String emailError = Validator().validateEmail(_emailController.text);
    String passwordError = Validator().validatePassword(_passwordController.text);

    if (emailError.isNotEmpty) {
      showSnackBarError(context, emailError);
    }

    if (passwordError.isNotEmpty) {
      showSnackBarError(context, passwordError);
    }

    return true;
  }
  void showSnackBarError(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
