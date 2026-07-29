import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:trucky/core/usecase/usecase.dart';
import 'package:trucky/src/data/models/product_transaction_model.dart';
import 'package:trucky/src/domain/repositories/product_transaction_repo.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class AddProductTransactionUseCase
    extends UseCase<AddProductTransactionParams, ProductTransactionModel> {
  final ProductTransactionRepository _repository;

  AddProductTransactionUseCase(this._repository);

  @override
  Future<ProductTransactionModel> call(
    AddProductTransactionParams params,
  ) async {
    final transaction = ProductTransactionModel(
      id: const Uuid().v4(),
      productId: params.productId,
      type: params.type,
      quantity: params.quantity,
      referenceId: params.referenceId,
      referenceName: params.referenceName,
      unitPrice: params.unitPrice,
      totalAmount: params.quantity * params.unitPrice,
      note: params.note,
    );
    await _repository.addTransaction(transaction);
    return transaction;
  }
}

class AddProductTransactionParams extends Equatable {
  final String productId;
  final String type;
  final int quantity;
  final String? referenceId;
  final String? referenceName;
  final double unitPrice;
  final String? note;

  const AddProductTransactionParams({
    required this.productId,
    required this.type,
    required this.quantity,
    this.referenceId,
    this.referenceName,
    required this.unitPrice,
    this.note,
  });

  @override
  List<Object?> get props => [
    productId,
    type,
    quantity,
    referenceId,
    referenceName,
    unitPrice,
    note,
  ];
}
