import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:trucky/src/data/models/product_transaction_model.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Abstract datasource
// ─────────────────────────────────────────────────────────────────────────────
abstract class ProductTransactionLocalDatasource {
  Future<List<ProductTransactionModel>> getTransactionsForProduct(
    String productId,
  );
  Future<void> addTransaction(ProductTransactionModel transaction);
  Future<int> getTotalQuantityForProduct(String productId);
  Future<int> getTotalSoldForProduct(String productId);
  Future<int> getTotalPurchasedForProduct(String productId);
  Future<double> getTotalStockValueForProduct(String productId);
}

// ─────────────────────────────────────────────────────────────────────────────
// Implementation
// ─────────────────────────────────────────────────────────────────────────────
@LazySingleton(as: ProductTransactionLocalDatasource)
class ProductTransactionLocalDatasourceImpl
    implements ProductTransactionLocalDatasource {
  static const String _boxName = 'product_transactions';

  late Box<ProductTransactionModel> _box;

  ProductTransactionLocalDatasourceImpl() {
    _box = Hive.box<ProductTransactionModel>(_boxName);
  }

  @override
  Future<List<ProductTransactionModel>> getTransactionsForProduct(
    String productId,
  ) async {
    return _box.values.where((t) => t.productId == productId).toList()
      ..sort((a, b) => b.date.compareTo(a.date)); // newest first
  }

  @override
  Future<void> addTransaction(ProductTransactionModel transaction) async {
    await _box.put(transaction.id, transaction);
  }

  /// Computes the current available stock for a product
  /// by summing all transaction quantities.
  @override
  Future<int> getTotalQuantityForProduct(String productId) async {
    int total = 0;
    for (final t in _box.values) {
      if (t.productId == productId) total += t.quantity;
    }
    return total;
  }

  /// Total units sold (absolute value, positive number)
  @override
  Future<int> getTotalSoldForProduct(String productId) async {
    int total = 0;
    for (final t in _box.values) {
      if (t.productId == productId && t.type == 'sale') {
        total += t.quantity.abs();
      }
    }
    return total;
  }

  /// Total units purchased (positive number)
  @override
  Future<int> getTotalPurchasedForProduct(String productId) async {
    int total = 0;
    for (final t in _box.values) {
      if (t.productId == productId && t.type == 'purchase') {
        total += t.quantity;
      }
    }
    return total;
  }

  /// Stock value = current available stock × latest purchase price
  @override
  Future<double> getTotalStockValueForProduct(String productId) async {
    final totalQty = await getTotalQuantityForProduct(productId);
    // Find the most recent transaction to get the latest unit price
    final transactions =
        _box.values.where((t) => t.productId == productId).toList()
          ..sort((a, b) => b.date.compareTo(a.date));

    if (transactions.isEmpty) return 0.0;
    final latestPrice = transactions.first.unitPrice;
    return totalQty * latestPrice;
  }
}
