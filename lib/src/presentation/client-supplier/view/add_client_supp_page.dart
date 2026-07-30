import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:trucky/common/widgets/widget_imports.dart';
import 'package:trucky/core/constants/enums.dart';
import 'package:trucky/src/domain/entities/client_supp_entity.dart';
import 'package:trucky/src/presentation/client-supplier/bloc/client_supplier_bloc.dart';

class AddClientSuppPage extends StatefulWidget {
  final EntityType entityType;

  const AddClientSuppPage({super.key, this.entityType = EntityType.client});

  @override
  State<AddClientSuppPage> createState() => _AddClientSuppPageState();
}

class _AddClientSuppPageState extends State<AddClientSuppPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _gpsController = TextEditingController();
  final _balanceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _gpsController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  String get _pageTitle =>
      widget.entityType == EntityType.client ? 'Add Client' : 'Add Supplier';

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return BlocConsumer<ClientSupplierBloc, ClientSupplierState>(
      listener: (context, state) {
        if (state.status == ClientSupplierStatus.added) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                widget.entityType == EntityType.client
                    ? 'Client added successfully'
                    : 'Supplier added successfully',
              ),
            ),
          );
          context.pop();
        } else if (state.status == ClientSupplierStatus.error) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message ?? 'Error')));
        }
      },
      builder: (context, state) {
        return CustomScaffold(
          appBar: CustomAppBar(title: _pageTitle),
          body: ContentSheet(
            filterIconOnTap: () {},
            searchIconOnTap: () {},
            contentWidget: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name field
                    LabelWidget(
                      text: 'Name',
                      textSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 8.h),
                    CustomTextFormField(
                      controller: _nameController,
                      hintText: 'Enter name',
                      keyboardType: TextInputType.text,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Name is required';
                        }
                        // Alphanumeric + spaces validation
                        final regex = RegExp(r'^[a-zA-Z0-9\s]+$');
                        if (!regex.hasMatch(val)) {
                          return 'Only letters, numbers, and spaces allowed';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),

                    // Phone field
                    LabelWidget(
                      text: 'Phone Number',
                      textSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 8.h),
                    CustomTextFormField(
                      controller: _phoneController,
                      hintText: 'Enter phone number',
                      keyboardType: TextInputType.phone,
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return 'Phone number is required';
                        }
                        // Digits only
                        final regex = RegExp(r'^\d+$');
                        if (!regex.hasMatch(val)) {
                          return 'Only digits allowed';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),

                    // GPS Location field
                    LabelWidget(
                      text: 'GPS Location',
                      textSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 8.h),
                    CustomTextFormField(
                      controller: _gpsController,
                      hintText: 'Enter GPS location',
                      keyboardType: TextInputType.text,
                    ),
                    SizedBox(height: 16.h),

                    // Initial Balance field
                    LabelWidget(
                      text: 'Initial Balance',
                      textSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 8.h),
                    CustomTextFormField(
                      controller: _balanceController,
                      hintText: 'Enter initial balance',
                      keyboardType: TextInputType.number,
                      validator: (val) {
                        if (val != null && val.isNotEmpty) {
                          final regex = RegExp(r'^\d+(\.\d{1,2})?$');
                          if (!regex.hasMatch(val)) {
                            return 'Enter a valid amount';
                          }
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 40.h),

                    // Bottom buttons
                    Row(
                      children: [
                        Expanded(
                          child: CustomElevatedButton(
                            text: 'Cancel',
                            onPressed: () => context.pop(),
                            backgroundColor: cs.outlineVariant,
                            foregroundColor: cs.onSurface,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: CustomElevatedButton(
                            text: 'Add',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final contact = ClientSuppEntity(
                                  id: '', // will be assigned by repo
                                  name: _nameController.text.trim(),
                                  phoneNumber: _phoneController.text.trim(),
                                  gpsLocation: _gpsController.text.trim(),
                                  balance:
                                      double.tryParse(
                                        _balanceController.text.trim(),
                                      ) ??
                                      0.0,
                                  entityType: widget.entityType,
                                  createdAt: DateTime.now(),
                                );
                                context.read<ClientSupplierBloc>().add(
                                  AddClientSupplier(contact: contact),
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
