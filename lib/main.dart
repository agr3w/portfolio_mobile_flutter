import 'package:flutter/material.dart';

// ============================================================
//  PONTO DE ENTRADA DO APLICATIVO
// ============================================================
void main() {
  runApp(const PortfolioApp());
}

// ============================================================
//  PALETA DE CORES HEXADECIMAIS (requisito da atividade)
//  Pesquisa: coolors.co / material.io
// ============================================================
class AppColors {
  static const Color amarelo       = Color(0xFFFFCC00); // cor primária
  static const Color amareloEscuro = Color(0xFFE6B800); // hover / sombra
  static const Color preto         = Color(0xFF0D0D0D); // fundo principal
  static const Color cinzaEscuro   = Color(0xFF1A1A1A); // cards
  static const Color cinzaMedio    = Color(0xFF2B2B2B); // divisores
  static const Color cinzaTexto    = Color(0xFF9E9E9E); // texto secundário
  static const Color branco        = Color(0xFFFFFFFF); // texto principal
}

// ============================================================
//  DADOS DOS INTEGRANTES
// ============================================================
class Membro {
  final String nome;
  final String cargo;
  final String bio;
  final String fotoUrl;
  final String github;
  final String linkedin;

  const Membro({
    required this.nome,
    required this.cargo,
    required this.bio,
    required this.fotoUrl,
    required this.github,
    required this.linkedin,
  });
}
// ============================================================
// Dados Mockados dos membros da equipe
// ============================================================
const List<Membro> equipe = [
  Membro(
    nome: 'Paulo Sergio',
    cargo: 'Desenvolvedor Mobile',
    bio:
        'Estudante de Análise e Desenvolvimento de Sistemas na UNIFACEAR. '
        'Focado em Flutter e desenvolvimento de aplicações móveis multiplataforma.',
    fotoUrl: 'https://i.pravatar.cc/300?img=12',
    github: 'github.com/paulo',
    linkedin: 'linkedin.com/in/paulo',
  ),
  Membro(
    nome: 'Weslley Kampa',
    cargo: 'Desenvolvedor Web',
    bio:
        'Estudante de Análise e Desenvolvimento de Sistemas na UNIFACEAR. '
        'Apaixonado por interfaces modernas e tecnologias web.',
    fotoUrl: 'https://i.pravatar.cc/300?img=33',
    github: 'github.com/weslley',
    linkedin: 'linkedin.com/in/weslley',
  ),
];

// ============================================================
//  WIDGET RAIZ
// ============================================================
class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portfolio — Equipe Dev',
      debugShowCheckedModeBanner: false,

      // Material 3 
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.dark(
          primary: AppColors.amarelo,
          onPrimary: AppColors.preto,
          surface: AppColors.cinzaEscuro,
          onSurface: AppColors.branco,
        ),
        scaffoldBackgroundColor: AppColors.preto,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.preto,
          foregroundColor: AppColors.branco,
          elevation: 0,
        ),
        cardTheme: const CardThemeData(
          color: AppColors.cinzaEscuro,
          elevation: 6, // sombra/elevação
          shadowColor: Colors.black54,
        ),
      ),
      home: const TelaPrincipal(),
    );
  }
}

