import 'package:get/get.dart';
import 'package:sqlf_lite_example/view/ListUsers.dart';

import '../home_screen.dart';

class AppRoutes{
  static const HOME = '/home';
  static const LIST_USERS = '/list-users';
}

class AppPages{
  static final routes = [
    GetPage(name: AppRoutes.HOME, page: ()=> HomeScreen()),
    GetPage(name: AppRoutes.LIST_USERS, page: ()=> UserListPage()),
  ];
}