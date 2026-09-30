import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'lista_alunos.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController nomecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController cursocontroller = TextEditingController();
  final TextEditingController turmacontroller = TextEditingController();

  // Guardamos o arquivo temporário selecionado da galeria/emulador
  File? _imagemSelecionada;

  // Função para abrir a galeria do emulador/celular
  Future<void> _selecionarImagem() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagem = await picker.pickImage(source: ImageSource.gallery);

    if (imagem != null) {
      setState(() {
        _imagemSelecionada = File(imagem.path);
      });
    }
  }

  void salvarCadastro() {
    if (formKey.currentState!.validate()) {
      alunosCadastrados.add({
        'nome': nomecontroller.text.trim(),
        'email': emailcontroller.text.trim(),
        'curso': cursocontroller.text.trim(),
        'turma': turmacontroller.text.trim(),
        // Salvamos o caminho do arquivo (path) ou uma imagem padrão
        'foto': _imagemSelecionada != null
            ? _imagemSelecionada!.path
            : 'https://i.pravatar.cc/150?img=12',
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Aluno cadastrado com sucesso!'),
          backgroundColor: Colors.green.shade700,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );

      nomecontroller.clear();
      emailcontroller.clear();
      cursocontroller.clear();
      turmacontroller.clear();
      setState(() {
        _imagemSelecionada = null;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const ListaAlunos(),
        ),
      );
    }
  }


  @override
  void dispose() {
    nomecontroller.dispose();
    emailcontroller.dispose();
    cursocontroller.dispose();
    turmacontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color corPrincipal = Color(0xFF6A1B9A); // Azul Escuro / Marinho

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Cadastro de Aluno'),
        backgroundColor: corPrincipal,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              // Avatar clicável com lápis de edição e botão de seleção
              Center(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: corPrincipal, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage: _imagemSelecionada != null
                            ? FileImage(_imagemSelecionada!)
                            : null,
                        child: _imagemSelecionada == null
                            ? Icon(
                          Icons.person_rounded,
                          size: 55,
                          color: Colors.grey.shade400,
                        )
                            : null,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _selecionarImagem,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: corPrincipal,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // Campo de Nome
              TextFormField(
                controller: nomecontroller,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'Nome completo',
                  prefixIcon: const Icon(Icons.person_outline, color: corPrincipal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe um nome';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo de E-mail
              TextFormField(
                controller: emailcontroller,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: const Icon(Icons.email_outlined, color: corPrincipal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe um e-mail';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo de Curso
              TextFormField(
                controller: cursocontroller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Curso',
                  prefixIcon: const Icon(Icons.school_outlined, color: corPrincipal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe um curso';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Campo de Turma
              TextFormField(
                controller: turmacontroller,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Turma',
                  prefixIcon: const Icon(Icons.groups_outlined, color: corPrincipal),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe uma turma';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 35),

              // Botão Cadastrar Aluno
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: salvarCadastro,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: corPrincipal,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  icon: const Icon(Icons.save_rounded, color: Colors.white),
                  label: const Text(
                    'Salvar Cadastro',
                    style: TextStyle(
                      color: Colors.white,
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