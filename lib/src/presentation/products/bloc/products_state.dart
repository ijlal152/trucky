part of 'products_bloc.dart';

enum ProductsStatus { initial, loading, loaded, error }

class ProductsState extends Equatable {
  final ProductsStatus status;
  final String? message;
  final bool hideBalance;
  final double totalStockValue;
  final List<ProductModel> products;

  const ProductsState({
    this.status = ProductsStatus.initial,
    this.message,
    this.hideBalance = false,
    this.totalStockValue = 0.0,
    this.products = const [],
  });

  ProductsState copyWith({
    ProductsStatus? status,
    String? message,
    bool? hideBalance,
    double? totalStockValue,
    List<ProductModel>? products,
  }) {
    return ProductsState(
      status: status ?? this.status,
      message: message,
      hideBalance: hideBalance ?? this.hideBalance,
      totalStockValue: totalStockValue ?? this.totalStockValue,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
    hideBalance,
    totalStockValue,
    products,
  ];
}
