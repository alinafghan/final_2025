part of 'data_cubit.dart';

class DataState extends Equatable {
  const DataState();

  @override
  List<Object> get props => [];
}

final class DataInitial extends DataState {}

final class DataSaveLoading extends DataState {}

final class DataSaveLoaded extends DataState {
  Data data;
  DataSaveLoaded({required this.data});
  @override
  List<Object> get props => [data];
}

final class DataSaveError extends DataState {}
