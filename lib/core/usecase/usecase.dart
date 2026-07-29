import 'package:equatable/equatable.dart';

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class UseCase<Input, Output> {
  Future<Output> call(Input params);
}

abstract class InstantUseCase<Input, Output> {
  Input call(Input params);
}

abstract class StreamUseCase<Input, Output> {
  Stream<Output> call(Input params);
}