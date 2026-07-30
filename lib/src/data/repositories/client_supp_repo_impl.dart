import 'package:injectable/injectable.dart';

import '../../../core/constants/enums.dart';
import '../../domain/entities/client_supp_entity.dart';
import '../../domain/repositories/client_supp_repo.dart';

/// Temporary mock implementation of [ClientSuppRepo].
/// Replace with a real API/database implementation later.
@Injectable(as: ClientSuppRepo)
class ClientSuppRepoImpl implements ClientSuppRepo {
  /// In-memory store — will be replaced by actual data source.
  final List<ClientSuppEntity> _store = [];

  @override
  Future<List<ClientSuppEntity>> getAll({
    required EntityType entityType,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _store.where((e) => e.entityType == entityType).toList();
  }

  @override
  Future<ClientSuppEntity> add({required ClientSuppEntity contact}) async {
    final created = contact.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
    _store.add(created);
    return created;
  }

  @override
  Future<void> delete({required String id}) async {
    _store.removeWhere((e) => e.id == id);
  }

  @override
  Future<ClientSuppEntity> update({required ClientSuppEntity contact}) async {
    final index = _store.indexWhere((e) => e.id == contact.id);
    if (index == -1) throw Exception('Contact not found');
    _store[index] = contact;
    return contact;
  }
}
