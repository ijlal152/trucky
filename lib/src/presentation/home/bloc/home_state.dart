part of 'home_bloc.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final String? message;

  const HomeState({this.status = HomeStatus.initial, this.message});

  HomeState copyWith({HomeStatus? status, String? message}) {
    return HomeState(status: status ?? this.status, message: message);
  }

  @override
  List<Object?> get props => [status, message];
}
