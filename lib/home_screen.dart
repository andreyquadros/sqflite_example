import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqlf_lite_example/routes/AppRoutes.dart';
import 'database/db_helper.dart';
import 'model/user.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();

    Future<void> _submitForm() async {
      if (_formKey.currentState!.validate()) {
        final user = User(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        );

        await DatabaseHelper.instance.addUser(user);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Usuário salvo com sucesso!')));
      }
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text(
            'Página de Registro',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton.icon(onPressed: (){
              Get.offNamed(AppRoutes.LIST_USERS);
            }, icon: Icon(Icons.list_alt), label: Text('Listagem de Usuários', style: TextStyle(color: Colors.white),))
          ],
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nome Completo'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor entre com seu Nome Completo';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'E-mail'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor insira seu E-mail';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Senha'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor entre com a sua senha';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _submitForm();
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Formulário Enviado!')));
                        _nameController.clear();
                        _emailController.clear();
                        _passwordController.clear();
                      }
                    },
                    child: Text('Enviar'),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
