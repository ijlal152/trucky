import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/enums.dart';
import '../../../domain/entities/client_supp_entity.dart';
import '../../../domain/usecases/client_supp_usecases/add_client_supp_uc.dart';
import '../../../domain/usecases/client_supp_usecases/delete_client_supp_uc.dart';
import '../../../domain/usecases/client_supp_usecases/get_all_client_supp_uc.dart';

part 'client_supplier_event.dart';
part 'client_supplier_state.dart';

@injectable
class ClientSupplierBloc
    extends Bloc<ClientSupplierEvent, ClientSupplierState> {
  final GetAllClientSuppUseCase _getAllUseCase;
  final AddClientSuppUseCase _addUseCase;
  final DeleteClientSuppUseCase _deleteUseCase;

  ClientSupplierBloc(this._getAllUseCase, this._addUseCase, this._deleteUseCase)
    : super(const ClientSupplierState()) {
    on<LoadClientsSuppliers>(_onLoad);
    on<AddClientSupplier>(_onAdd);
    on<DeleteClientSupplier>(_onDelete);
    on<SelectClientSupplier>(_onSelect);
    on<ToggleSearchField>(_onToggleSearchField);
    on<SearchClientSupplier>(_onSearch);
    on<SortClientSupplierList>(_onSort);
  }

  Future<void> _onLoad(
    LoadClientsSuppliers event,
    Emitter<ClientSupplierState> emit,
  ) async {
    emit(state.copyWith(status: ClientSupplierStatus.loading));
    try {
      final entities = await _getAllUseCase(
        GetAllClientSuppParams(entityType: event.entityType),
      );
      emit(
        state.copyWith(
          status: ClientSupplierStatus.loaded,
          entityType: event.entityType,
          entities: entities,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ClientSupplierStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onAdd(
    AddClientSupplier event,
    Emitter<ClientSupplierState> emit,
  ) async {
    try {
      final created = await _addUseCase(
        AddClientSuppParams(contact: event.contact),
      );
      final entities = [...state.entities, created];
      emit(
        state.copyWith(status: ClientSupplierStatus.added, entities: entities),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ClientSupplierStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  Future<void> _onDelete(
    DeleteClientSupplier event,
    Emitter<ClientSupplierState> emit,
  ) async {
    try {
      await _deleteUseCase(DeleteClientSuppParams(id: event.id));
      final entities = state.entities.where((e) => e.id != event.id).toList();
      emit(
        state.copyWith(
          status: ClientSupplierStatus.deleted,
          entities: entities,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ClientSupplierStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  void _onSelect(
    SelectClientSupplier event,
    Emitter<ClientSupplierState> emit,
  ) {
    emit(state.copyWith(selectedEntityId: event.id));
  }

  void _onToggleSearchField(
    ToggleSearchField event,
    Emitter<ClientSupplierState> emit,
  ) {
    emit(state.copyWith(showSearchField: event.isVisible));
  }

  void _onSearch(
    SearchClientSupplier event,
    Emitter<ClientSupplierState> emit,
  ) {
    final query = event.query.toLowerCase();
    final filtered = state.entities.where((entity) {
      return entity.name.toLowerCase().contains(query) ||
          entity.phoneNumber.toLowerCase().contains(query);
    }).toList();
    emit(state.copyWith(searchQuery: event.query, filteredEntities: filtered));
  }

  void _onSort(
    SortClientSupplierList event,
    Emitter<ClientSupplierState> emit,
  ) {
    final sorted = List<ClientSuppEntity>.from(state.entities);
    switch (event.sortIndex) {
      case 0:
        sorted.sort((a, b) => a.name.compareTo(b.name));
      case 1:
        sorted.sort((a, b) => b.name.compareTo(a.name));
      case 2:
        sorted.sort((a, b) => b.balance.compareTo(a.balance));
      case 3:
        sorted.sort((a, b) => a.balance.compareTo(b.balance));
      case 4:
        sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      case 5:
        sorted.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }
    emit(state.copyWith(entities: sorted, sortIndex: event.sortIndex));
  }
}
