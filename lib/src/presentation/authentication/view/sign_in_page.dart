import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:trucky/common/widgets/widget_imports.dart';
import 'package:trucky/core/localization/app_strings.dart';
import 'package:trucky/core/localization/languages_services.dart';
import 'package:trucky/src/presentation/routes/app_routes.dart';

import '../bloc/auth_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onContinue() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        SignInRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final linkColor = const Color(0xFF0093B9);
    final buttonBackground = isDark
        ? colorScheme.surfaceContainerHighest
        : const Color(0xFFE8EBEF);
    final buttonForeground = colorScheme.onSurface;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state.status) {
          case AuthStatus.authenticated:
            context.goNamed(AppRoutes.home.name);
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
      child: PopScope(
        canPop: false,
        child: CustomScaffold(
          appBar: CustomAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            foregroundColor: colorScheme.onSurface,
            elevation: 0,
          ),
          body: SafeArea(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 26.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    73.verticalSpace,
                    Container(
                      height: 145.h,
                      width: 145.h,
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    22.verticalSpace,
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: LabelWidget(
                        text: context.tr(AppStrings.signIn),
                        textSize: 32.sp,
                        fontWeight: FontWeight.w700,
                        textColor: colorScheme.onSurface,
                      ),
                    ),
                    34.verticalSpace,
                    CustomTextFormField(
                      controller: _emailController,
                      hintText: context.tr(AppStrings.emailAddress),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email is required';
                        }
                        return null;
                      },
                    ),
                    16.verticalSpace,
                    CustomTextFormField(
                      controller: _passwordController,
                      hintText: context.tr(AppStrings.password),
                      obscureText: _obscurePassword,
                      suffixIcon: _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      onSuffixTap: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                      textInputAction: TextInputAction.done,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                    ),
                    16.verticalSpace,
                    CustomTextButton(
                      text: 'Forgot Password ? Click here',
                      textColor: linkColor,
                      textSize: 15.sp,
                      onTap: () {
                        // TODO: Navigate to forgot password
                      },
                    ),
                    60.verticalSpace,
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return CustomElevatedButton(
                          text: context.tr(AppStrings.continueBtn),
                          isLoading: state.status == AuthStatus.loading,
                          onPressed: _onContinue,
                          backgroundColor: buttonBackground,
                          foregroundColor: buttonForeground,
                          height: 56.h,
                          radius: 100.r,
                        );
                      },
                    ),
                    24.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LabelWidget(
                          text: context.tr(AppStrings.dontHaveAnAccount),
                          textSize: 15.sp,
                          textColor: linkColor,
                        ),
                        4.horizontalSpace,
                        CustomTextButton(
                          text: context.tr(AppStrings.signUpHere),
                          textColor: linkColor,
                          textSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          onTap: () => context.goNamed(AppRoutes.signUp.name),
                        ),
                      ],
                    ),
                    30.verticalSpace,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
