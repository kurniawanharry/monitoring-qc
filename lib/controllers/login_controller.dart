import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late BuildContext context;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool isRegis = false.obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    context = Get.context!;
    super.onInit();
  }

  Future<User?> _register() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      return userCredential.user;
      // Successfully registered
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
    return null;
  }

  Future<User?> _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Successfully logged in
      return userCredential.user;
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
    return null;
  }

  submit() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (isRegis.isTrue) {
      _register().then((user) async {
        var user = await _login();
        if (user != null) {
          Get.offNamed('/home');
        }
      });
    } else {
      var user = await _login();
      if (user != null) {
        Get.offNamed('/home');
      }
    }
  }

  toggleRegis() => isRegis.value = !isRegis.value;
}
