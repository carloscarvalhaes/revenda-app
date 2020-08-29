import 'package:flutter/material.dart';

import 'package:revenda_clone/app/components/bullet.dart';
import 'package:revenda_clone/app/components/value_animation.dart';
import 'package:revenda_clone/app/model/revenda_model.dart';

class DetalhePage extends StatefulWidget {
  static String routerName = '/detalhe';
  final RevendaModel revenda;

  const DetalhePage({
    Key key,
    @required this.revenda,
  }) : super(key: key);

  @override
  _DetalhePageState createState() => _DetalhePageState(revenda: revenda);
}

class _DetalhePageState extends State<DetalhePage> {
  final RevendaModel revenda;
  int totalProduto = 1;

  _DetalhePageState({@required this.revenda});

  var appBar = AppBar(
    title: Text('Selecionar Produtos'),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '?',
          style: TextStyle(fontSize: 30),
        ),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.grey[200],
      body: Container(
        height: MediaQuery.of(context).size.height -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            _buildTitle(),
            _buildSubtitle(),
            _buildCard(),
            Expanded(child: SizedBox()),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      margin: EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey[300], blurRadius: 10, offset: Offset(0, 5)),
        ],
      ),
      padding: EdgeInsets.all(30),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Bullet(
            label: 'Comprar',
            enabled: true,
          ),
          Expanded(
            child: Column(
              children: [
                Divider(color: Colors.grey),
                SizedBox(height: 25),
              ],
            ),
          ),
          const Bullet(
            label: 'Pagamento',
            enabled: false,
          ),
          Expanded(
            child: Column(
              children: [
                Divider(color: Colors.grey),
                SizedBox(height: 25),
              ],
            ),
          ),
          const Bullet(
            label: 'Confirmação',
            enabled: false,
          )
        ],
      ),
    );
  }

  Widget _buildSubtitle() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: Color(int.parse('FF${revenda.cor}', radix: 16)),
                borderRadius: BorderRadius.circular(100)),
            child: Center(
              child: Text(
                totalProduto.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text('${revenda.nome} - Botijão 13kg'),
            ),
          ),
          _buildRichText()
        ],
      ),
    );
  }

  Widget _buildCard() {
    return Container(
      margin: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.home,
                size: 40,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(revenda.nome),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text(revenda.nota.toString()),
                        Icon(Icons.star, color: Colors.orange),
                        Text('${revenda.tempoMedio}min')
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    color: Color(int.parse('FF${revenda.cor}', radix: 16)),
                    child: Text(revenda.tipo,
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ],
          ),
          Divider(),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Botijão de 13kg'),
                    SizedBox(height: 5),
                    Text(revenda.nome),
                    SizedBox(height: 5),
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black),
                        children: [
                          TextSpan(
                            text: 'R\$',
                            style: TextStyle(fontSize: 10, color: Colors.black),
                          ),
                          TextSpan(
                            text:
                                '${revenda.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey,
                      ),
                      child: InkWell(
                        child: Icon(Icons.remove, color: Colors.black),
                        onTap: () => this.removerProduto(),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://infoeds.com.br/wp-content/uploads/2017/11/prod_icon-gas.png',
                          ),
                        ),
                      ),
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 12),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.orange),
                          child: Text(totalProduto.toString()),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey,
                      ),
                      child: InkWell(
                        child: Icon(Icons.add, color: Colors.black),
                        onTap: () => this.addProduto(),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildRichText() {
    var preco = revenda.preco * totalProduto;
    return ValueAnimation(
      value: preco,
    );
  }

  Widget _buildButton() {
    return Container(
      margin: EdgeInsets.only(bottom: 50),
      child: RaisedButton(
        onPressed: () {},
        textColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        padding: EdgeInsets.all(0),
        child: Container(
          child: Center(
            child: Text(
              'Ir para o pagamento',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          width: 300,
          height: 80,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[300], Colors.blue[700]],
              ),
              borderRadius: BorderRadius.circular(50)),
        ),
      ),
    );
  }

  void addProduto() {
    setState(() {
      totalProduto += 1;
    });
  }

  void removerProduto() {
    if (totalProduto == 0) {
      return;
    }
    setState(() {
      totalProduto--;
    });
  }
}
