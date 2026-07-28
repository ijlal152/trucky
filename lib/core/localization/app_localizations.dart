import 'dart:ui';

import 'package:trucky/core/localization/app_strings.dart';

final Map<String, Map<String, String>> _allTranslations = {
  'en-US': _en,
  'ar-SA': _ar,
  'fr-FR': _fr,
};

class AppLocalizationData {
  AppLocalizationData._();

  static String translate(String key, Locale locale) {
    final tag = locale.toLanguageTag();

    // 1) Try exact locale tag
    final exact = _allTranslations[tag]?[key];
    if (exact != null) return exact;

    // 2) Try matching on language code only
    for (final entry in _allTranslations.entries) {
      if (entry.key.startsWith('${locale.languageCode}-')) {
        final match = entry.value[key];
        if (match != null) return match;
      }
    }

    // 3) Fallback to English
    return _allTranslations['en-US']?[key] ?? key;
  }
}

const Map<String, String> _en = {
  // ─── Authentication ───────────────────────────────────────────────
  AppStrings.signUp: 'Sign Up',
  AppStrings.signIn: 'Sign In',
  AppStrings.weAskForYourInfo:
      'We ask for your informations to keep your data safe and secure',
  AppStrings.emailAddress: 'Email address',
  AppStrings.password: 'Password',
  AppStrings.hasAtLeast8Characters: 'Has at least 8 characters',
  AppStrings.hasAnUpperCaseLetterOrSymbol: 'Has an upper case letter or symbol',
  AppStrings.hasANumber: 'Has a number',
  AppStrings.alreadyHaveAnAccount: 'Already have an account ?',
  AppStrings.dontHaveAnAccount: "Don't have an account ?",
  AppStrings.signInHere: 'Sign In here',
  AppStrings.signUpHere: 'Sign Up here',
  AppStrings.byUsingOrMobileAppYouAgree:
      'By using or mobile app, you agree to our',
  AppStrings.termsofUse: 'Terms of Use',
  AppStrings.and: 'and',
  AppStrings.privacyPolicy: 'Privacy Policy',
  AppStrings.continueBtn: 'Continue',
  AppStrings.fullName: 'Full Name',
  AppStrings.phoneNumber: 'Phone Number',
  AppStrings.businessName: 'Business Name',
  AppStrings.address: 'Address',

  // ─── Dashboard ─────────────────────────────────────────────────────
  AppStrings.exit: 'Exit',
  AppStrings.realyWantToExit: 'Do you really want to exit?',
  AppStrings.sells: 'Sells',
  AppStrings.sales: 'Sales',
  AppStrings.purchases: 'Purchases',
  AppStrings.suppliers: 'Suppliers',
  AppStrings.clients: 'Clients',
  AppStrings.products: 'Products',
  AppStrings.treasury: 'Treasury',
  AppStrings.analysis: 'Analysis',

  // ─── Settings ──────────────────────────────────────────────────────
  AppStrings.settings: 'Settings',
  AppStrings.personalInfo: 'Personal information',
  AppStrings.security: 'Security',
  AppStrings.language: 'Language',
  AppStrings.currency: 'Currency',
  AppStrings.printing: 'Printing',
  AppStrings.subscription: 'Subscription',
  AppStrings.backUpStatus: 'Backup status',
  AppStrings.termsAndConditions: 'Terms & conditions',
  AppStrings.privacyPolicy2: 'Privacy policy',
  AppStrings.help: 'Help',
  AppStrings.logout: 'Logout',
};

