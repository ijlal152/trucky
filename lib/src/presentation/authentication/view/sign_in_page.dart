import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:trucky/common/widgets/widget_imports.dart';
import 'package:trucky/core/localization/app_strings.dart';
import 'package:trucky/core/localization/languages_services.dart';
import 'package:trucky/src/presentation/routes/app_routes.dart';

import '../bloc/auth_bloc.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          appBar: const CustomAppBar(automaticallyImplyLeading: false),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 145.h,
                      width: 145.h,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    20.verticalSpace,
                    Align(
                      alignment: Alignment.topLeft,
                      child: LabelWidget(
                        text: context.tr(AppStrings.signIn),
                        textSize: 32.sp,
                      ),
                    ),
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
