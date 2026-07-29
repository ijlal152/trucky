part of 'products_bloc.dart';

enum ProductsStatus { initial, loading, loaded, error }

class ProductsState extends Equatable {
  final ProductsStatus status;
  final String? message;
  final bool hideBalance;
  final double totalStockValue;

  const ProductsState({
    this.status = ProductsStatus.initial,
    this.message,
    this.hideBalance = false,
    this.totalStockValue = 0.0,
  });

  ProductsState copyWith({
    ProductsStatus? status,
    String? message,
    bool? hideBalance,
    double? totalStockValue,
  }) {
    return ProductsState(
      status: status ?? this.status,
      message: message,
      hideBalance: hideBalance ?? this.hideBalance,
      totalStockValue: totalStockValue ?? this.totalStockValue,
    );
  }

  @override
  List<Object?> get props => [status, message, hideBalance, totalStockValue];
}
