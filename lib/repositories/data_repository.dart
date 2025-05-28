import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_2025/models/data.dart';
import 'package:logger/logger.dart';

class DataRepository {
  final Logger _logger = Logger();
  final dataCollection = FirebaseFirestore.instance.collection('Data');

  Future<Data> saveData(Data data) async {
    try {
      DocumentReference docRef = await dataCollection.add(data.toJson());
      return data.copyWith(id: docRef.id);
    } catch (e) {
      _logger.e('Error saving data: $e');
      throw Exception('Failed to save data');
    }
  }

  Future<void> updateData(Data data) async {
    try {
      await dataCollection.doc(data.id).update(data.toJson());
    } catch (e) {
      _logger.e('Error updating data: $e');
      throw Exception('Failed to update data');
    }
  }

  Future<List<Data>> fetchData() async {
    try {
      QuerySnapshot snapshot = await dataCollection.get();
      return snapshot.docs
          .map((doc) => Data.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      _logger.e('Error fetching data: $e');
      throw Exception('Failed to fetch data');
    }
  }

  Future<void> deleteData(String id) async {
    try {
      await dataCollection.doc(id).delete();
    } catch (e) {
      _logger.e('Error deleting data: $e');
      throw Exception('Failed to delete data');
    }
  }
}
