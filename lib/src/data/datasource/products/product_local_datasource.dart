import 'package:hive/hive.dart';
import 'package:trucky/src/data/models/product_model.dart';

abstract class ProductLocalDatasource {
  Future<List<ProductModel>> getAllProducts();
  Future<ProductModel?> getProductById(String id);
  Future<void> addProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
  Future<double> getTotalStockValue();
}

class ProductLocalDatasourceImpl implements ProductLocalDatasource {
  static const String _boxName = 'products';

  late Box<ProductModel> _box;

  ProductLocalDatasourceImpl() {
    _box = Hive.box<ProductModel>(_boxName);
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    return _box.values.toList();
  }

  @override
  Future<ProductModel?> getProductById(String id) async {
    return _box.get(id);
  }

  @override
  Future<void> addProduct(ProductModel product) async {
    await _box.put(product.id, product);
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    await _box.put(product.id, product);
  }

  @override
  Future<void> deleteProduct(String id) async {
    await _box.delete(id);
  }

  @override
  Future<double> getTotalStockValue() async {
    final products = _box.values;
    double total = 0;
    for (final product in products) {
      total += product.purchasePrice * product.initialQuantity;
    }
    return total;
  }
}
