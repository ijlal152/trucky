import 'package:injectable/injectable.dart';
import 'package:trucky/core/usecase/usecase.dart';
import 'package:trucky/src/data/models/product_model.dart';
import 'package:trucky/src/domain/repositories/product_repo.dart';

@lazySingleton
class UpdateProductUseCase extends UseCase<ProductModel, void> {
  final ProductRepository _productRepository;

  UpdateProductUseCase(this._productRepository);

  @override
  Future<void> call(ProductModel params) async {
    return _productRepository.updateProduct(params);
  }
}
