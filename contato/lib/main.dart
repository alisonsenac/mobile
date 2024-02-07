import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const Contato());
}

class Contato extends StatelessWidget{
  //necessário para inicializar a widget, passa para a classe pai
  const Contato({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fluter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(246, 21, 21, 22)),
        useMaterial3: true
      ),
      home: const Principal(title: 'Contato Pessoal'),
    );
  }
}

class Principal extends StatefulWidget {
  //passa parâmetros informações para dentro dessa classe
  const Principal({super.key, required this.title});

  final String title;

  //CRIA UM ESTADO QUE VAI SE REFERIR A CLASSE _PRINCIPALESTADO
  @override
  State<Principal> createState() => _PrincipalEstado();
}
//Classe _PrincipalEstado herdando o Estado - Estado vai ficar atualizando
class _PrincipalEstado extends State<Principal> {

  final foto = const CircleAvatar(
    backgroundColor: Colors.black,
    backgroundImage: NetworkImage("https://a.espncdn.com/combiner/i?img=/i/teamlogos/soccer/500/874.png"),
    radius: 150,                                                                                                                 
  );

  final nome = const Text(
    'Alison Souza',
    style: TextStyle(fontSize: 30),
    textAlign: TextAlign.center,
  );

  final obs = const Text(
    'Programador Full Stack Senac',
    style: TextStyle(fontSize: 20, color: Colors.blue),
    textAlign: TextAlign.center,
  );

  final email = IconButton(
    icon: const Icon(Icons.mail),
    color: Colors.blue,
    onPressed: () {
      launchUrl(Uri (scheme: 'mailto', 
      path: 'alison.7907@aluno.pr.senac.br',
        queryParameters: {
          'subject': 'Assunto do email',
          'body': 'Corpo do Email',
        },
      ));
    },
  );

  final telefone = IconButton(
    icon: const Icon(Icons.phone),
    color: Colors.blue,
    onPressed: () {
      launchUrl(Uri(scheme: 'tel', path: '+5544998205849'));
    },
  );
  
  final sms = IconButton(
    color: Colors.blue,
    icon: const Icon(Icons.sms),
    onPressed: () {
      launchUrl(Uri(scheme: 'sms', path: '+5544998205849'));
    },
  );

  final site = IconButton(
    color: Colors.blue,
    icon: const Icon(Icons.open_in_browser),
    onPressed: () {
      launchUrl(Uri.parse(
      'https://www.linkedin.com/in/alison-moreira-204396281/'));
    },
  );

   final whatsapp = IconButton(
    color: Colors.blue,
    icon: const Icon(Icons.wechat),
    onPressed: () {
      launchUrl(Uri.parse('https:api.whatsapp/+5544998205849'));
    },
  );

  final mapa = IconButton(
    color: Colors.blue,
    icon: const Icon(Icons.map),
    onPressed: () {
      launchUrl(Uri.parse('https:/maps.app.goo.gl/ALo7Wacl'));
    },
  ); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
        'Aplicativo de Contato',
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
      ),

      //Organizar em coluna
      body: Column(
        //alinhar conteudo no sentro - acima/abaixo
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          foto, nome, obs,

          Text('corinthians'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              email,
              telefone,
              sms,
              site,
            ],
            //botões do aplicativo
          )
        ],
      ),
    );

  }
}