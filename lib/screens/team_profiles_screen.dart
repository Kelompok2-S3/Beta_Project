import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:go_router/go_router.dart';

class TeamProfilesScreen extends StatelessWidget {
  const TeamProfilesScreen({super.key});

  final List<Map<String, String>> _teamMembers = const [
    {
      'name': 'Rizma Indra Pramudya',
      'nim': '24111814117',
      'role': 'Fullstack Developer',
      'image': 'assets/images/profile/RizmaIndraPramudya.jpg',
      'isLeader': 'true',
    },
    {
      'name': 'Putera Al Khalidi',
      'nim': '24111814077',
      'role': 'Fullstack Developer',
      'image': 'assets/images/profile/Putera.jpg',
    },
    {
      'name': 'Muhammad Abdullah Ro’in',
      'nim': '24111814054',
      'role': 'Database Engineer',
      'image': 'assets/images/profile/Roin.jpg',
    },
    {
      'name': 'Rendy Agus Dwi Satrio',
      'nim': '24111814094',
      'role': 'Database Engineer',
      'image': 'assets/images/profile/RendyAgusDwiSatrio.jpg',
    },
    {
      'name': 'Naufal Yudantara Saputra',
      'nim': '24111814023',
      'role': 'Writer',
      'image': 'assets/images/profile/NaufalYudantaraSaputra.jpg',
    },
    {
      'name': 'Muhammad Dava Firmansyah',
      'nim': '24111814030',
      'role': 'Writer',
      'image': 'assets/images/profile/MuhammadDavaFirmansyah.jpg',
    },
    {
      'name': 'Naufal Akbar PP',
      'nim': '24111814027',
      'role': 'Writer',
      'image': 'assets/images/profile/NaufalAkbar.jpg',
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
                    childAspectRatio: 0.7, // Adjusted for extra badge
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final member = _teamMembers[index];
                      return _buildTeamMemberCard(member, index);
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

  Widget _buildTeamMemberCard(Map<String, String> member, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
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
                    image: AssetImage(member['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  member['name']!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (member['isLeader'] == 'true') ...[
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
                member['nim']!,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                member['role']!,
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
                  _buildSocialIcon('assets/images/utility/instagram.png'), // Placeholder or IconData
                  const SizedBox(width: 15),
                  _buildSocialIcon('assets/images/utility/github.png'), // Placeholder or IconData
                ],
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: (100 * index).ms).scale();
  }

  Widget _buildSocialIcon(String assetPath) {
    // Using standard Icons for now as requested "instagram dan github"
    // If specific assets are needed, I'd use Image.asset.
    // But usually "Icon" implies IconData. 
    // However, Flutter doesn't have built-in Insta/Github icons in Material Icons.
    // I will use text or generic icons if font_awesome_flutter is not available.
    // Checking pubspec... no font_awesome.
    // I will use generic icons for now and ask user or use images if available.
    // Wait, user said "icon nya".
    // I'll use Icons.code for Github and Icons.camera_alt for Instagram as placeholders
    // OR better, I'll just use the text "IG" and "GH" or similar if no icons.
    // ACTUALLY, I can use `assets/images/utility/` if they exist?
    // Let's check if I can use standard icons that look similar.
    // Github -> Icons.code (or similar)
    // Instagram -> Icons.camera_alt
    
    IconData icon;
    if (assetPath.contains('instagram')) {
      icon = Icons.camera_alt; // Placeholder for Instagram
    } else {
      icon = Icons.code; // Placeholder for Github
    }

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
    );
  }
}
