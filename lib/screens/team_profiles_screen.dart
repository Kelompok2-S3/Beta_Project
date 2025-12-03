import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class TeamProfilesScreen extends StatelessWidget {
  const TeamProfilesScreen({super.key});

  final List<Map<String, String>> _teamMembers = const [
    {
      'name': 'Rizma Indra Pramudya',
      'nim': '24111814117',
      'role': 'Fullstack Developer',
      'image': 'assets/images/profile/RizmaIndraPramudya.jpg',
      'isLeader': 'true',
      'github': 'https://github.com/Drappy-cat',
      'instagram': 'https://www.instagram.com/draapy_?igsh=MXc3cjlqYjFzejI2dA==',
    },
    {
      'name': 'Putera Al Khalidi',
      'nim': '24111814077',
      'role': 'Fullstack Developer',
      'image': 'assets/images/profile/Putera.jpg',
      'github': 'https://github.com/Anuvbis12',
      'instagram': 'https://www.instagram.com/kuboo.18?igsh=MTVheGQ2OGlmcHdtcQ==',
    },
    {
      'name': 'Muhammad Abdullah Ro’in',
      'nim': '24111814054',
      'role': 'Database Engineer',
      'image': 'assets/images/profile/Roin.jpg',
      'github': 'https://github.com/Kirisaki-zero',
      'instagram': 'https://www.instagram.com/roin3163?igsh=N2xiYXR5c3p6aXF0',
    },
    {
      'name': 'Rendy Agus Dwi Satrio',
      'nim': '24111814094',
      'role': 'Frontend Developer',
      'image': 'assets/images/profile/RendyAgusDwiSatrio.jpg',
      'github': 'https://github.com/satrio-cvly',
      'instagram': 'https://www.instagram.com/____.r.ndy404?igsh=Y292eGliZWZleWQ0&utm_source=qr',
    },
    {
      'name': 'Naufal Yudantara Saputra',
      'nim': '24111814023',
      'role': 'Writer',
      'image': 'assets/images/profile/NaufalYudantaraSaputra.jpg',
      'github': 'https://github.com/naufalyudantara07',
      'instagram': 'https://www.instagram.com/nuflydtr7?igsh=OHR6cG9hNTYzMWNy&utm_source=qr',
    },
    {
      'name': 'Muhammad Dava Firmansyah',
      'nim': '24111814030',
      'role': 'Writer',
      'image': 'assets/images/profile/MuhammadDavaFirmansyah.jpg',
      'github': 'https://github.com/mdavafirmansyah',
      'instagram': 'https://www.instagram.com/amad_firmn?igsh=MWtqa3htdWFjNW9kcA==',
    },
    {
      'name': 'Naufal Akbar PP',
      'nim': '24111814027',
      'role': 'Writer',
      'image': 'assets/images/profile/NaufalAkbar.jpg',
      'github': 'https://github.com/nopalPwaelah',
      'instagram': 'https://www.instagram.com/fallsapprdn05_?igsh=aHRscm5udTJhazd5',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.canPop() ? context.pop() : context.go('/'),
        ),
      ),
      body: Stack(
        children: [
          // Background Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1A1A1A), Colors.black],
              ),
            ),
          ),
          
          // Content
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 100, 20, 40),
                  child: Column(
                    children: [
                      Text(
                        'Meet Our Team',
                        style: GoogleFonts.orbitron(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ).animate().fadeIn().slideY(begin: -0.2, end: 0),
                      const SizedBox(height: 10),
                      Text(
                        'The minds behind the project',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ).animate().fadeIn(delay: 200.ms),
                    ],
                  ),
                ),
              ),
              
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 300,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.7,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final member = _teamMembers[index];
                      return TeamMemberCard(member: member, index: index);
                    },
                    childCount: _teamMembers.length,
                  ),
                ),
              ),
              
              const SliverToBoxAdapter(child: SizedBox(height: 40)),
            ],
          ),
        ],
      ),
    );
  }
}

class TeamMemberCard extends StatefulWidget {
  final Map<String, String> member;
  final int index;

  const TeamMemberCard({super.key, required this.member, required this.index});

  @override
  State<TeamMemberCard> createState() => _TeamMemberCardState();
}

class _TeamMemberCardState extends State<TeamMemberCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: _isHovered ? Colors.white.withOpacity(0.5) : Colors.white.withOpacity(0.1),
                ),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ]
                    : [],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white.withOpacity(0.2), width: 2),
                      image: DecorationImage(
                        image: AssetImage(widget.member['image']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      widget.member['name']!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (widget.member['isLeader'] == 'true') ...[
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.amber.withOpacity(0.5)),
                      ),
                      child: const Text(
                        'LEADER',
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 4),
                  Text(
                    widget.member['nim']!,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.member['role']!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue[400],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.member['instagram'] != null)
                        _buildSocialIcon(Icons.camera_alt, widget.member['instagram']!),
                      const SizedBox(width: 15),
                      if (widget.member['github'] != null)
                        _buildSocialIcon(Icons.code, widget.member['github']!),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ).animate().fadeIn(delay: (100 * widget.index).ms).scale(),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            debugPrint('Could not launch $url');
          }
        },
        borderRadius: BorderRadius.circular(50),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}
