import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/constants/enums.dart';
import '../../../../core/usecase/usecase.dart';
import '../../entities/client_supp_entity.dart';
import '../../repositories/client_supp_repo.dart';

@lazySingleton
class GetAllClientSuppUseCase
    extends UseCase<GetAllClientSuppParams, List<ClientSuppEntity>> {
  final ClientSuppRepo _repo;

  GetAllClientSuppUseCase(this._repo);

  @override
  Future<List<ClientSuppEntity>> call(GetAllClientSuppParams params) async {
    return _repo.getAll(entityType: params.entityType);
  }
}

class GetAllClientSuppParams extends Equatable {
  final EntityType entityType;
  const GetAllClientSuppParams({required this.entityType});

  @override
  List<Object?> get props => [entityType];
}
