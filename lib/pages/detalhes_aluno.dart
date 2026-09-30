import 'dart:io';
import 'package:flutter/material.dart';
import 'package:projectflutter/pages/lista_alunos.dart';

class DetalheAluno extends StatelessWidget {
  final String nome;
  final String email;
  final String curso;
  final String turma;
  final String foto;
  final VoidCallback? onAtualizar;

  const DetalheAluno({
    super.key,
    required this.nome,
    required this.email,
    required this.curso,
    required this.turma,
    required this.foto,
    this.onAtualizar,
  });

  // Função auxiliar para carregar a imagem correta (URL, Arquivo Local ou Asset)
  ImageProvider _obterImagem(String caminhoFoto) {
    if (caminhoFoto.startsWith('http://') || caminhoFoto.startsWith('https://')) {
      return NetworkImage(caminhoFoto);
    } else if (caminhoFoto.startsWith('assets/')) {
      return AssetImage(caminhoFoto);
    } else if (caminhoFoto.isNotEmpty) {
      return FileImage(File(caminhoFoto));
    }
    return const AssetImage('assets/imagens/placeholder.png');
  }
  void _confirmarExclusao(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir Aluno'),
        content: Text('Deseja realmente excluir o aluno $nome?'),
        actions: [
          // Botão para cancelar a ação
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          // Botão em vermelho para confirmar
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              // Removes o mapa correspondente pelo campo 'nome'
              alunosCadastrados.removeWhere((aluno) => aluno['nome'] == nome);

              // Executa a função recebida para atualizar a tela anterior
              onAtualizar?.call();

              // Fecha a caixa de diálogo
              Navigator.pop(context);

              // Fecha a tela de DetalheAluno e volta para a ListaAlunos
              Navigator.pop(context);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$nome foi removido com sucesso.')),
              );
            },
            child: const Text('Excluir'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color corPrincipal = Color(0xFF1E3A8A); // Azul Escuro / Marinho

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Detalhes do Aluno'),
        backgroundColor: corPrincipal,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar com borda decorativa e sombra
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: corPrincipal, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: _obterImagem(foto),
                ),
              ),

              const SizedBox(height: 20),

              // Nome do Aluno
              Text(
                nome,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 4),

              // E-mail do Aluno
              Text(
                email,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              // Card com Informações Acadêmicas
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.school_rounded, color: corPrincipal),
                        title: const Text(
                          'Curso',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          curso,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      const Divider(indent: 16, endIndent: 16),
                      ListTile(
                        leading: const Icon(Icons.groups_rounded, color: corPrincipal),
                        title: const Text(
                          'Turma',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Text(
                          turma,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _confirmarExclusao(context),
                  icon: const Icon(Icons.delete),
                  label: const Text('Excluir Aluno'),
                ),
              ),


              const SizedBox(height: 12),

              // Botão Voltar
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: corPrincipal, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_back_rounded, color: corPrincipal),
                  label: const Text(
                    'Voltar',
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
    );
  }
}