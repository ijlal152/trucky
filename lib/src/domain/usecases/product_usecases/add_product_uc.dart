import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:trucky/core/usecase/usecase.dart';
import 'package:trucky/src/data/models/product_model.dart';
import 'package:trucky/src/domain/repositories/product_repo.dart';
import 'package:trucky/src/domain/usecases/product_usecases/add_product_transaction_uc.dart';
import 'package:uuid/uuid.dart';

@lazySingleton
class AddProductUseCase extends UseCase<AddProductParams, ProductModel> {
  final ProductRepository _productRepository;
  final AddProductTransactionUseCase _addTransactionUseCase;

  AddProductUseCase(this._productRepository, this._addTransactionUseCase);

  @override
  Future<ProductModel> call(AddProductParams params) async {
    final product = ProductModel(
      id: const Uuid().v4(),
      productName: params.productName,
      productSKU: params.productSKU,
      purchasePrice: params.purchasePrice,
      sellingPrice: params.sellingPrice,
      initialQuantity: params.initialQuantity,
      quantityPerPackage: params.quantityPerPackage,
      productImage: params.productImage,
    );
    await _productRepository.addProduct(product);

    // Create initial stock transaction
    if (params.initialQuantity > 0) {
      await _addTransactionUseCase(
        AddProductTransactionParams(
          productId: product.id,
          type: 'initialStock',
          quantity: params.initialQuantity,
          unitPrice: params.purchasePrice,
          note: 'Initial stock on product creation',
        ),
      );
    }

    return product;
  }
}

class AddProductParams extends Equatable {
  final String productName;
  final String productSKU;
  final double purchasePrice;
  final double sellingPrice;
  final int initialQuantity;
  final int quantityPerPackage;
  final String? productImage;

  const AddProductParams({
    required this.productName,
    required this.productSKU,
    required this.purchasePrice,
    required this.sellingPrice,
    required this.initialQuantity,
    required this.quantityPerPackage,
    this.productImage,
  });

  @override
  List<Object?> get props => [
    productName,
    productSKU,
    purchasePrice,
    sellingPrice,
    initialQuantity,
    quantityPerPackage,
    productImage,
  ];
}
