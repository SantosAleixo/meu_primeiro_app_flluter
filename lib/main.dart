// Importa o pacote princiapl do Flutter.
// Esse pacote cntém os widgets visuais do Material Design,
// como MaterialApp, Scaffold, AppBar, Texte, Icon, entre outros.
import 'package:flutter/material.dart';
import 'package:projectflutter/pages/tela_login.dart';


// Essa tela foi criada dentro da pasta pages.
/*import 'pages/tela_inicial.dart';*/

// Função principal do aplicativo.
// Todo aplicativo Flutter começa sua execução por aqui.
void main(){
  //runApp inicia o aplicativo Flutter.
  // Estamos dizendo que o widget principal será MeuApp.
  runApp(const MeuApp());
}

// Classe principal ao aplicativo.
// Ela representa a configuração geral do app.
class MeuApp extends StatelessWidget {
  // Construtor da classe MeuApp.
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    //MetrialApp configura a base do aplicativo Flutter.
    // Ele define o título, o tema visual e a tela inicial.
    return MaterialApp(
      // Titulo interno do aplicativo.
      title: 'Login',

      // Remove a faixa vermelha de DEBUG que aparece no canto superior.
      debugShowCheckedModeBanner: false,

      // Define o tema visual do aplicativo.
      theme: ThemeData(
        // Define a cor princiapl do aplicativo como indigo.
        primarySwatch:  Colors.indigo,

        // Ativa o padrão visual mais atual do Material Design.
        useMaterial3: true,
      ),

      // Define qual será a primeira tela exibida ao abrir o aplicativo.
      home: const TelaLogin(),
    ) ;
  }
}



