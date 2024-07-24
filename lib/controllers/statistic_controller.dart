import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:monitoring/client/monitoring_client.dart';

class StatisticController extends GetxController {
  final MonitoringClient _client = MonitoringClient();
  FirebaseAuth auth = FirebaseAuth.instance;

  RxDouble statusOk = 0.0.obs;
  RxDouble statusNok = 0.0.obs;

  RxBool loading = false.obs;

  @override
  void onInit() async {
    loading(true);
    await fetch();
    loading(false);
    super.onInit();
  }

  fetch() async {
    var response = await _client.getMonitorings(auth.currentUser?.uid ?? '');
    if (response?.isNotEmpty ?? false) {
      for (var data in response!) {
        if (data?.status ?? false) {
          statusOk.value += 1;
        } else {
          statusNok.value += 1;
        }
      }
    }
  }
}
