import 'package:get/get.dart';

class AppStrings {
  static final AppStrings _instance = AppStrings._internal();

  AppStrings._internal();

  factory AppStrings() {
    return _instance;
  }

  // Authentication
  static String get signUp => "signUp".tr;
  static String get signIn => "signIn".tr;
  static String get weAskForYourInfo => "weAskForYourInfo".tr;
  static String get emailAddress => "emailAddress".tr;
  static String get password => "password".tr;
  static String get hasAtLeast8Characters => "hasAtLeast8Characters".tr;
  static String get hasAnUpperCaseLetterOrSymbol =>
      "hasAnUpperCaseLetterOrSymbol".tr;
  static String get hasANumber => "hasANumber".tr;
  static String get alreadyHaveAnAccount => "alreadyHaveAnAccount".tr;
  static String get dontHaveAnAccount => "dontHaveAnAccount".tr;
  static String get signInHere => "signInHere".tr;
  static String get signUpHere => "signUpHere".tr;
  static String get byUsingOrMobileAppYouAgree =>
      "byUsingOrMobileAppYouAgree".tr;
  static String get termsofUse => "termsofUse".tr;
  static String get and => "and".tr;
  static String get privacyPolicy => "privacyPolicy".tr;
  static String get continueBtn => "continueBtn".tr;
  static String get fullName => "fullName".tr;
  static String get phoneNumber => "phoneNumber".tr;
  static String get businessName => "businessName".tr;
  static String get address => "address".tr;

  // Dashboard
  static String get exit => "exit".tr;
  static String get realyWantToExit => "realyWantToExit".tr;
  static String get sells => "sells".tr;
  static String get sales => "sales".tr;
  static String get purchases => "purchases".tr;
  static String get suppliers => "suppliers".tr;
  static String get clients => "clients".tr;
  static String get products => "products".tr;
  static String get treasury => "treasury".tr;
  static String get analysis => "analysis".tr;

  // Settings
  static String get settings => "settings".tr;
  static String get personalInfo => "personalInfo".tr;
  static String get security => "security".tr;
  static String get language => "language".tr;
  static String get currency => "currency".tr;
  static String get printing => "printing".tr;
  static String get subscription => "subscription".tr;
  static String get backUpStatus => "backUpStatus".tr;
  static String get termsAndConditions => "termsAndConditions".tr;
  static String get privacyPolicy2 => "privacyPolicy2".tr;
  static String get help => "help".tr;
  static String get logout => "logout".tr;
}
