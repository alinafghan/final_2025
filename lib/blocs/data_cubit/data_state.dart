part of 'data_cubit.dart';

class DataState extends Equatable {
  const DataState();

  @override
  List<Object> get props => [];
}

final class DataInitial extends DataState {}

final class DataSaveLoading extends DataState {}

final class DataSaveLoaded extends DataState {
  final Data data;
  const DataSaveLoaded({required this.data});
  @override
  List<Object> get props => [data];
}

final class DataSaveError extends DataState {}

final class GetAllDataLoading extends DataState {}

final class GetAllDataLoaded extends DataState {
  final List<Data> list;

  const GetAllDataLoaded({required this.list});
  @override
  List<Object> get props => [list];
}

final class GetAllDataError extends DataState {}

final class UpdateDataLoading extends DataState {}

final class UpdateDataLoaded extends DataState {}

final class UpdateDataError extends DataState {}

final class DeleteDataLoading extends DataState {}

final class DeleteDataLoaded extends DataState {}

final class DeleteDataError extends DataState {}
