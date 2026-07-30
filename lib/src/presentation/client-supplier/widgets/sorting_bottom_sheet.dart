import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trucky/common/widgets/widget_imports.dart';

import '../bloc/client_supplier_bloc.dart';

class SortingBottomSheet extends StatelessWidget {
  const SortingBottomSheet({super.key});

  static const List<String> sortingOptions = [
    'Alphabetically : A to Z',
    'Alphabetically : Z to A',
    'Balance : High to low',
    'Balance : Low to high',
    'Date : New to old',
    'Date : Old to new',
  ];

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ClientSupplierBloc>().state;

    return CustomBottomSheetContent(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 15.h, top: 10.h),
            child: LabelWidget(
              text: 'Sort By',
              fontWeight: FontWeight.bold,
              textSize: 18.sp,
            ),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sortingOptions.length,
            separatorBuilder: (context, index) => SizedBox(height: 8.h),
            itemBuilder: (context, index) {
              final isSelected = state.sortIndex == index;
              return InkWell(
                onTap: () {
                  context
                      .read<ClientSupplierBloc>()
                      .add(SortClientSupplierList(sortIndex: index));
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LabelWidget(
                        text: sortingOptions[index],
                        textSize: 15.sp,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check,
                          size: 18.sp,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
