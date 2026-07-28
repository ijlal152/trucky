part of 'sale_purchase_bloc.dart';

enum SalePurchaseStatus { initial, loading, loaded, error }

class SalePurchaseState extends Equatable {
  final SalePurchaseStatus status;
  final String? message;

  const SalePurchaseState({
    this.status = SalePurchaseStatus.initial,
    this.message,
  });

  SalePurchaseState copyWith({SalePurchaseStatus? status, String? message}) {
    return SalePurchaseState(status: status ?? this.status, message: message);
  }

  @override
  List<Object?> get props => [status, message];
}
