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
    // Pegando a altura total da tela, subtraindo a AppBar e a barra de status do celular
    final screenHeight = MediaQuery.of(context).size.height -
        kToolbarHeight -
        MediaQuery.of(context).padding.top;

    // Scaffold funciona como o "esqueleto" da tela
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: AppBar(
        // Uso obrigatório de Cores Hexadecimais no formato 0xFF
        backgroundColor: const Color(0xFFFFC107), 
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tela 1: Paulo Sergio (Foto na direita)
            _buildProfileSection(
              height: screenHeight,
              name: 'Paulo Sergio',
              role: 'Desenvolvedor Mobile',
              // Foto real vinda de uma URL usando NetworkImage
              imageUrl: 'https://avatars.githubusercontent.com/u/77137834?v=4', 
              isImageOnRight: true,
            ),
            
            // Tela 2: Weslley Kampa (Foto na esquerda)
            _buildProfileSection(
              height: screenHeight,
              name: 'Weslley Kampa',
              role: 'Desenvolvedor Web',
              imageUrl: 'https://avatars.githubusercontent.com/u/91283681?v=4',
              isImageOnRight: false,
            ),
            
            // Tela 3: Um pouco sobre nós
            _buildAboutSection(height: screenHeight),
          ],
        ),
      ),
      
      // Um FloatingActionButton com um ícone e cor que contrastem
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.black,
        child: const Icon(Icons.share, color: Colors.white),
      ),
    );
  }

  // Componente reaproveitável que inverte o layout baseado na variável isImageOnRight
  Widget _buildProfileSection({
    required double height,
    required String name,
    required String role,
    required String imageUrl,
    required bool isImageOnRight,
  }) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Textos alinhados baseados na inversão do layout
          Positioned(
            left: isImageOnRight ? 24 : null,
            right: isImageOnRight ? null : 24,
            top: height * 0.4, 
            child: Column(
              crossAxisAlignment: isImageOnRight ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold), 
                ),
                Text(
                  role,
                  style: const TextStyle(fontSize: 18, color: Colors.black54),
                ),
              ],
            ),
          ),
          
          Positioned(
            right: isImageOnRight ? -80 : null,
            left: isImageOnRight ? null : -80,
            top: height * 0.25,
            child: CircleAvatar(
              radius: 130,
              backgroundColor: Colors.grey.shade400,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),
          
          // Ícones empilhados verticalmente com a animação de Subir
          Positioned(
            right: isImageOnRight ? 24 : null,
            left: isImageOnRight ? null : 24,
            bottom: 40,
            child: TweenAnimationBuilder<Offset>(
              tween: Tween<Offset>(begin: const Offset(0, 50), end: Offset.zero),
              duration: const Duration(milliseconds: 1000),
              curve: Curves.easeOut,
              builder: (context, offset, child) {
                return Transform.translate(
                  offset: offset,
                  child: child,
                );
              },
              child: const Column(
                children: [
                  Icon(Icons.code, size: 40), // Ícones da Galeria Material Icons
                  SizedBox(height: 16),
                  Icon(Icons.business, size: 40), 
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection({required double height}) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Card(
            // Uso do elevation para dar aspecto 3D
            elevation: 12, 
            color: const Color(0xFFF8F9FA),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Um pouco sobre nós',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(height: 2, width: 80, color: Colors.black),
                  const SizedBox(height: 20),
                  const Text(
                    'xxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxx\nxxxxxxxxxxxxxxxxxxxx',
                    textAlign: TextAlign.center,
                    style: TextStyle(height: 1.5, fontSize: 16),
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
        ),
      ),
    );
  }
}