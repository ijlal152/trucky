import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trucky/common/widgets/widget_imports.dart';

class ProductDashboardPage extends StatelessWidget {
  final int? productId;

  const ProductDashboardPage({super.key, this.productId});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: "Product Details",
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: LabelWidget(
          text: "Product Dashboard #$productId",
          textSize: 16.sp,
        ),
      ),
    );
  }
}
