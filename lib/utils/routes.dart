import 'package:get/get.dart';
import 'package:monitoring/main.dart';
import 'package:monitoring/pages/home_page.dart';
import 'package:monitoring/pages/insert_page.dart';
import 'package:monitoring/pages/intro_page.dart';
import 'package:monitoring/pages/list_page.dart';
import 'package:monitoring/pages/login_page.dart';
import 'package:monitoring/pages/monitoring_page.dart';

class Routes {
  static const initial = "/intro";
  static final routes = [
    GetPage(name: "/", page: () => const MyApp()),
    GetPage(name: "/intro", page: () => const IntroPage()),
    GetPage(name: "/home", page: () => const HomePage()),
    GetPage(name: "/login", page: () => const LoginPage()),
    GetPage(name: "/insert", page: () => const InsertPage()),
    GetPage(name: "/list", page: () => const ListPage()),
    GetPage(name: "/monitoring", page: () => const MonitoringPage()),
  ];
}
