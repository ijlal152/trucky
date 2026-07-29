import 'package:injectable/injectable.dart';
import 'package:trucky/src/data/datasource/products/product_transaction_local_datasource.dart';
import 'package:trucky/src/data/models/product_transaction_model.dart';
import 'package:trucky/src/domain/repositories/product_transaction_repo.dart';

@LazySingleton(as: ProductTransactionRepository)
class ProductTransactionRepositoryImpl implements ProductTransactionRepository {
  final ProductTransactionLocalDatasource _datasource;

  ProductTransactionRepositoryImpl(this._datasource);

  @override
  Future<List<ProductTransactionModel>> getTransactionsForProduct(
    String productId,
  ) {
    return _datasource.getTransactionsForProduct(productId);
  }

  @override
  Future<void> addTransaction(ProductTransactionModel transaction) {
    return _datasource.addTransaction(transaction);
  }

  @override
  Future<int> getTotalQuantityForProduct(String productId) {
    return _datasource.getTotalQuantityForProduct(productId);
  }

  @override
  Future<int> getTotalSoldForProduct(String productId) {
    return _datasource.getTotalSoldForProduct(productId);
  }

  @override
  Future<int> getTotalPurchasedForProduct(String productId) {
    return _datasource.getTotalPurchasedForProduct(productId);
  }

  @override
  Future<double> getTotalStockValueForProduct(String productId) {
    return _datasource.getTotalStockValueForProduct(productId);
  }
}