const Map<String, String> _ar = {
  AppStrings.signUp: 'التسجيل',
  AppStrings.signIn: 'تسجيل الدخول',
  AppStrings.weAskForYourInfo: 'نطلب معلوماتك للحفاظ على بياناتك آمنة ومأمونة',
  AppStrings.emailAddress: 'عنوان البريد الإلكتروني',
  AppStrings.password: 'كلمة المرور',
  AppStrings.hasAtLeast8Characters: 'يحتوي على 8 أحرف على الأقل',
  AppStrings.hasAnUpperCaseLetterOrSymbol: 'يحتوي على حرف كبير أو رمز',
  AppStrings.hasANumber: 'يحتوي على رقم',
  AppStrings.alreadyHaveAnAccount: 'هل لديك حساب بالفعل؟',
  AppStrings.dontHaveAnAccount: 'لا تملك حسابًا؟',
  AppStrings.signInHere: 'سجل الدخول هنا',
  AppStrings.signUpHere: 'سجل هنا',
  AppStrings.byUsingOrMobileAppYouAgree:
      'باستخدام تطبيقنا المحمول، فإنك توافق على',
  AppStrings.termsofUse: 'شروط الاستخدام',
  AppStrings.and: 'و',
  AppStrings.privacyPolicy: 'سياسة الخصوصية',
  AppStrings.continueBtn: 'استمر',
  AppStrings.fullName: 'الاسم الكامل',
  AppStrings.phoneNumber: 'رقم الهاتف',
  AppStrings.businessName: 'اسم العمل',
  AppStrings.address: 'العنوان',

  AppStrings.exit: 'الخروج',
  AppStrings.realyWantToExit: 'هل تريد حقًا الخروج؟',
  AppStrings.sells: 'المبيعات',
  AppStrings.purchases: 'المشتريات',
  AppStrings.suppliers: 'الموردون',
  AppStrings.clients: 'العملاء',
  AppStrings.products: 'المنتجات',
  AppStrings.treasury: 'الخزانة',
  AppStrings.analysis: 'التحليل',

  AppStrings.settings: 'الإعدادات',
  AppStrings.personalInfo: 'المعلومات الشخصية',
  AppStrings.security: 'الأمان',
  AppStrings.language: 'اللغة',
  AppStrings.currency: 'العملة',
  AppStrings.printing: 'الطباعة',
  AppStrings.subscription: 'الاشتراك',
  AppStrings.backUpStatus: 'حالة النسخ الاحتياطي',
  AppStrings.termsAndConditions: 'الشروط والأحكام',
  AppStrings.privacyPolicy2: 'سياسة الخصوصية',
  AppStrings.help: 'المساعدة',
  AppStrings.logout: 'تسجيل الخروج',
};

const Map<String, String> _fr = {
  AppStrings.signUp: "S'inscrire",
  AppStrings.signIn: 'Se connecter',
  AppStrings.weAskForYourInfo:
      'Nous demandons vos informations pour garder vos données en sécurité',
  AppStrings.emailAddress: 'Adresse e-mail',
  AppStrings.password: 'Mot de passe',
  AppStrings.hasAtLeast8Characters: 'Contient au moins 8 caractères',
  AppStrings.hasAnUpperCaseLetterOrSymbol:
      'Contient une majuscule ou un symbole',
  AppStrings.hasANumber: 'Contient un chiffre',
  AppStrings.alreadyHaveAnAccount: 'Vous avez déjà un compte ?',
  AppStrings.dontHaveAnAccount: "Vous n'avez pas de compte ?",
  AppStrings.signInHere: 'Connectez-vous ici',
  AppStrings.signUpHere: "Inscrivez-vous ici",
  AppStrings.byUsingOrMobileAppYouAgree:
      'En utilisant notre application mobile, vous acceptez nos',
  AppStrings.termsofUse: "Conditions d'utilisation",
  AppStrings.and: 'et',
  AppStrings.privacyPolicy: 'Politique de confidentialité',
  AppStrings.continueBtn: 'Continuer',
  AppStrings.fullName: 'Nom complet',
  AppStrings.phoneNumber: 'Numéro de téléphone',
  AppStrings.businessName: "Nom de l'entreprise",
  AppStrings.address: 'Adresse',

  AppStrings.exit: 'Quitter',
  AppStrings.realyWantToExit: 'Voulez-vous vraiment quitter?',
  AppStrings.sells: 'Ventes',
  AppStrings.purchases: 'Achats',
  AppStrings.suppliers: 'Fournisseurs',
  AppStrings.clients: 'Clients',
  AppStrings.products: 'Produits',
  AppStrings.treasury: 'Trésorerie',
  AppStrings.analysis: 'Analyse',

  AppStrings.settings: 'Paramètres',
  AppStrings.personalInfo: 'Informations personnelles',
  AppStrings.security: 'Sécurité',
  AppStrings.language: 'Langue',
  AppStrings.currency: 'Devise',
  AppStrings.printing: 'Impression',
  AppStrings.subscription: 'Abonnement',
  AppStrings.backUpStatus: 'État de la sauvegarde',
  AppStrings.termsAndConditions: 'Conditions générales',
  AppStrings.privacyPolicy2: 'Politique de confidentialité',
  AppStrings.help: 'Aide',
  AppStrings.logout: 'Se déconnecter',
};
