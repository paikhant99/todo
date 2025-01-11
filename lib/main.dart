import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:todo/views/home_screen.dart';

Locale locale = const Locale('en', 'GB');

void main() async {
  runApp(const Up2TaskApp());
}

class Up2TaskApp extends StatelessWidget {
  const Up2TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: locale,
      debugShowCheckedModeBanner: true,
      home: const HomeScreen(),
      builder: EasyLoading.init(),
      title: 'Up2Task',
    );
  }
}
