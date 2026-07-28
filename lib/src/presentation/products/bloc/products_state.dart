part of 'products_bloc.dart';

enum ProductsStatus { initial, loading, loaded, error }

class ProductsState extends Equatable {
  final ProductsStatus status;
  final String? message;

  const ProductsState({this.status = ProductsStatus.initial, this.message});

  ProductsState copyWith({ProductsStatus? status, String? message}) {
    return ProductsState(status: status ?? this.status, message: message);
  }

  @override
  List<Object?> get props => [status, message];
}
