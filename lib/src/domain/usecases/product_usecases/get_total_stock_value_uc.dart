import 'package:injectable/injectable.dart';
import 'package:trucky/core/usecase/usecase.dart';
import 'package:trucky/src/domain/repositories/product_repo.dart';

@lazySingleton
class GetTotalStockValueUseCase extends UseCase<NoParams, double> {
  final ProductRepository _productRepository;

  GetTotalStockValueUseCase(this._productRepository);

  @override
  Future<double> call(NoParams params) async {
    return _productRepository.getTotalStockValue();
  }
}
