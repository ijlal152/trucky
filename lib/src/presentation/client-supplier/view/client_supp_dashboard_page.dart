import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:trucky/common/widgets/widget_imports.dart';
import 'package:trucky/core/constants/enums.dart';
import 'package:trucky/core/theme/app_colors.dart';
import 'package:trucky/src/presentation/client-supplier/bloc/client_supplier_bloc.dart';
import 'package:trucky/src/presentation/client-supplier/widgets/contact_options_widget.dart';
import 'package:trucky/src/presentation/client-supplier/widgets/transaction_list_widget.dart';
import 'package:trucky/src/presentation/routes/navigation_helper.dart';

class ClientSuppDashboardPage extends StatelessWidget {
  final EntityType entityType;

  const ClientSuppDashboardPage({
    super.key,
    this.entityType = EntityType.client,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return BlocBuilder<ClientSupplierBloc, ClientSupplierState>(
      builder: (context, state) {
        final selectedEntity = state.selectedEntity;

        final name = selectedEntity?.name ?? '';
        final balance = selectedEntity?.balance ?? 0.0;
        final phoneNumber = selectedEntity?.phoneNumber;
        final gpsLocation = selectedEntity?.gpsLocation;

        return CustomScaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            title: name.isNotEmpty ? name : 'Dashboard',
            actions: [
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: cs.onPrimary),
                onSelected: (value) {
                  switch (value) {
                    case 'edit':
                      context.goToAddClientSupp(entityType);
                    case 'delete':
                      final entityId = selectedEntity?.id ?? '';
                      if (entityId.isNotEmpty) {
                        context.read<ClientSupplierBloc>().add(
                          DeleteClientSupplier(id: entityId),
                        );
                      }
                      context.pop();
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Row(
                      children: [
                        Icon(Icons.edit_outlined, size: 20.h),
                        SizedBox(width: 8.w),
                        const LabelWidget(text: 'Edit'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_outline,
                          size: 20.h,
                          color: AppColors.error,
                        ),
                        SizedBox(width: 8.w),
                        const LabelWidget(
                          text: 'Delete',
                          textColor: AppColors.error,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          body: ContentSheet(
            filterIconOnTap: () {},
            searchIconOnTap: () {},
            contentWidget: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20.h),

                  // Total Balance
                  TotalBalanceWidget(
                    title: 'Total Balance',
                    balance: balance.toStringAsFixed(2),
                    hideBalance: false,
                  ),
                  SizedBox(height: 24.h),

                  // Contact Options
                  ContactOptionsWidget(
                    phoneNumber: phoneNumber,
                    gpsLocation: gpsLocation,
                    onCallPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Calling $phoneNumber...')),
                      );
                    },
                    onLocationPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Opening location $gpsLocation...'),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 24.h),

                  // Transactions Section Header
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LabelWidget(
                          text: 'Transactions',
                          textSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // Transaction List (empty for now — needs separate transaction feature)
                  TransactionListWidget(
                    transactions: const [],
                    emptyMessage: 'No transactions yet',
                  ),
                  SizedBox(height: 80.h),
                ],
              ),
            ),
          ),
          floatingActionButton: CustomFloatingBtn(
            onTap: () => _showTransactionOptions(context),
          ),
        );
      },
    );
  }

  void _showTransactionOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => CustomBottomSheetContent(
        child: Column(
          children: [
            _TransactionOption(
              icon: Icons.shopping_cart_outlined,
              label: 'Sale',
              onTap: () {
                Navigator.pop(ctx);
                // TODO: Navigate to sale page
              },
            ),
            _TransactionOption(
              icon: Icons.shopping_bag_outlined,
              label: 'Purchase',
              onTap: () {
                Navigator.pop(ctx);
                // TODO: Navigate to purchase page
              },
            ),
            _TransactionOption(
              icon: Icons.payment_outlined,
              label: 'Payment',
              onTap: () {
                Navigator.pop(ctx);
                // TODO: Navigate to payment page
              },
            ),
            _TransactionOption(
              icon: Icons.replay_outlined,
              label: 'Return',
              onTap: () {
                Navigator.pop(ctx);
                // TODO: Navigate to return page
              },
            ),
            _TransactionOption(
              icon: Icons.money_off_outlined,
              label: 'Refund',
              onTap: () {
                Navigator.pop(ctx);
                // TODO: Navigate to refund page
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _TransactionOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListTile(
      leading: Icon(icon, color: cs.primary),
      title: LabelWidget(
        text: label,
        textSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      trailing: Icon(Icons.chevron_right, color: cs.onSurfaceVariant),
      onTap: onTap,
    );
  }
}
