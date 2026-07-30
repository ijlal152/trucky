import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:trucky/common/widgets/widget_imports.dart';
import 'package:trucky/core/app_assets/app_assets.dart';
import 'package:trucky/src/presentation/authentication/bloc/auth_bloc.dart';
import 'package:trucky/src/presentation/routes/app_routes.dart';
import 'package:trucky/src/presentation/settings/bloc/settings_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingsState) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, authState) {
            if (authState.status == AuthStatus.unauthenticated) {
              context.goNamed(AppRoutes.signIn.name);
            }
          },
          child: CustomScaffold(
            appBar: CustomAppBar(
              title: "Settings",
              backgroundColor: Colors.transparent,
              foregroundColor: Theme.of(context).colorScheme.onSurface,
              leadingIconColor: Theme.of(context).colorScheme.onSurface,
            ),
            body: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              children: [
                // ── Account Section ──────────────────────────────────
                _SettingsSection(
                  title: "Account",
                  children: [
                    _SettingsTile(
                      icon: AppAssets.images.personalInfo,
                      title: "Personal information",
                      onTap: () {
                        // TODO: Navigate to personal info
                      },
                    ),
                    _SettingsTile(
                      icon: AppAssets.images.lock,
                      title: "Security",
                      onTap: () {
                        // TODO: Navigate to security
                      },
                    ),
                  ],
                ),

                24.verticalSpace,

                // ── Preferences Section ──────────────────────────────
                _SettingsSection(
                  title: "Preferences",
                  children: [
                    _SettingsTile(
                      icon: AppAssets.images.language,
                      title: "Language",
                      trailing: Text(
                        settingsState.language.toUpperCase(),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      onTap: () => _showLanguagePicker(context),
                    ),
                    _SettingsTile(
                      icon: AppAssets.images.currency,
                      title: "Currency",
                      trailing: Text(
                        "USD",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      onTap: () {
                        // TODO: Navigate to currency picker
                      },
                    ),
                  ],
                ),

                24.verticalSpace,

                // ── Features Section ─────────────────────────────────
                _SettingsSection(
                  title: "Features",
                  children: [
                    _SettingsTile(
                      icon: AppAssets.images.share,
                      title: "Printing",
                      onTap: () {
                        // TODO: Navigate to printing settings
                      },
                    ),
                    _SettingsTile(
                      icon: AppAssets.images.personalInfo,
                      title: "Analysis",
                      onTap: () {
                        // TODO: Navigate to analysis settings
                      },
                    ),
                    _SettingsTile(
                      icon: AppAssets.images.subscription,
                      title: "Subscription",
                      onTap: () {
                        // TODO: Navigate to subscription
                      },
                    ),
                    _SettingsTile(
                      icon: AppAssets.images.backup,
                      title: "Backup status",
                      onTap: () {
                        // TODO: Navigate to backup
                      },
                    ),
                  ],
                ),

                24.verticalSpace,

                // ── Support Section ──────────────────────────────────
                _SettingsSection(
                  title: "Support",
                  children: [
                    _SettingsTile(
                      icon: AppAssets.images.terms,
                      title: "Terms & conditions",
                      onTap: () {
                        // TODO: Open terms
                      },
                    ),
                    _SettingsTile(
                      icon: AppAssets.images.privacy,
                      title: "Privacy policy",
                      onTap: () {
                        // TODO: Open privacy policy
                      },
                    ),
                    _SettingsTile(
                      icon: AppAssets.images.help,
                      title: "Help",
                      onTap: () {
                        // TODO: Open help
                      },
                    ),
                  ],
                ),

                24.verticalSpace,

                // ── Logout ───────────────────────────────────────────
                Padding(
                  padding: EdgeInsets.only(bottom: 32.h),
                  child: _SettingsTile(
                    icon: AppAssets.images.logout,
                    title: "Logout",
                    titleColor: Colors.redAccent,
                    showChevron: false,
                    onTap: () => _confirmLogout(context),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLanguagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LabelWidget(
                text: "Select Language",
                textSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              16.verticalSpace,
              ListTile(
                title: const Text("English"),
                trailing: const Icon(Icons.check),
                onTap: () {
                  context.read<SettingsBloc>().add(
                    const UpdateLanguage(language: 'en'),
                  );
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                title: const Text("العربية"),
                trailing: const Icon(Icons.check),
                onTap: () {
                  context.read<SettingsBloc>().add(
                    const UpdateLanguage(language: 'ar'),
                  );
                  Navigator.pop(ctx);
                },
              ),
              ListTile(
                title: const Text("Français"),
                trailing: const Icon(Icons.check),
                onTap: () {
                  context.read<SettingsBloc>().add(
                    const UpdateLanguage(language: 'fr'),
                  );
                  Navigator.pop(ctx);
                },
              ),
              16.verticalSpace,
            ],
          ),
        );
      },
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<AuthBloc>().add(const SignOutRequested());
            },
            child: Text("Logout", style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Section Header
// ─────────────────────────────────────────────────────────────────────────────

class _SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SettingsSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
          child: LabelWidget(
            text: title,
            textSize: 13.sp,
            fontWeight: FontWeight.w600,
            textColor: cs.onSurfaceVariant,
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8.r,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: List.generate(children.length, (index) {
              return Column(
                children: [
                  if (index > 0)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Divider(
                        color: cs.outlineVariant,
                        height: 1,
                        thickness: 0.5,
                      ),
                    ),
                  children[index],
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  Settings Tile
// ─────────────────────────────────────────────────────────────────────────────

class _SettingsTile extends StatelessWidget {
  final String icon;
  final String title;
  final Widget? trailing;
  final Color? titleColor;
  final bool showChevron;
  final VoidCallback? onTap;

  const _SettingsTile({
    required this.icon,
    required this.title,
    this.trailing,
    this.titleColor,
    this.showChevron = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16.r),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              // Icon
              Container(
                width: 36.h,
                height: 36.h,
                padding: EdgeInsets.all(8.h),
                decoration: BoxDecoration(
                  color: cs.surfaceContainerHighest.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Image.asset(icon, height: 20.h, width: 20.h),
              ),
              12.horizontalSpace,
              // Title
              Expanded(
                child: LabelWidget(
                  text: title,
                  textSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  textColor: titleColor ?? cs.onSurface,
                ),
              ),
              // Trailing widget
              if (trailing != null) ...[SizedBox(width: 8.w), trailing!],
              // Chevron
              if (showChevron)
                Icon(
                  Icons.chevron_right_rounded,
                  size: 22.sp,
                  color: cs.onSurfaceVariant,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
