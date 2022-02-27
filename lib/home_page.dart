
import 'package:flutter/material.dart';
import 'package:http_get_user/pages/user_details.dart';
import 'package:http_get_user/repository/user_repository.dart';
import 'models/user_models.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Data> lista = [];

  @override
  void initState() {
    super.initState();
    UserRepositoy().GetUser().then((map) {
      setState(() {
        lista = map;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'lista de usuario',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: buildPadding(),
    );
  }

  Padding buildPadding() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
          itemCount: lista.isEmpty ? 0 : lista.length,
          itemBuilder: (context, index) {
            var list = lista[index];
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
          }),
    );
  }
}
