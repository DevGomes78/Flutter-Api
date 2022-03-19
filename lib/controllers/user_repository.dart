import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_get_user/models/user_models.dart';

class UserRepositoy {
  Future<List<Data>> GetUser() async {
    List<Data> lista = [];
    final url = Uri.parse('https://reqres.in/api/users?page=2');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decodeJson = jsonDecode(response.body);
      decodeJson['data'].forEach(
            (item) => lista.add(
          Data.fromJson(item),
        ),
      );
      return lista;
    }else{
      throw Exception('erro ao acessar os dados');
    }
  }
}