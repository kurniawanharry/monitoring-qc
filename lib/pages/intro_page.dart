import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 1),
      () {
        User? user = auth.currentUser;
        if (user != null) {
          return Get.offNamed('/home');
        } else {
          return Get.offNamed('/login');
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Text('Intro'),
        ),
      ),
    );
  }
}