// ============================================================
//  TELA PRINCIPAL  (Scaffold)
// ============================================================
class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  // Controla qual seção está visível
  int _secaoAtual = 0; // 0 = Perfis | 1 = Sobre

  void _irParaSobre() {
    setState(() => _secaoAtual = 1);
  }

  void _voltarParaPerfis() {
    setState(() => _secaoAtual = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ── 1. APP BAR ──────────────────────────────────────────
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.amarelo,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            const Text(
              'DEV PORTFOLIO',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                letterSpacing: 3,
                color: AppColors.branco,
              ),
            ),
          ],
        ),
        // Botão de voltar aparece apenas na seção "Sobre"
        leading: _secaoAtual == 1
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new,
                    color: AppColors.amarelo),
                onPressed: _voltarParaPerfis,
              )
            : Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu, color: AppColors.branco),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
      ),

      // ── 2. DRAWER (Menu Lateral) ─────────────────────────────
      drawer: Drawer(
        backgroundColor: AppColors.cinzaEscuro,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: AppColors.amarelo),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'Menu',
                    style: TextStyle(
                      color: AppColors.preto,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Equipe Dev — UNIFACEAR',
                    style: TextStyle(
                      color: AppColors.cinzaMedio,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.people_outline,
                  color: AppColors.amarelo),
              title: const Text('Perfis',
                  style: TextStyle(color: AppColors.branco)),
              onTap: () {
                Navigator.pop(context);
                _voltarParaPerfis();
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline,
                  color: AppColors.amarelo),
              title: const Text('Sobre nós',
                  style: TextStyle(color: AppColors.branco)),
              onTap: () {
                Navigator.pop(context);
                _irParaSobre();
              },
            ),
            const Divider(color: AppColors.cinzaMedio),
            ListTile(
              leading: const Icon(Icons.school_outlined,
                  color: AppColors.cinzaTexto),
              title: const Text('UNIFACEAR — 2025',
                  style: TextStyle(color: AppColors.cinzaTexto, fontSize: 13)),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),

      // ── 3. BODY ──────────────────────────────────────────────
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        child: _secaoAtual == 0
            ? _SecaoPerfis(key: const ValueKey(0), onVerSobre: _irParaSobre)
            : _SecaoSobre(key: const ValueKey(1)),
      ),

      // ── 4. FLOATING ACTION BUTTON ────────────────────────────
      //  Cor amarela contrasta com o fundo preto (requisito da atividade)
      floatingActionButton: _secaoAtual == 0
          ? FloatingActionButton(
              backgroundColor: AppColors.amarelo,
              foregroundColor: AppColors.preto,
              tooltip: 'Ver sobre nós',
              onPressed: _irParaSobre,
              child: const Icon(Icons.arrow_downward_rounded),
            )
          : null,
    );
  }
}

