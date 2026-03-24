import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MinhaPagina(),
    );
  }
}

class MinhaPagina extends StatelessWidget {
  const MinhaPagina({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold funciona como o "esqueleto" ou "andaime" da tela [cite: 104]
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5), // Fundo cinza claro
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFC107), // Amarelo em hexadecimal (Requisito 3)
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
      ),
      
      // O SingleChildScrollView permite rolar a tela para baixo ("Desce a pagina")
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            
            // Perfil 1: Paulo Sergio
            _buildProfileSection(
              name: 'Paulo Sergio',
              role: 'Desenvolvedor Mobile',
              // Imagem vinda de URL
              imageUrl: 'https://avatars.githubusercontent.com/u/77137834?v=4', 
            ),
            
            const SizedBox(height: 20),
            
            // Perfil 2: Weslley Kampa
            _buildProfileSection(
              name: 'Weslley Kampa',
              role: 'Desenvolvedor Web',
              imageUrl: 'https://avatars.githubusercontent.com/u/91283681?v=4',
            ),
            
            const SizedBox(height: 40),
            
            // Seção Inferior: Um pouco sobre nós
            _buildAboutSection(),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
      
      // Botão Flutuante (Requisito da Fase 2)
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: const Icon(Icons.share, color: Colors.white),
      ),
    );
  }

  // Criamos uma função separada para não repetir código para os perfis
  Widget _buildProfileSection({required String name, required String role, required String imageUrl}) {
    return SizedBox(
      height: 220, 
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Textos e Ícones alinhados à esquerda
          Positioned(
            left: 24,
            top: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                Text(
                  role,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 50),
                const Row(
                  children: [
                    Icon(Icons.code, size: 35), // Substitua pelos ícones do Github/LinkedIn depois
                    SizedBox(width: 15),
                    Icon(Icons.business, size: 35),
                  ],
                )
              ],
            ),
          ),
          
          // CircleAvatar empurrado para fora da tela na direita
          Positioned(
            right: -80, 
            top: 10,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.grey.shade300,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Card(
        // Desafio Extra: aumentar a sombra para dar mais profundidade [cite: 61]
        // Usamos a propriedade elevation [cite: 63]
        elevation: 8, 
        color: const Color(0xFFF8F9FA),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              const Text(
                'Um pouco sobre nós',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(height: 2, width: 80, color: Colors.black),
              const SizedBox(height: 20),
              const Text(
                'xxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxx',
                textAlign: TextAlign.center,
                style: TextStyle(height: 1.5),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Contate-nos'),
              )
            ],
          ),
        ),
      ),
    );
  }
}