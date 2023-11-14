import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../database/user_provider.dart';
import '../routes/AppRoutes.dart';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {

  final UserProvider _userProvider = UserProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Listagem de Usuários Cadastrados',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          TextButton.icon(onPressed: (){
            Get.offNamed(AppRoutes.HOME);
          }, icon: Icon(Icons.app_registration), label: Text('Registrar Novo Usuário', style: TextStyle(color: Colors.white),))
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _userProvider.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index]['name']),
                  subtitle: Text('Email: ${snapshot.data![index]['email']}'),
                );
              },
            );
          } else {
            return Text('Nenhum usuário encontrado.');
          }
        },
      ),
    );
  }
}