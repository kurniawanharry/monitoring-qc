import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitoring/controllers/insert_controller.dart';
import 'package:monitoring/controllers/statistic_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          OutlinedButton(
              onPressed: () =>
                  Get.toNamed('/insert')?.then((value) => Get.delete<InsertController>()),
              child: const Text('Input Data')),
          OutlinedButton(
            onPressed: () => Get.toNamed('/list'),
            child: const Text('Data List'),
          ),
          OutlinedButton(
            onPressed: () => Get.toNamed('/monitoring')?.then(
              (value) => Get.delete<StatisticController>(),
            ),
            child: const Text('Monitoring'),
          ),
          OutlinedButton(onPressed: () => logout(), child: const Text('Logout')),
        ],
      ),
    );
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
