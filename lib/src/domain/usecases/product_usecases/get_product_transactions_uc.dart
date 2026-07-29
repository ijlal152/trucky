import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:trucky/core/usecase/usecase.dart';
import 'package:trucky/src/data/models/product_transaction_model.dart';
import 'package:trucky/src/domain/repositories/product_transaction_repo.dart';

@lazySingleton
class GetProductTransactionsUseCase
    extends
        UseCase<GetProductTransactionsParams, List<ProductTransactionModel>> {
  final ProductTransactionRepository _repository;

  GetProductTransactionsUseCase(this._repository);

  @override
  Future<List<ProductTransactionModel>> call(
    GetProductTransactionsParams params,
  ) async {
    return _repository.getTransactionsForProduct(params.productId);
  }
}

class GetProductTransactionsParams extends Equatable {
  final String productId;

  const GetProductTransactionsParams({required this.productId});

  @override
  List<Object?> get props => [productId];
}
