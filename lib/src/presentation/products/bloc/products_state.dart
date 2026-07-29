part of 'products_bloc.dart';

enum ProductsStatus { initial, loading, loaded, error }

class ProductsState extends Equatable {
  final ProductsStatus status;
  final String? message;
  final bool hideBalance;
  final double totalStockValue;
  final List<ProductModel> products;

  /// Transactions for the currently viewed product (dashboard)
  final List<ProductTransactionModel> transactions;
  final int totalSold;
  final int totalPurchased;
  final int availableStock;

  const ProductsState({
    this.status = ProductsStatus.initial,
    this.message,
    this.hideBalance = false,
    this.totalStockValue = 0.0,
    this.products = const [],
    this.transactions = const [],
    this.totalSold = 0,
    this.totalPurchased = 0,
    this.availableStock = 0,
  });

  ProductsState copyWith({
    ProductsStatus? status,
    String? message,
    bool? hideBalance,
    double? totalStockValue,
    List<ProductModel>? products,
    List<ProductTransactionModel>? transactions,
    int? totalSold,
    int? totalPurchased,
    int? availableStock,
  }) {
    return ProductsState(
      status: status ?? this.status,
      message: message,
      hideBalance: hideBalance ?? this.hideBalance,
      totalStockValue: totalStockValue ?? this.totalStockValue,
      products: products ?? this.products,
      transactions: transactions ?? this.transactions,
      totalSold: totalSold ?? this.totalSold,
      totalPurchased: totalPurchased ?? this.totalPurchased,
      availableStock: availableStock ?? this.availableStock,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
    hideBalance,
    totalStockValue,
    products,
    transactions,
    totalSold,
    totalPurchased,
    availableStock,
  ];
}
