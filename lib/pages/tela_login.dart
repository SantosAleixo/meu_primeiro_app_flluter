import 'package:flutter/material.dart';
import 'package:projectflutter/pages/home_page.dart';

class TelaLogin extends StatefulWidget {
  const TelaLogin({super.key});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController usuariocontroller = TextEditingController();
  final TextEditingController senhacontroller = TextEditingController();

  // Método de entrada
  void entrar() {
    if (usuariocontroller.text.isEmpty || senhacontroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Preencha usuário e senha!'),
          backgroundColor: Colors.amber.shade900,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    if (senhacontroller.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('A senha deve conter pelo menos 6 caracteres!'),
          backgroundColor: Colors.red.shade800,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    } else {
      // Navegação caso as validações passem:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  // Liberando recursos
  @override
  void dispose() {
    usuariocontroller.dispose();
    senhacontroller.dispose();
    super.dispose();
  }

  // Interface da tela
  @override
  Widget build(BuildContext context) {
    const Color corPrincipal = Color(0xFF1E3A8A); // Azul Escuro / Marinho

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Acesso ao Sistema'),
        backgroundColor: corPrincipal,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/imagens/logo.png',
                  height: 180,
                  width: 350,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback visual caso a imagem do logo não esteja presente
                    return const Icon(
                      Icons.account_balance_rounded,
                      size: 100,
                      color: corPrincipal,
                    );
                  },
                ),

                const SizedBox(height: 30),

                // Campo de Login (Usuário)
                TextField(
                  controller: usuariocontroller,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Usuário ou E-mail',
                    prefixIcon: const Icon(Icons.person_outline, color: corPrincipal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),

                // Campo de Senha
                TextField(
                  controller: senhacontroller,
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: const Icon(Icons.lock_outline, color: corPrincipal),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 35),

                // Botão Entrar
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: corPrincipal,
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(26),
                      ),
                    ),
                    onPressed: entrar,
                    icon: const Icon(Icons.login_rounded, color: Colors.white),
                    label: const Text(
                      'ENTRAR',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Opções de texto em linha (Esqueci a senha e Criar conta)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Ação de esqueci a senha
                      },
                      child: const Text(
                        'Esqueci a senha',
                        style: TextStyle(
                          color: corPrincipal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Ação de cadastrar
                      },
                      child: const Text(
                        'Criar conta',
                        style: TextStyle(
                          color: corPrincipal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}