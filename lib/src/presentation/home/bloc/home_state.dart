part of 'home_bloc.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final String? message;
  final int productCount;
  final int clientCount;
  final int supplierCount;
  final int saleCount;
  final int purchaseCount;
  final double totalStockValue;

  const HomeState({
    this.status = HomeStatus.initial,
    this.message,
    this.productCount = 0,
    this.clientCount = 0,
    this.supplierCount = 0,
    this.saleCount = 0,
    this.purchaseCount = 0,
    this.totalStockValue = 0.0,
  });

  HomeState copyWith({
    HomeStatus? status,
    String? message,
    int? productCount,
    int? clientCount,
    int? supplierCount,
    int? saleCount,
    int? purchaseCount,
    double? totalStockValue,
  }) {
    return HomeState(
      status: status ?? this.status,
      message: message,
      productCount: productCount ?? this.productCount,
      clientCount: clientCount ?? this.clientCount,
      supplierCount: supplierCount ?? this.supplierCount,
      saleCount: saleCount ?? this.saleCount,
      purchaseCount: purchaseCount ?? this.purchaseCount,
      totalStockValue: totalStockValue ?? this.totalStockValue,
    );
  }

  @override
  List<Object?> get props => [
    status,
    message,
    productCount,
    clientCount,
    supplierCount,
    saleCount,
    purchaseCount,
    totalStockValue,
  ];
}
