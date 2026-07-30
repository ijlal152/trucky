import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/usecase/usecase.dart';
import '../../entities/client_supp_entity.dart';
import '../../repositories/client_supp_repo.dart';

@lazySingleton
class UpdateClientSuppUseCase
    extends UseCase<UpdateClientSuppParams, ClientSuppEntity> {
  final ClientSuppRepo _repo;

  UpdateClientSuppUseCase(this._repo);

  @override
  Future<ClientSuppEntity> call(UpdateClientSuppParams params) async {
    return _repo.update(contact: params.contact);
  }
}

class UpdateClientSuppParams extends Equatable {
  final ClientSuppEntity contact;
  const UpdateClientSuppParams({required this.contact});

  @override
  List<Object?> get props => [contact];
}
