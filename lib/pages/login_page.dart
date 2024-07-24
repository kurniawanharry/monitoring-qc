import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monitoring/controllers/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SafeArea(
          child: Stack(
            children: [
              const Align(
                alignment: Alignment.topCenter,
                child: FittedBox(
                  child: Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Text(
                      'Monitroing QC',
                    ),
                  ),
                ),
              ),
              Form(
                key: controller.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: controller.emailController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email_outlined),
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Email masih kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: controller.passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock_outlined),
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Password masih kosong';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(double.maxFinite, 50),
                        backgroundColor: Colors.pink.shade600,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () => controller.submit(),
                      child: Obx(
                        () => controller.loading.isFalse
                            ? Text(controller.isRegis.isTrue ? 'Register' : 'Login')
                            : const SizedBox(
                                height: 10,
                                width: 10,
                                child: CircularProgressIndicator(),
                              ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => Text.rich(
                        TextSpan(
                          text: controller.isRegis.isTrue
                              ? 'Sudah punya akun? '
                              : 'Belum punya akun? ',
                          children: [
                            TextSpan(
                              text: controller.isRegis.isTrue ? 'Login' : 'Daftar',
                              style: const TextStyle(
                                color: Colors.blue,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => controller.toggleRegis(),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
