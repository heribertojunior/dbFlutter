import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _recuperarBandoDados() async {
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "banco.db");

    var retorno = await openDatabase(
      localBancoDados,
      version: 1,
      onCreate: (db, dbversion) {
        //criação do bd
        String sql =
            "CREATE TABLE usuarios(idusuario INTEGER PRUMARY KEY AUTOINCREMENT, nome VARCHAR,idade INTEGER)";
        db.execute(sql);
      },
    );
    print("aberto: " + retorno.isOpen.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
