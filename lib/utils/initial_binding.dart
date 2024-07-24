import 'package:get/instance_manager.dart';
import 'package:monitoring/controllers/insert_controller.dart';
import 'package:monitoring/controllers/login_controller.dart';
import 'package:monitoring/controllers/monitoring_controller.dart';
import 'package:monitoring/controllers/statistic_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => InsertController(), fenix: true);
    Get.lazyPut(() => MonitoringController(), fenix: true);
    Get.lazyPut(() => StatisticController(), fenix: true);
  }
}
