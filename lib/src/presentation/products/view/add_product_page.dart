import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trucky/common/widgets/widget_imports.dart';
import 'package:trucky/core/app_assets/app_assets.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return CustomScaffold(
      appBar: CustomAppBar(title: "Add Product"),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ── Product image picker ──────────────────────────────
              GestureDetector(
                onTap: () {
                  _showImagePickerOptions(context);
                },
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
                            hintText: "Purchase Price",
                            labelText: "Purchase Price",
                            keyboardType: const TextInputType.numberWithOptions(
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
                            hintText: "Selling Price",
                            labelText: "Selling Price",
                            keyboardType: const TextInputType.numberWithOptions(
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
      bottomNavigationBar: CustomBottomNavBarWidget(
        widget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          child: CustomElevatedButton(
            text: "Add Product",
            onPressed: () {
              // TODO: Handle add product
            },
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
