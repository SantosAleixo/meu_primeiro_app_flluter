import 'dart:io';
import 'package:flutter/material.dart';
import '../pages/detalhes_aluno.dart';

class AlunoCard extends StatelessWidget {
  final String nome;
  final String email;
  final String curso;
  final String turma;
  final String foto;
  final VoidCallback? onAtualizar;

  const AlunoCard({
    super.key,
    required this.nome,
    required this.email,
    required this.curso,
    required this.turma,
    required this.foto,
    this.onAtualizar, // Agora aceita a função () { setState(() {}); }
  });

  // Função para identificar dinamicamente a origem da foto
  ImageProvider _obterImagem(String caminhoFoto) {
    if (caminhoFoto.startsWith('http://') || caminhoFoto.startsWith('https://')) {
      return NetworkImage(caminhoFoto);
    } else if (caminhoFoto.startsWith('assets/')) {
      return AssetImage(caminhoFoto);
    } else if (caminhoFoto.isNotEmpty && File(caminhoFoto).existsSync()) {
      return FileImage(File(caminhoFoto));
    }
    // Fallback simples caso não encontre o arquivo local
    return const AssetImage('assets/imagens/Home.png');
  }

  @override
  Widget build(BuildContext context) {
    const Color corPrincipal = Color(0xFF1E3A8A);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: corPrincipal, width: 2),
          ),
          child: CircleAvatar(
            radius: 26,
            backgroundColor: Colors.grey.shade200,
            backgroundImage: _obterImagem(foto),
            onBackgroundImageError: (exception, stackTrace) {},
          ),
        ),
        title: Text(
          nome,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 2),
            Text(
              email,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Text(
              '$curso • $turma',
              style: const TextStyle(
                color: corPrincipal,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 18,
          color: Colors.grey,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetalheAluno(
                nome: nome,
                email: email,
                curso: curso,
                turma: turma,
                foto: foto,
                onAtualizar: onAtualizar,
              ),
            ),
          );
        },
      ),
    );
  }
}