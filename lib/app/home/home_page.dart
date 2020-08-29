import 'package:flutter/material.dart';
import 'package:revenda_clone/app/detalhe/detalhe_page.dart';
import 'package:revenda_clone/app/home/components/tag_melhor_preco.dart';
import 'package:revenda_clone/app/model/revenda_model.dart';
import 'package:revenda_clone/app/repositories/revendas_repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> filtros = [
    'Melhor avaliação',
    'Mais Rápido',
    'Mais Barato'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: _makeAppBar(),
        body: Column(
          children: [
            _makeLocation(),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<RevendaModel>>(
                future: RevendasRepository().buscarTodasRevendas(),
                builder: (_, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Container();
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    case ConnectionState.active:
                    case ConnectionState.done:
                      var data = snapshot.data;
                      return ListView.builder(
                        itemBuilder: (_, index) {
                          return _buildRevenda(data[index]);
                        },
                        itemCount: data.length,
                      );
                    default:
                      return Container();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRevenda(RevendaModel revenda) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, DetalhePage.routerName, arguments: revenda),
      child: Container(
        margin: EdgeInsets.all(15),
        height: 120,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              width: 40,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Color(int.parse('FF${revenda.cor}', radix: 16)),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child: RotatedBox(
                quarterTurns: -1,
                child: Center(
                  child: Text(
                    revenda.tipo,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(child: Text(revenda.nome)),
                          Visibility(
                            child: TagMelhorPreco(),
                            visible: revenda.melhorPreco,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(revenda.nota.toString(),
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey)),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  Text('4.5',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                  Icon(Icons.star, color: Colors.yellow)
                                ],
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Tempo Médio',
                                  style: TextStyle(
                                      fontSize: 13, color: Colors.grey)),
                              SizedBox(height: 8),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children: [
                                    TextSpan(
                                      text: revenda.tempoMedio,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                      text: 'min',
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Preço',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'R\$ ${revenda.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _makeAppBar() {
    return AppBar(
      title: Text(
        'Escolha uma Revenda',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: [
        PopupMenuButton(
          icon: Icon(Icons.swap_vert),
          itemBuilder: (_) {
            return filtros.map((e) {
              return PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(e),
                    Checkbox(
                      value: false,
                      onChanged: (bool value) {},
                    ),
                  ],
                ),
              );
            }).toList();
          },
        ),
        PopupMenuButton(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '?',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          itemBuilder: (_) {
            return [
              PopupMenuItem(
                child: Text(
                  'Suporte',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              PopupMenuItem(
                child: Text(
                  'Termos de Serviço',
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ];
          },
        )
      ],
    );
  }

  Widget _makeLocation() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Botijões de 13kg em',
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
                Text(
                  'Av Paulist, 1000',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Paulista, São Paulo, SP',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 30,
              ),
              Text(
                'Mudar',
                style: TextStyle(color: Colors.blue),
              )
            ],
          )
        ],
      ),
    );
  }
}