// ============================================================
//  SEÇÃO 1 — CARDS DE PERFIL
//  (exibido ao abrir o app, como nos wireframes)
// ============================================================
class _SecaoPerfis extends StatelessWidget {
  final VoidCallback onVerSobre;
  const _SecaoPerfis({super.key, required this.onVerSobre});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho da seção
          const Text(
            'Nossa Equipe',
            style: TextStyle(
              color: AppColors.amarelo,
              fontSize: 28,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Desenvolvido para Aplicações Móveis — UNIFACEAR',
            style: TextStyle(color: AppColors.cinzaTexto, fontSize: 13),
          ),
          const SizedBox(height: 28),

          // Mapeamento dos membros → cards
          ...equipe.map((m) => _CardMembro(membro: m)),

          const SizedBox(height: 16),

          // Rodapé com chamada para ação
          Center(
            child: TextButton.icon(
              onPressed: onVerSobre,
              icon: const Icon(Icons.expand_more,
                  color: AppColors.amarelo),
              label: const Text(
                'Um pouco sobre nós',
                style: TextStyle(
                    color: AppColors.amarelo,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Card individual de cada membro ──────────────────────────
class _CardMembro extends StatelessWidget {
  final Membro membro;
  const _CardMembro({required this.membro});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      // Card com elevation — requisito de pesquisa da atividade
      child: Card(
        elevation: 8,
        shadowColor: AppColors.amarelo.withOpacity(0.15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          // Borda sutil — desafio extra da atividade
          side: const BorderSide(
              color: AppColors.cinzaMedio, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // ── Foto via NetworkImage (requisito de pesquisa) ──
              CircleAvatar(
                radius: 52,
                backgroundColor: AppColors.amarelo,
                // NetworkImage carrega foto da internet por URL
                backgroundImage: NetworkImage(membro.fotoUrl),
                // Fallback caso a imagem não carregue
                onBackgroundImageError: (_, __) {},
                child: null,
              ),
              const SizedBox(height: 20),

              // ── Nome (TextStyle com peso e tamanho — requisito) ──
              Text(
                membro.nome,
                style: const TextStyle(
                  color: AppColors.branco,
                  fontSize: 22,
                  fontWeight: FontWeight.bold, // negrito
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6),

              // ── Cargo com cor customizada hex ──
              Text(
                membro.cargo,
                style: const TextStyle(
                  color: AppColors.amarelo, // cor hexadecimal 0xFFFFCC00
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16),

              // Divisor
              Container(
                height: 1,
                width: 60,
                color: AppColors.cinzaMedio,
              ),
              const SizedBox(height: 16),

              // ── Bio ──
              Text(
                membro.bio,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.cinzaTexto,
                  fontSize: 13,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 20),

              // ── Ícones de redes sociais ──
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _BotaoIcone(
                    icone: Icons.code,
                    label: 'GitHub',
                    url: membro.github,
                  ),
                  const SizedBox(width: 12),
                  _BotaoIcone(
                    icone: Icons.work_outline,
                    label: 'LinkedIn',
                    url: membro.linkedin,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Botão de ícone para redes sociais ──────────────────────
class _BotaoIcone extends StatelessWidget {
  final IconData icone;
  final String label;
  final String url;
  const _BotaoIcone(
      {required this.icone, required this.label, required this.url});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.cinzaMedio,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Abrindo $url'),
              backgroundColor: AppColors.amarelo,
              // Cor hex no SnackBar
              duration: const Duration(seconds: 2),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: [
              Icon(icone, color: AppColors.amarelo, size: 18),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.branco,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
//  SEÇÃO 2 — SOBRE NÓS
//  (segunda "tela" revelada ao rolar ou clicar no FAB)
// ============================================================
class _SecaoSobre extends StatelessWidget {
  const _SecaoSobre({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Título da seção
          const Text(
            'Um pouco\nsobre nós',
            style: TextStyle(
              color: AppColors.branco,
              fontSize: 32,
              fontWeight: FontWeight.w900,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 3,
            width: 40,
            color: AppColors.amarelo,
          ),
          const SizedBox(height: 28),

          // Texto de bio da equipe
          const Text(
            'Somos estudantes de Análise e Desenvolvimento de Sistemas na UNIFACEAR, '
            'Araucária. Esta atividade foi desenvolvida para a disciplina de '
            'Desenvolvimento de Aplicações Móveis.',
            style: TextStyle(
              color: AppColors.cinzaTexto,
              fontSize: 15,
              height: 1.8,
            ),
          ),
          const SizedBox(height: 24),

          // Cards de habilidades
          _CardHabilidade(
            icone: Icons.phone_android,
            titulo: 'Flutter & Dart',
            descricao:
                'Construindo interfaces nativas com widgets Material 3, '
                'Scaffold, AppBar, FloatingActionButton e mais.',
          ),
          const SizedBox(height: 12),
          _CardHabilidade(
            icone: Icons.web,
            titulo: 'React.js & Web',
            descricao:
                'Desenvolvimento frontend com React.js, Vite e '
                'ecossistema JavaScript moderno.',
          ),
          const SizedBox(height: 12),
          _CardHabilidade(
            icone: Icons.storage,
            titulo: 'Back-end & Dados',
            descricao:
                'Experiência com APIs REST, lógica de negócio e '
                'integração de sistemas.',
          ),
          const SizedBox(height: 36),

          // Botão de contato (ElevatedButton)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.amarelo,
                foregroundColor: AppColors.preto,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 1,
                ),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    backgroundColor: AppColors.cinzaEscuro,
                    title: const Text(
                      'Contato',
                      style: TextStyle(color: AppColors.amarelo),
                    ),
                    content: const Text(
                      'Paulo: paulo@email.com\nWeslley: weslley@email.com',
                      style: TextStyle(color: AppColors.branco),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Fechar',
                            style: TextStyle(color: AppColors.amarelo)),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.email_outlined),
              label: const Text('CONTATE-NOS'),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Card de habilidade ──────────────────────────────────────
class _CardHabilidade extends StatelessWidget {
  final IconData icone;
  final String titulo;
  final String descricao;
  const _CardHabilidade(
      {required this.icone,
      required this.titulo,
      required this.descricao});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // elevação com sombra — requisito da atividade
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.amarelo.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icone, color: AppColors.amarelo, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(
                      color: AppColors.branco,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    descricao,
                    style: const TextStyle(
                      color: AppColors.cinzaTexto,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}