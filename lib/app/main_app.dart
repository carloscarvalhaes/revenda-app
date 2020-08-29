import 'package:flutter/material.dart';
import 'package:revenda_clone/app/detalhe/detalhe_page.dart';
import 'package:revenda_clone/app/home/home_page.dart';
import 'package:revenda_clone/app/model/revenda_model.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      title: 'Revenda Clone',
      routes: {
        DetalhePage.routerName: (_) {
          var revenda = ModalRoute.of(_).settings.arguments as RevendaModel;
          return DetalhePage(
            revenda: revenda,
          );
        }
      },
    );
  }
}
