import 'package:flutter/material.dart';
import 'package:projectflutter/pages/lista_alunos.dart';
import 'package:projectflutter/pages/tela_cadastro.dart';
import 'package:projectflutter/pages/tela_login.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color corPrincipal = Color(0xFF121212); // Azul Escuro / Marinho

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Painel Inicial'),
        backgroundColor: corPrincipal,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const TelaLogin()),
                    (route) => false,
              );
            },
            icon: const Icon(Icons.logout_rounded, color: Colors.white),
            tooltip: 'Sair do aplicativo',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Imagem de Destaque da Home
                Image.asset(
                  'assets/imagens/Home.png',
                  height: 200,
                  width: 400,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: corPrincipal.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.dashboard_customize_rounded,
                        size: 90,
                        color: corPrincipal,
                      ),
                    );
                  },
                ),

                const SizedBox(height: 25),

                // Texto explicativo
                Text(
                  'Bem-vindo ao sistema de gestão de alunos.\nSelecione uma das opções abaixo para continuar.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade800,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 40),

                // Botão Cadastrar Aluno
                SizedBox(
                  width: 250,
                  height: 52,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: corPrincipal,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TelaCadastro(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.person_add_alt_1_rounded, color: Colors.white),
                    label: const Text(
                      'Cadastrar Aluno',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Botão Lista de Alunos (Estilo Outlined / Secundário para diferenciar)
                SizedBox(
                  width: 250,
                  height: 52,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: corPrincipal, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ListaAlunos(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.format_list_bulleted_rounded, color: corPrincipal),
                    label: const Text(
                      'Lista de Alunos',
                      style: TextStyle(
                        color: corPrincipal,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}