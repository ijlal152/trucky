part of 'client_supplier_bloc.dart';

enum ClientSupplierStatus { initial, loading, loaded, error }

class ClientSupplierState extends Equatable {
  final ClientSupplierStatus status;
  final String? message;

  const ClientSupplierState({
    this.status = ClientSupplierStatus.initial,
    this.message,
  });

  ClientSupplierState copyWith({
    ClientSupplierStatus? status,
    String? message,
  }) {
    return ClientSupplierState(status: status ?? this.status, message: message);
  }

  @override
  List<Object?> get props => [status, message];
}
