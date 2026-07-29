import 'package:hive/hive.dart';

import 'product_transaction_model.dart';

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

  // ── Computed stock helpers ──────────────────────────────────────────────

  /// Calculates the current available stock from transaction history.
  /// Falls back to [initialQuantity] when no transactions are given.
  int computeAvailableStock([List<ProductTransactionModel>? transactions]) {
    if (transactions == null || transactions.isEmpty) return initialQuantity;
    return transactions.fold(0, (sum, t) => sum + t.quantity);
  }

  /// Calculates the current stock value.
  double computeStockValue([List<ProductTransactionModel>? transactions]) {
    final qty = computeAvailableStock(transactions);
    return qty * purchasePrice;
  }

  /// Formats stock as "X Pcs" with package breakdown.
  String formatStock(int availableStock) {
    if (quantityPerPackage <= 0) return '$availableStock Pcs';
    final fullPackages = availableStock ~/ quantityPerPackage;
    final extraUnits = availableStock % quantityPerPackage;
    if (extraUnits == 0)
      return '$availableStock Pcs ($fullPackages\u00d7$quantityPerPackage)';
    return '$availableStock Pcs ($fullPackages\u00d7$quantityPerPackage+$extraUnits)';
  }
}
