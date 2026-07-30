import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../entities/client_supp_entity.dart';
import '../../repositories/client_supp_repo.dart';

@lazySingleton
class AddClientSuppUseCase
    extends UseCase<AddClientSuppParams, ClientSuppEntity> {
  final ClientSuppRepo _repo;

  AddClientSuppUseCase(this._repo);

  @override
  Future<ClientSuppEntity> call(AddClientSuppParams params) async {
    return _repo.add(contact: params.contact);
  }
}

class AddClientSuppParams extends Equatable {
  final ClientSuppEntity contact;
  const AddClientSuppParams({required this.contact});

  @override
  List<Object?> get props => [contact];
}
