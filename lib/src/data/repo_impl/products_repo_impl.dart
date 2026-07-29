import 'package:trucky/src/data/datasource/products/product_local_datasource.dart';
import 'package:trucky/src/data/models/product_model.dart';
import 'package:trucky/src/domain/repositories/product_repo.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDatasource _localDatasource;

  ProductRepositoryImpl(this._localDatasource);

  @override
  Future<List<ProductModel>> getAllProducts() {
    return _localDatasource.getAllProducts();
  }

  @override
  Future<ProductModel?> getProductById(String id) {
    return _localDatasource.getProductById(id);
  }

  @override
  Future<void> addProduct(ProductModel product) {
    return _localDatasource.addProduct(product);
  }

  @override
  Future<void> updateProduct(ProductModel product) {
    return _localDatasource.updateProduct(product);
  }

  @override
  Future<void> deleteProduct(String id) {
    return _localDatasource.deleteProduct(id);
  }

  @override
  Future<double> getTotalStockValue() {
    return _localDatasource.getTotalStockValue();
  }
}
