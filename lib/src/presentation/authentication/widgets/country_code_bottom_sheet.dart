import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trucky/common/widgets/widget_imports.dart';
import 'package:trucky/core/localization/app_strings.dart';
import 'package:trucky/core/localization/languages_services.dart';
import 'package:trucky/src/presentation/authentication/bloc/auth_bloc.dart';

class CountryCodeBottomSheet extends StatefulWidget {
  const CountryCodeBottomSheet({super.key});

  @override
  State<CountryCodeBottomSheet> createState() => _CountryCodeBottomSheetState();
}

class _CountryCodeBottomSheetState extends State<CountryCodeBottomSheet> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const DividerWidget(),
              10.verticalSpace,
              LabelWidget(
                text: context.tr(AppStrings.selectCountry),
                textSize: 18.sp,
                fontWeight: FontWeight.w600,
                textColor: colorScheme.onSurface,
              ),
              20.verticalSpace,
              CustomTextFormField(
                controller: _searchController,
                hintText: context.tr(AppStrings.searchCountry),
                prefixIcon: Icons.search,
                onChanged: (value) {
                  context.read<AuthBloc>().add(SearchCountryCodeRequested(query: value));
                },
              ),
              10.verticalSpace,
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: state.filteredCountryCodes.length,
                  itemBuilder: (context, index) {
                    final country = state.filteredCountryCodes[index];
                    return GestureDetector(
                      onTap: () {
                        context.read<AuthBloc>().add(SelectCountryCodeRequested(index: index));
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 70.w,
                              child: LabelWidget(
                                text: country.dialCode ?? '',
                                fontWeight: FontWeight.w600,
                                textSize: 15.sp,
                                textColor: colorScheme.onSurface,
                              ),
                            ),
                            10.horizontalSpace,
                            Expanded(
                              child: LabelWidget(
                                text: country.country ?? '',
                                fontWeight: FontWeight.normal,
                                textSize: 15.sp,
                                textColor: colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: colorScheme.outlineVariant,
                      height: 1,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}