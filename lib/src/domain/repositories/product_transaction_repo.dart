import 'package:trucky/src/data/models/product_transaction_model.dart';

abstract class ProductTransactionRepository {
  Future<List<ProductTransactionModel>> getTransactionsForProduct(
    String productId,
  );
  Future<void> addTransaction(ProductTransactionModel transaction);
  Future<int> getTotalQuantityForProduct(String productId);
  Future<int> getTotalSoldForProduct(String productId);
  Future<int> getTotalPurchasedForProduct(String productId);
  Future<double> getTotalStockValueForProduct(String productId);
}
