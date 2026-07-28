part of 'analytics_bloc.dart';

enum AnalyticsStatus { initial, loading, loaded, error }

class AnalyticsState extends Equatable {
  final AnalyticsStatus status;
  final String? message;

  const AnalyticsState({this.status = AnalyticsStatus.initial, this.message});

  AnalyticsState copyWith({AnalyticsStatus? status, String? message}) {
    return AnalyticsState(status: status ?? this.status, message: message);
  }

  @override
  List<Object?> get props => [status, message];
}
