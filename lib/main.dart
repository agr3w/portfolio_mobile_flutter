import 'package:flutter/material.dart';

void main() {
  runApp(const MeuPortfolioApp());
}

class MeuPortfolioApp extends StatelessWidget {
  const MeuPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // [REQUISITO - Fase 1.3] Cores Hexadecimais Dinâmicas
        primaryColor: const Color(0xFFFFC107), 
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isPauloVisible = true; 

  @override
  void initState() {
    super.initState();
    // Ouvinte que detecta a rolagem para mover os botões flutuantes
    _scrollController.addListener(() {
      // TRAVA DE SEGURANÇA: Só executa se o scroll já estiver construído na tela
      if (_scrollController.hasClients) {
        // Lê a dimensão do scroll ao invés do MediaQuery para evitar o erro do framework
        final threshold = _scrollController.position.viewportDimension * 0.5;
        final isTop = _scrollController.offset < threshold;
        
        if (_isPauloVisible != isTop) {
          setState(() {
            _isPauloVisible = isTop;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height - kToolbarHeight;

    // ============================================================================
    // [REQUISITO - Fase 2] O Desafio do Scaffold
    // ============================================================================
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFC107),
        elevation: 0,
        leading: const Icon(Icons.menu, color: Colors.black),
        title: const Text(
          'Portfólio Devs',
          // [REQUISITO - Fase 1.2] Estilização de Texto (style)
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
      ),
      
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Tela 1: Paulo Sergio
                _buildProfileSection(
                  height: screenHeight,
                  name: 'Paulo Sergio',
                  role: 'Desenvolvedor Mobile',
                  bio: 'Focado em criar as melhores experiências nativas e híbridas. Transformando ideias complexas em aplicativos móveis de alta performance.',
                  skills: ['Flutter', 'Dart', 'Firebase', 'SQLite'],
                  // [REQUISITO - Fase 1.1] Imagens da Web via URL
                  imageUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?q=80&w=500&auto=format&fit=crop',
                  isImageOnRight: true,
                ),

                // Tela 2: Weslley Kampa
                _buildProfileSection(
                  height: screenHeight,
                  name: 'Weslley Kampa',
                  role: 'Desenvolvedor Web',
                  bio: 'Especialista na criação de interfaces modernas e performáticas com React.js e Vite. Desenvolvendo plataformas web robustas e inovadoras.',
                  skills: ['React.js', 'Vite', 'JavaScript', 'UX/UI'],
                  imageUrl: 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?q=80&w=500&auto=format&fit=crop',
                  isImageOnRight: false,
                ),

                // Tela 3: Projetos e Contato
                _buildProjectsSection(height: screenHeight),
              ],
            ),
          ),
          AnimatedPositionedDirectional(
            duration: const Duration(milliseconds: 260),
            curve: Curves.easeInOut,
            bottom: 24,
            start: _isPauloVisible ? null : 24,
            end: _isPauloVisible ? 24 : null,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  heroTag: 'github_btn',
                  onPressed: () {},
                  backgroundColor: const Color(0xFF1A1A1A),
                  child: const Icon(Icons.code, color: Colors.white),
                ),
                const SizedBox(height: 16),
                FloatingActionButton(
                  heroTag: 'linkedin_btn',
                  onPressed: () {},
                  backgroundColor: const Color(0xFF0077B5),
                  child: const Icon(Icons.business, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // COMPONENTE: Perfil
  // ============================================================================
  Widget _buildProfileSection({
    required double height,
    required String name,
    required String role,
    required String bio,
    required List<String> skills,
    required String imageUrl,
    required bool isImageOnRight,
  }) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // [REQUISITO - Fase 1.1] CircleAvatar com Imagem da Web
          Positioned(
            right: isImageOnRight ? -60 : null,
            left: isImageOnRight ? null : -60,
            top: height * 0.15,
            child: CircleAvatar(
              radius: 120,
              backgroundColor: Colors.grey.shade400,
              backgroundImage: NetworkImage(imageUrl),
            ),
          ),

          Positioned(
            left: isImageOnRight ? 24 : null,
            right: isImageOnRight ? null : 24,
            top: height * 0.25,
            width: MediaQuery.of(context).size.width * 0.65, 
            child: Column(
              crossAxisAlignment: isImageOnRight ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)), 
                ),
                Text(
                  role,
                  style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),
                Text(
                  bio,
                  textAlign: isImageOnRight ? TextAlign.left : TextAlign.right,
                  style: const TextStyle(fontSize: 14, height: 1.5, color: Color(0xFF4A4A4A)),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: isImageOnRight ? WrapAlignment.start : WrapAlignment.end,
                  children: skills.map((skill) => Chip(
                    label: Text(skill, style: const TextStyle(fontSize: 12)),
                    backgroundColor: const Color(0xFFFFC107).withValues(alpha: 0.2),
                    side: BorderSide.none,
                  )).toList(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================================
  // COMPONENTE: Projetos e Contato
  // ============================================================================
  Widget _buildProjectsSection({required double height}) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Card(
            // ============================================================================
            // [DESAFIO EXTRA - Fase 1.4] Sombras e Elevação (elevation)
            // ============================================================================
            elevation: 12, 
            shadowColor: Colors.black.withValues(alpha: 0.4),
            color: const Color(0xFFF8F9FA),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Nosso Trabalho Conjunto',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(height: 3, width: 60, color: const Color(0xFFFFC107)),
                  const SizedBox(height: 20),
                  const Text(
                    'Unimos o front-end web veloz e responsivo com a excelência dos aplicativos nativos para construir projetos incríveis.\n\nProntos para o próximo desafio!',
                    textAlign: TextAlign.center,
                    style: TextStyle(height: 1.5, fontSize: 15),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.mail_outline),
                    label: const Text('Iniciar Projeto'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A1A1A),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
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