part of 'treasury_bloc.dart';

enum TreasuryStatus { initial, loading, loaded, error }

class TreasuryState extends Equatable {
  final TreasuryStatus status;
  final String? message;

  const TreasuryState({this.status = TreasuryStatus.initial, this.message});

  TreasuryState copyWith({TreasuryStatus? status, String? message}) {
    return TreasuryState(status: status ?? this.status, message: message);
  }

  @override
  List<Object?> get props => [status, message];
}
