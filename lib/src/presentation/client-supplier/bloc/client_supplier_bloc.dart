import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'client_supplier_event.dart';
part 'client_supplier_state.dart';

class ClientSupplierBloc
    extends Bloc<ClientSupplierEvent, ClientSupplierState> {
  ClientSupplierBloc() : super(const ClientSupplierState()) {
    on<LoadClientsSuppliers>(_onLoadClientsSuppliers);
  }

  Future<void> _onLoadClientsSuppliers(
    LoadClientsSuppliers event,
    Emitter<ClientSupplierState> emit,
  ) async {
    emit(state.copyWith(status: ClientSupplierStatus.loading));
    try {
      // TODO: Implement actual data loading logic
      await Future.delayed(const Duration(seconds: 1));
      emit(state.copyWith(status: ClientSupplierStatus.loaded, message: null));
    } catch (e) {
      emit(
        state.copyWith(
          status: ClientSupplierStatus.error,
          message: e.toString(),
        ),
      );
    }
  }
}
