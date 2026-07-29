import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:trucky/common/widgets/widget_imports.dart';
import 'package:trucky/core/app_assets/app_assets.dart';

import '../bloc/products_bloc.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _skuController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _sellingPriceController = TextEditingController();
  final _initialQtyController = TextEditingController();
  final _qtyPerPackageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _skuController.dispose();
    _purchasePriceController.dispose();
    _sellingPriceController.dispose();
    _initialQtyController.dispose();
    _qtyPerPackageController.dispose();
    super.dispose();
  }

  void _addProduct() {
    if (_nameController.text.trim().isEmpty) return;

    context.read<ProductsBloc>().add(
      AddProductEvent(
        productName: _nameController.text.trim(),
        productSKU: _skuController.text.trim().isEmpty
            ? 'SKU-${DateTime.now().millisecondsSinceEpoch}'
            : _skuController.text.trim(),
        purchasePrice:
            double.tryParse(_purchasePriceController.text.trim()) ?? 0.0,
        sellingPrice:
            double.tryParse(_sellingPriceController.text.trim()) ?? 0.0,
        initialQuantity: int.tryParse(_initialQtyController.text.trim()) ?? 0,
        quantityPerPackage:
            int.tryParse(_qtyPerPackageController.text.trim()) ?? 1,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Product added successfully"),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return CustomScaffold(
      appBar: CustomAppBar(title: "Add Product"),
      body: Form(
        key: _formKey,
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ── Product image picker ──────────────────────────────
                GestureDetector(
                  onTap: () => _showImagePickerOptions(context),
                  child: Container(
                    height: 120.h,
                    width: 120.h,
                    decoration: BoxDecoration(
                      color: cs.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: cs.outline.withValues(alpha: 0.3),
                      ),
                      image: DecorationImage(
                        image: AssetImage(AppAssets.images.addProductIcon),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.add_a_photo_rounded,
                        size: 32.sp,
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                20.verticalSpace,

                // ── Product Name ─────────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomTextFormField(
                    controller: _nameController,
                    hintText: "Product Name",
                    labelText: "Product Name",
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'^(?=.*[a-zA-Z])[a-zA-Z0-9 ]*$'),
                      ),
                    ],
                  ),
                ),
                const TextFieldValidationError(
                  requiredParameter: "Product name is required",
                  isValid: true,
                ),
                10.verticalSpace,

                // ── Product SKU ──────────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomTextFormField(
                    controller: _skuController,
                    hintText: "Product SKU",
                    labelText: "Product SKU",
                    keyboardType: TextInputType.text,
                    suffixIcon: Icons.qr_code_scanner_rounded,
                    onSuffixTap: () {
                      // TODO: Scan QR / barcode
                    },
                  ),
                ),
                10.verticalSpace,

                // ── Purchase Price & Selling Price ───────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            CustomTextFormField(
                              controller: _purchasePriceController,
                              hintText: "Purchase Price",
                              labelText: "Purchase Price",
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}'),
                                ),
                              ],
                            ),
                            const TextFieldValidationError(
                              requiredParameter: "Purchase price is required",
                              isValid: true,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Flexible(
                        child: Column(
                          children: [
                            CustomTextFormField(
                              controller: _sellingPriceController,
                              hintText: "Selling Price",
                              labelText: "Selling Price",
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d*\.?\d{0,2}'),
                                ),
                              ],
                            ),
                            const TextFieldValidationError(
                              requiredParameter: "Selling price is required",
                              isValid: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                10.verticalSpace,

                // ── Initial Quantity ─────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomTextFormField(
                    controller: _initialQtyController,
                    hintText: "Initial Quantity of units",
                    labelText: "Initial Quantity of units",
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                10.verticalSpace,

                // ── Quantity per Package ─────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomTextFormField(
                    controller: _qtyPerPackageController,
                    hintText: "Quantity per Package",
                    labelText: "Quantity per Package",
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                30.verticalSpace,
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavBarWidget(
        widget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: CustomElevatedButton(
            text: "Add Product",
            onPressed: _addProduct,
          ),
        ),
      ),
    );
  }

  void _showImagePickerOptions(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: cs.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              dividerWidget(context),
              20.verticalSpace,
              imagePickerOption(
                context: context,
                img: AppAssets.images.gallery,
                option: "Pick image from gallery",
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Pick from gallery
                },
              ),
              15.verticalSpace,
              imagePickerOption(
                context: context,
                img: AppAssets.images.camera,
                option: "Pick image from camera",
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Pick from camera
                },
              ),
              30.verticalSpace,
            ],
          ),
        );
      },
    );
  }
}
