import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:trucky/common/widgets/widget_imports.dart';
import 'package:trucky/core/localization/app_strings.dart';
import 'package:trucky/core/localization/languages_services.dart';
import 'package:trucky/src/presentation/authentication/bloc/auth_bloc.dart';
import 'package:trucky/src/presentation/authentication/widgets/auth_widgets.dart';
import 'package:trucky/src/presentation/routes/app_routes.dart';

class SignUpPageOne extends StatefulWidget {
  const SignUpPageOne({super.key});

  @override
  State<SignUpPageOne> createState() => _SignUpPageOneState();
}

class _SignUpPageOneState extends State<SignUpPageOne> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged(String value) {
    context.read<AuthBloc>().add(ValidateEmailRequested(email: value));
  }

  void _onPasswordChanged(String value) {
    context.read<AuthBloc>().add(ValidatePasswordRequested(password: value));
  }

  void _onContinue() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        SignUpStepOneRequested(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.stepOneVerified) {
          context.goNamed(AppRoutes.signUpStepTwo.name);
        } else if (state.status == AuthStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'An error occurred')),
          );
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
            actions: [ShowStepsWidget(title: context.tr(AppStrings.step1Of2))],
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                      text: context.tr(AppStrings.signUp),
                      textSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      textColor: colorScheme.onSurface,
                    ),
                  ),
                  10.verticalSpace,
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: LabelWidget(
                      text: context.tr(AppStrings.weAskForYourInfo),
                      fontWeight: FontWeight.w500,
                      textSize: 15.sp,
                      textColor: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  20.verticalSpace,
                  CustomTextFormField(
                    controller: _emailController,
                    hintText: context.tr(AppStrings.emailAddress),
                    labelText: context.tr(AppStrings.emailAddress),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onChanged: _onEmailChanged,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email is required';
                      }
                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );
                      if (!emailRegex.hasMatch(value.trim())) {
                        return 'Invalid email format';
                      }
                      return null;
                    },
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return TextFieldValidationError(
                        requiredParameter: 'Email is not valid',
                        isValid: state.isValidEmail,
                      );
                    },
                  ),
                  10.verticalSpace,
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return CustomTextFormField(
                        controller: _passwordController,
                        hintText: context.tr(AppStrings.password),
                        labelText: context.tr(AppStrings.password),
                        obscureText: state.passwordObscure,
                        textInputAction: TextInputAction.done,
                        onChanged: _onPasswordChanged,
                        suffixIcon: state.passwordObscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                        onSuffixTap: () => context.read<AuthBloc>().add(
                          const TogglePasswordVisibilityRequested(),
                        ),
                      );
                    },
                  ),
                  20.verticalSpace,
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return PasswordValidationWidget(
                        isValidPasswordLength: state.isValidPasswordLength,
                        hasUppercaseSymbol: state.hasUppercaseSymbol,
                        hasANumber: state.hasANumber,
                      );
                    },
                  ),
                  30.verticalSpace,
                ],
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomNavBarWidget(
            navBarColor: Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: 30.h),
            widget: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AlreadyHaveAccountWidget(
                  btnText: context.tr(AppStrings.signInHere),
                  text: context.tr(AppStrings.alreadyHaveAnAccount),
                  onTap: () {
                    context.read<AuthBloc>().add(
                      const ResetAuthStateRequested(),
                    );
                    context.goNamed(AppRoutes.signIn.name);
                  },
                ),
                const TermsOfUseAndPrivacyPolicy(),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: CustomElevatedButton(
                        text: context.tr(AppStrings.continueBtn),
                        isLoading: state.isLoading,
                        onPressed: _onContinue,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
