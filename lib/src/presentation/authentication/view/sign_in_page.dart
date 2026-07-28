import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/auth_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthStatus.authenticated:
            context.goNamed('home');
            break;
          case AuthStatus.error:
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? 'An error occurred')),
            );
            break;
          case AuthStatus.initial:
          case AuthStatus.loading:
          case AuthStatus.unauthenticated:
            break;
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Sign In')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Sign In Page'),
              // TODO: Add sign in form fields
            ],
          ),
        ),
      ),
    );
  }
}
