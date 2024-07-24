import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitoring/controllers/statistic_controller.dart';
import 'package:monitoring/models/statistic_model.dart';
import 'package:monitoring/widgets/pie.dart';

class MonitoringPage extends GetView<StatisticController> {
  const MonitoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitoring QC'),
      ),
      body: Obx(() {
        if (controller.loading.isTrue) {
          return const Center(
            child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator()),
          );
        } else {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.pink.shade50,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          fit: FlexFit.tight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    color: Colors.amber.shade200,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text('Status OK'),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text('${controller.statusOk}'),
                            ],
                          ),
                        ),
                        Flexible(
                          fit: FlexFit.tight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 10,
                                    width: 10,
                                    color: Colors.blue.shade200,
                                  ),
                                  const SizedBox(width: 5),
                                  const Text('Status NOK'),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Text('${controller.statusNok}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PieChartSample2(
                stat: StatisticModel(
                  statusOk: controller.statusOk.value,
                  statusNok: controller.statusNok.value,
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
