import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:monitoring/models/monitoring_model.dart';

class MonitoringClient {
  Future<bool?> setMonitoring(MonitoringModel request) async {
    try {
      // Reference to the Firestore collection
      CollectionReference collection = FirebaseFirestore.instance.collection('monitoring');

      await collection.add(request.toJson());
      return true;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<bool?> updateMonitoring(String docId, MonitoringModel request) async {
    try {
      // Reference to the Firestore collection
      DocumentReference docRef = FirebaseFirestore.instance.collection('monitoring').doc(docId);

      await docRef.update(request.toJson());
      return true;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  Future<List<MonitoringModel?>?> getMonitorings(String uid) async {
    try {
      // Reference to the Firestore collection
      CollectionReference collection = FirebaseFirestore.instance.collection('monitoring');

      QuerySnapshot querySnapshot = await collection.where('createdBy', isEqualTo: uid).get();

      List<MonitoringModel?> dataList = querySnapshot.docs.map((doc) {
        return MonitoringModel.fromDocumentSnapshot(doc);
      }).toList();

      // Do something with the YourModel objects
      return dataList;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<bool?> deleteMonitoring(String docId) async {
    try {
      // Reference to the Firestore collection
      DocumentReference docRef = FirebaseFirestore.instance.collection('monitoring').doc(docId);

      await docRef.delete();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
