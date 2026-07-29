import 'package:injectable/injectable.dart';
import 'package:trucky/core/usecase/usecase.dart';
import 'package:trucky/src/data/models/product_model.dart';
import 'package:trucky/src/domain/repositories/product_repo.dart';

@lazySingleton
class GetAllProductsUseCase extends UseCase<NoParams, List<ProductModel>> {
  final ProductRepository _productRepository;

  GetAllProductsUseCase(this._productRepository);

  @override
  Future<List<ProductModel>> call(NoParams params) async {
    return _productRepository.getAllProducts();
  }
}
