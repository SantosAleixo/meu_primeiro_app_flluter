import 'package:flutter/material.dart';
import '../widgets/aluno_card.dart';

List<Map<String, String>> alunosCadastrados = [
  {
    'foto': 'https://i.pravatar.cc/150?img=11',
    'nome': 'Luis Eduardo',
    'email': 'luís.corinthians@email.com',
    'curso': 'Desenvolvimento de Sistemas',
    'turma': 'Turma B - Noite',
  },
  {
    'foto': 'https://i.pravatar.cc/150?img=5',
    'nome': 'Larissa Rodrigues',
    'email': 'larissa.leal@email.com',
    'curso': 'Desenvolvimento de Sistemas',
    'turma': 'Turma A - Noite',
  },
];

class ListaAlunos extends StatefulWidget {
  final VoidCallback? onAtualizar;

  const ListaAlunos({super.key, this.onAtualizar});

  @override
  State<ListaAlunos> createState() => _ListaAlunosState();
}

class _ListaAlunosState extends State<ListaAlunos> {
  @override
  Widget build(BuildContext context) {
    const Color corPrincipal = Color(0xFF1E3A8A); // Azul Escuro / Marinho

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Alunos Cadastrados'),
        backgroundColor: corPrincipal,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: alunosCadastrados.isEmpty
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person_off_rounded,
                size: 80,
                color: Colors.grey.shade400,
              ),
              const SizedBox(height: 16),
              Text(
                'Nenhum aluno cadastrado.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cabeçalho / Subtítulo informativo
            Row(
              children: [
                const Icon(
                  Icons.info_outline_rounded,
                  size: 20,
                  color: corPrincipal,
                ),
                const SizedBox(width: 8),
                Text(
                  'Toque em um aluno para ver os detalhes',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Lista de Alunos
            Expanded(
              child: ListView.separated(
                itemCount: alunosCadastrados.length,
                separatorBuilder: (context, index) =>
                const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final aluno = alunosCadastrados[index];
                  return AlunoCard(
                    nome: aluno['nome']!,
                    email: aluno['email']!,
                    curso: aluno['curso']!,
                    turma: aluno['turma']!,
                    foto: aluno['foto']!,
                    onAtualizar: () {
                      setState(() {});
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}