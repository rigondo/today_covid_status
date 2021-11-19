import 'package:covid/src/app.dart';
import 'package:covid/src/controller/covid_statistics_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid',
      initialBinding: BindingsBuilder((){
        Get.put(CovidStatisticsController());
      }),
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: App(),
    );
  }
}
