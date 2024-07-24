import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:monitoring/client/monitoring_client.dart';

class MonitoringController extends GetxController {
  final MonitoringClient _client = MonitoringClient();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<QuerySnapshot> getData(String collection) {
    return firestore.collection(collection).snapshots();
  }

  deleteData(String id) async {
    var result = await _client.deleteMonitoring(id);
    if (result ?? false) {
      update();
    }
  }

  Future logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed('/intro');
    } catch (e) {
      print("Failed to log out: $e");
    }
  }
}
