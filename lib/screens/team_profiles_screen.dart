import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TeamProfilesScreen extends StatelessWidget {
  const TeamProfilesScreen({super.key});

  final List<Map<String, String>> _teamMembers = const [
    {
      'name': 'Muhammad Dava Firmansyah',
      'role': 'Team Member',
      'image': 'assets/images/profile/MuhammadDavaFirmansyah.jpg',
    },
    {
      'name': 'Naufal Akbar',
      'role': 'Team Member',
      'image': 'assets/images/profile/NaufalAkbar.jpg',
    },
    {
      'name': 'Naufal Yudantara Saputra',
      'role': 'Team Member',
      'image': 'assets/images/profile/NaufalYudantaraSaputra.jpg',
    },
    {
      'name': 'Putera',
      'role': 'Team Member',
      'image': 'assets/images/profile/Putera.jpg',
    },
    {
      'name': 'Rendy Agus Dwi Satrio',
      'role': 'Team Member',
      'image': 'assets/images/profile/RendyAgusDwiSatrio.jpg',
    },
    {
      'name': 'Rizma Indra Pramudya',
      'role': 'Team Member',
      'image': 'assets/images/profile/RizmaIndraPramudya.jpg',
    },
    {
      'name': 'Roin',
      'role': 'Team Member',
      'image': 'assets/images/profile/Roin.jpg',
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
          onPressed: () => Navigator.pop(context),
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
                    childAspectRatio: 0.8,
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
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withOpacity(0.2), width: 2),
                  image: DecorationImage(
                    image: AssetImage(member['image']!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 8),
              Text(
                member['role']!,
                style: TextStyle(
                  color: Colors.blue[400],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon(Icons.facebook),
                  const SizedBox(width: 10),
                  _buildSocialIcon(Icons.link), // LinkedIn alternative
                  const SizedBox(width: 10),
                  _buildSocialIcon(Icons.alternate_email), // Twitter/X alternative
                ],
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: (100 * index).ms).scale();
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 16,
      ),
    );
  }
}
