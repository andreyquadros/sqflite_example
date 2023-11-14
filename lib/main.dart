import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqlf_lite_example/routes/AppRoutes.dart';
import 'package:sqlf_lite_example/view/ListUsers.dart';


void main(){
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: UserListPage(),
    initialRoute: AppRoutes.HOME,
    getPages: AppPages.routes,
  ));
}
