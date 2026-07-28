import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:trucky/common/widgets/widget_imports.dart';
import 'package:trucky/core/localization/app_strings.dart';
import 'package:trucky/core/localization/languages_services.dart';
import 'package:trucky/src/presentation/authentication/bloc/auth_bloc.dart';
import 'package:trucky/src/presentation/authentication/widgets/auth_widgets.dart';
import 'package:trucky/src/presentation/authentication/widgets/country_code_bottom_sheet.dart';
import 'package:trucky/src/presentation/routes/app_routes.dart';

class SignUpPageTwo extends StatefulWidget {
  const SignUpPageTwo({super.key});

  @override
  State<SignUpPageTwo> createState() => _SignUpPageTwoState();
}

class _SignUpPageTwoState extends State<SignUpPageTwo> {
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _businessNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _businessNameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _onContinue() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(
        SignUpStepTwoRequested(
          fullName: _fullNameController.text.trim(),
          phoneNumber: _phoneController.text.trim(),
          dialCode: context.read<AuthBloc>().state.dialCode ?? '+213',
          businessName: _businessNameController.text.trim(),
          address: _addressController.text.trim(),
        ),
      );
    }
  }

  void _showCountryCodeBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CountryCodeBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          context.goNamed(AppRoutes.home.name);
        } else if (state.status == AuthStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'An error occurred')),
          );
        }
      },
      child: PopScope(
        canPop: true,
        child: CustomScaffold(
          appBar: CustomAppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Colors.transparent,
            foregroundColor: colorScheme.onSurface,
            elevation: 0,
            actions: [ShowStepsWidget(title: context.tr(AppStrings.step2Of2))],
          ),
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 26.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        30.verticalSpace,
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
                        30.verticalSpace,
                        CustomTextFormField(
                          controller: _fullNameController,
                          hintText: context.tr(AppStrings.fullName),
                          labelText: context.tr(AppStrings.fullName),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Full name is required';
                            }
                            return null;
                          },
                        ),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: TextFieldValidationError(
                                requiredParameter: 'Full name is required',
                                isValid: !state.isNameRequired,
                              ),
                            );
                          },
                        ),
                        20.verticalSpace,
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: _showCountryCodeBottomSheet,
                              child: Container(
                                height: 64.h,
                                decoration: BoxDecoration(
                                  color: colorScheme.surface,
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: colorScheme.outline,
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 90.w,
                                      color: colorScheme.surface,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          LabelWidget(
                                            text: state.dialCode ?? '+213',
                                            textSize: 17.sp,
                                            fontWeight: FontWeight.normal,
                                            textColor: colorScheme.onSurface,
                                          ),
                                          4.horizontalSpace,
                                          Icon(
                                            Icons.keyboard_arrow_down,
                                            size: 24.sp,
                                            color: colorScheme.onSurfaceVariant,
                                          ),
                                        ],
                                      ),
                                    ),
                                    VerticalDivider(
                                      indent: 15.h,
                                      endIndent: 15.h,
                                      thickness: 1,
                                      color: colorScheme.outlineVariant,
                                    ),
                                    Flexible(
                                      child: CustomTextFormField(
                                        controller: _phoneController,
                                        hintText: context.tr(
                                          AppStrings.phoneNumber,
                                        ),
                                        labelText: context.tr(
                                          AppStrings.phoneNumber,
                                        ),
                                        keyboardType: TextInputType.phone,
                                        textInputAction: TextInputAction.next,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Phone number is required';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: TextFieldValidationError(
                                requiredParameter: 'Phone number is required',
                                isValid: !state.isPhoneRequired,
                              ),
                            );
                          },
                        ),
                        20.verticalSpace,
                        CustomTextFormField(
                          controller: _businessNameController,
                          hintText: context.tr(AppStrings.businessName),
                          labelText: context.tr(AppStrings.businessName),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Business name is required';
                            }
                            return null;
                          },
                        ),
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: TextFieldValidationError(
                                requiredParameter: 'Business name is required',
                                isValid: !state.isBusinessRequired,
                              ),
                            );
                          },
                        ),
                        20.verticalSpace,
                        CustomTextFormField(
                          controller: _addressController,
                          hintText: context.tr(AppStrings.address),
                          labelText: context.tr(AppStrings.address),
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => _onContinue(),
                        ),
                        30.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: CustomBottomNavBarWidget(
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
                10.verticalSpace,
                const TermsOfUseAndPrivacyPolicy(),
                20.verticalSpace,
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: CustomElevatedButton(
                        text: context.tr(AppStrings.continueBtn),
                        isLoading: state.isLoading,
                        onPressed: _onContinue,
                        backgroundColor: isDark
                            ? colorScheme.surfaceContainerHighest
                            : const Color(0xFFE8EBEF),
                        foregroundColor: colorScheme.onSurface,
                        height: 56.h,
                        radius: 100.r,
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
