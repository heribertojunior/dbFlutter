import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _recuperarBancoDados() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco.db");

    var retorno = await openDatabase(
      localBancoDados,
      version: 1,
      onCreate: (db, dbversion) {
        //criação do bd
        String sql =
            "CREATE TABLE usuarios (idusuario INTEGER PRIMARY KEY AUTOINCREMENT, nome VARCHAR,idade INTEGER)";
        db.execute(sql);
      },
    );
    //print("aberto: " + retorno.toString());
    return retorno;
  }

  _salvar() async {
    Map<String, dynamic> dadosUser = {"nome": "Jacaina Moita", "idade": 15};
    Database dbs = await _recuperarBancoDados();
    int id = await dbs.insert("usuarios", dadosUser);
    print("salvo: " + id.toString());
  }

  _listar() async {
    Database dbs = await _recuperarBancoDados();
    String sql = "SELECT * FROM usuarios";
    List usuariosLista = await dbs.rawQuery(sql);

    for (var usuario in usuariosLista) {
      print("Id : " + usuario['idusuario'].toString());
      print("Nome : " + usuario['nome']);
      print("Idade : " + usuario['idade'].toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    _listar();
    return Scaffold();
  }
}
