import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trucky/common/widgets/widget_imports.dart';
import 'package:trucky/core/app_assets/app_assets.dart';
import 'package:trucky/core/constants/enums.dart';
import 'package:trucky/core/theme/app_colors.dart';
import 'package:trucky/src/domain/entities/client_supp_entity.dart';
import 'package:trucky/src/presentation/client-supplier/bloc/client_supplier_bloc.dart';
import 'package:trucky/src/presentation/client-supplier/widgets/sorting_bottom_sheet.dart';
import 'package:trucky/src/presentation/routes/navigation_helper.dart';

class AllClientSuppPage extends StatefulWidget {
  final EntityType entityType;

  const AllClientSuppPage({super.key, this.entityType = EntityType.client});

  @override
  State<AllClientSuppPage> createState() => _AllClientSuppPageState();
}

class _AllClientSuppPageState extends State<AllClientSuppPage> {
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    context.read<ClientSupplierBloc>().add(
      LoadClientsSuppliers(entityType: widget.entityType),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  String get _pageTitle =>
      widget.entityType == EntityType.client ? 'Clients' : 'Suppliers';

  String get _notFoundMsg => widget.entityType == EntityType.client
      ? 'No Client Found'
      : 'No Supplier Found';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return BlocBuilder<ClientSupplierBloc, ClientSupplierState>(
      builder: (context, state) {
        return CustomScaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            title: _pageTitle,
            actions: [
              if (!state.showSearchField)
                IconButton(
                  icon: Image.asset(
                    AppAssets.images.searchIcon,
                    height: 20.h,
                    width: 20.h,
                  ),
                  onPressed: () {
                    context.read<ClientSupplierBloc>().add(
                      const ToggleSearchField(isVisible: true),
                    );
                  },
                ),
              if (state.showSearchField)
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _searchController.clear();
                    context.read<ClientSupplierBloc>().add(
                      const ToggleSearchField(isVisible: false),
                    );
                  },
                ),
            ],
          ),
          body: ContentSheet(
            showSearchField: state.showSearchField,
            controller: _searchController,
            focusNode: _searchFocusNode,
            isSortFeatureEnabled: true,
            sortType: _getSortLabel(state.sortIndex),
            onChanged: (query) {
              context.read<ClientSupplierBloc>().add(
                SearchClientSupplier(query: query),
              );
            },
            filterIconOnTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => const SortingBottomSheet(),
              );
            },
            searchIconOnTap: () {
              context.read<ClientSupplierBloc>().add(
                const ToggleSearchField(isVisible: true),
              );
              _searchFocusNode.requestFocus();
            },
            contentWidget: state.status == ClientSupplierStatus.loading
                ? const Center(child: CircularProgressIndicator())
                : state.displayList.isEmpty
                ? Center(
                    child: LabelWidget(
                      text: _notFoundMsg,
                      textSize: 16.sp,
                      textColor: cs.onSurfaceVariant,
                    ),
                  )
                : ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    itemCount: state.displayList.length,
                    separatorBuilder: (ctx, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: dividerWidget(context),
                    ),
                    itemBuilder: (ctx, index) {
                      final entity = state.displayList[index];

                      return _EntityListTile(
                        entity: entity,
                        onTap: () {
                          context.read<ClientSupplierBloc>().add(
                            SelectClientSupplier(id: entity.id),
                          );
                          context.goToClientSuppDashboard(widget.entityType);
                        },
                      );
                    },
                  ),
          ),
          floatingActionButton: CustomFloatingBtn(
            onTap: () => context.goToAddClientSupp(widget.entityType),
          ),
        );
      },
    );
  }

  String _getSortLabel(int index) {
    if (index < 0 || index >= SortingBottomSheet.sortingOptions.length)
      return '';
    return SortingBottomSheet.sortingOptions[index];
  }
}

class _EntityListTile extends StatelessWidget {
  final ClientSuppEntity entity;
  final VoidCallback onTap;

  const _EntityListTile({required this.entity, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final dateStr =
        '${entity.createdAt.year}-${entity.createdAt.month.toString().padLeft(2, '0')}-${entity.createdAt.day.toString().padLeft(2, '0')}';

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            Container(
              height: 44.h,
              width: 44.h,
              decoration: BoxDecoration(
                color: cs.primaryContainer,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Center(
                child: LabelWidget(
                  text: entity.name.isNotEmpty
                      ? entity.name[0].toUpperCase()
                      : '?',
                  textSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  textColor: cs.onPrimaryContainer,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelWidget(
                    text: entity.name,
                    textSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(height: 2.h),
                  LabelWidget(
                    text: dateStr,
                    textSize: 12.sp,
                    textColor: cs.onSurfaceVariant,
                  ),
                ],
              ),
            ),
            LabelWidget(
              text: '\$${entity.balance.toStringAsFixed(2)}',
              textSize: 16.sp,
              fontWeight: FontWeight.bold,
              textColor: entity.balance >= 0
                  ? AppColors.success
                  : AppColors.error,
            ),
          ],
        ),
      ),
    );
  }
}
