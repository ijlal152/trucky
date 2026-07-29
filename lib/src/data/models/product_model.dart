import 'package:hive/hive.dart';

part 'product_model.g.dart';

@HiveType(typeId: 0)
class ProductModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String productName;

  @HiveField(2)
  final String productSKU;

  @HiveField(3)
  final double purchasePrice;

  @HiveField(4)
  final double sellingPrice;

  @HiveField(5)
  final int initialQuantity;

  @HiveField(6)
  final int quantityPerPackage;

  @HiveField(7)
  final String? productImage;

  @HiveField(8)
  final DateTime createdAt;

  ProductModel({
    required this.id,
    required this.productName,
    required this.productSKU,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.initialQuantity,
    required this.quantityPerPackage,
    this.productImage,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}
