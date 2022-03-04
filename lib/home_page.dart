import 'package:flutter/material.dart';
import 'package:http_get_user/components/skeleton.dart';
import 'package:http_get_user/pages/user_details.dart';
import 'package:http_get_user/repository/user_repository.dart';
import 'models/user_models.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Data> lista = [];

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future loadUser() async {
    setState(() => isLoading = true);
    await Future.delayed(
      const Duration(seconds: 2),
    );
    UserRepositoy().GetUser().then((map) {
      setState(() {
        lista = map;
      });
    });
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: const Text(
          'Lista de Usuarios',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: loadUser,
            icon: const Icon(
              Icons.refresh,
            ),
          ),
        ],
      ),
      body: buildPadding(),
    );
  }

  Padding buildPadding() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
          itemCount: isLoading ? 10 : lista.length,
          itemBuilder: (context, index) {
            if (isLoading) {
              return const Skeleton().buildListTile();
            } else {
              var list = lista[index];
              return buildCard(context, list);
            }
          }),
    );
  }

  Card buildCard(BuildContext context, Data list) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDetais(
                data: list,
              ),
            ),
          );
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              list.avatar.toString(),
            ),
          ),
          title: Text(
            list.lastName.toString(),
          ),
          subtitle: Text(
            list.email.toString(),
          ),
        ),
      ),
    );
  }
}
