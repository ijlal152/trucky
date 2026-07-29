part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class LoadProducts extends ProductsEvent {
  const LoadProducts();
}

class ToggleBalanceVisibility extends ProductsEvent {
  const ToggleBalanceVisibility();
}

class CalculateTotalStockValue extends ProductsEvent {
  const CalculateTotalStockValue();
}

class AddProductEvent extends ProductsEvent {
  final String productName;
  final String productSKU;
  final double purchasePrice;
  final double sellingPrice;
  final int initialQuantity;
  final int quantityPerPackage;
  final String? productImage;

  const AddProductEvent({
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
