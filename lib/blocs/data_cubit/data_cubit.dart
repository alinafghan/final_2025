import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_2025/models/data.dart';
import 'package:final_2025/repositories/data_repository.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataRepository dataRepository = DataRepository();
  DataCubit({required this.dataRepository}) : super(DataInitial());

  Future<Data> saveData(Data data) async {
    emit(DataSaveLoading());
    try {
      Data savedData = await dataRepository.saveData(data);
      emit(DataSaveLoaded(data: savedData));
      return savedData;
    } catch (e) {
      emit(DataSaveError());
      rethrow;
    }
  }

  Future<List<Data>> getAllData() async {
    emit(GetAllDataLoading());
    try {
      List<Data> dataList = await dataRepository.fetchData();
      emit(GetAllDataLoaded(list: dataList));
      return dataList;
    } catch (e) {
      emit(GetAllDataError());
      rethrow;
    }
  }

  Future<void> updateData(Data data) async {
    emit(UpdateDataLoading());
    try {
      await dataRepository.updateData(data);
      emit(UpdateDataLoaded());
    } catch (e) {
      emit(UpdateDataError());
      rethrow;
    }
  }

  Future<void> deleteData(String id) async {
    emit(DeleteDataLoading());
    try {
      await dataRepository.deleteData(id);
      emit(DeleteDataLoaded());
    } catch (e) {
      emit(DeleteDataError());
      rethrow;
    }
  }
}
