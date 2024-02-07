import 'dart:async';

import 'package:flutter/material.dart';

//metodo principal - o primeiro a ser chamado para iniciar
void main() {
  runApp(const Aplicativo());
}

class Aplicativo extends StatefulWidget {
  //construção de chave, ajuda o flutter a gerenciar a atualizaçõesde tela
  //A chave Key passada para construtor da superClasse
  const Aplicativo({Key? key}) : super(key: key);

  //serve  para indicar como criar associar um estado/alteração - Atualiza Iinterface
  //State - representa os dados mutáveis de um widget em um momento
  //atualiza a tela sempre que houver alterações
  @override
  State<Aplicativo> createState() => _EstadoAplicativo();
}

//"_" na classe indicsa que a classe só pode ser assesada neste arquivo
//Estado aplicativo herda as caracteristicas de classe State, que está
//vinculada a aplicativo
class _EstadoAplicativo extends State<Aplicativo> {
  //váriaveis
  int contador1 = 0;
  int contador2 = 0;
  int _tempo = 60;
  late Timer _timer;
  bool _clique = true; //bolean - verdadeiro ou falso
  Color cor1 = Colors.black;
  Color cor2 = Colors.black;
  double posicao = 0;

  void movimentar() {
    setState(() {
      if (contador1 > contador2) {
        //imagem fica a esqueda
        posicao = 50.0;
      } else if(contador2 > contador1) {
        //imagem fica a direita
        posicao=MediaQuery.of(context).size.width - 150.0;
      }else {
        //personagem no meio
        posicao = MediaQuery.of(context).size.width / 2 - 50;
      }
    });
  }

  //inicia o que estiver dentro, antes mesmo de carregar a tela - inicia o timer

  @override
  void initState() {
    super.initState();
    _iniciarTimer();
  }

  //cancelar timer - dispose - limpa todos os recursos
  void dispose(){
    _timer.cancel();
    super.dispose;
  }

  void _iniciarTimer(){
    //Timer.periodic executa uma função a cada segundo
    _timer = Timer.periodic(Duration(seconds: 1), (timer) { 
      //se o tempo < que zero, tem diminui (--)
      setState(() {
      if(_tempo > 0) {
        _tempo--;
      }else{
        _timer.cancel;
        _clique = false;
      }
      });
    });
  }

  void _reiniciar(){
    //setState - comunica ao flutter que houve alteração, atualiza toda a tela
    setState(() {
      contador1 = 0;
      contador2 = 0;
      _tempo = 60;
    });
    _timer.cancel();
    _iniciarTimer();
  }

  void mudarCor() {
    if (contador1 > contador2){
      cor1 = Colors.red;
      cor2 = Colors.black;
    } else if (contador2 > contador1){
      cor1 = Colors.black; 
      cor2 = Colors.red;
    } else {
      cor1 = Colors.blue;
      cor2 = Colors.blue;
    }
  }

  //construção do aplicativo - buid
  @override
  Widget build(BuildContext context) {
    mudarCor();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigoAccent,
          title: const Text('Jogo Contador', style: TextStyle(color: Colors.white),),
        ),
        // body - corpo do meu aplicativo
        // center - centralizar esquerda/direita
        body: Stack(
        children: [
        Center(
          //column - organizar tudo em colunas - mainAxix centralizar acima/abaixo
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //representa os filhos do widget column
            children: [
              Text(
                'Contador 1: $contador1',
               style: TextStyle(fontSize: 30, color: cor1),
              ),
              SizedBox(height: 20),
              Text(
                'Contador 2: $contador2',
                style: TextStyle(fontSize: 30, color: cor2),
              ),
              SizedBox(height: 30),

              Text(
                'Tempo restante: $_tempo segundos',
              style: TextStyle(fontSize: 30),
              ),

            ],
          ),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 500),
          bottom: 100.0,
          left: posicao,
          curve: Curves.easeInOut,
          child: Image.network(
            'https://cdn.pixabay.com/photo/2023/06/10/05/07/mario-8053171_1280.png', width:100,
             height: 100,
             ),
          ),

        ],
        ),

        floatingActionButton: Row(
          //define o espaçamento entre os botões
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              //ESPAÇAMENTO INTERNO AO REDOR DO WIDGET - EDGETINSERTONLINY ó um lado
            padding:const EdgeInsets.only(left: 50.0),
            //colocando o botão flutuante
            child: FloatingActionButton(
              //onPressed: (_clique ? (){ setState( () { contador1++; }); } : null  
              onPressed: () {
                //sinaliza que houve mudança, para atualizar a tela
                setState(() {
                  //adicionar +1 na váriavel contador
                  if (_clique == true){
                    contador1++;
                    movimentar();
                  }
                  
                });
              },
              tooltip: 'Incrementar Contador 1',  
              child: Icon(Icons.add),          
            ),
            ),

            FloatingActionButton(
              onPressed: _reiniciar,
              tooltip: 'Zerar Contagem',
              child: Icon(Icons.refresh),
              ),

          Padding(
            padding: const EdgeInsets.only(right: 20.00),
            child: FloatingActionButton(
              onPressed: (){
                setState(() {
                  if (_clique = true) {
                    contador2++;
                    movimentar();
                  }
                });
              },
              tooltip: '  Icrementar contador 2',
              child: Icon(Icons.add),
            ),

            ),

          ],
        ),
      ),
    );
  }
}
