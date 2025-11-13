import 'package:flutter/material.dart';

class ExperienceDetailScreen extends StatelessWidget {
  final String experienceTitle;
  final String experienceDescription;
  final String? imageUrl;
  final String? assetPath;

  const ExperienceDetailScreen({
    super.key,
    required this.experienceTitle,
    required this.experienceDescription,
    this.imageUrl,
    this.assetPath,
  }) : assert(imageUrl != null || assetPath != null, 'Either imageUrl or assetPath must be provided.');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    experienceTitle,
                    style: const TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    experienceDescription,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white.withAlpha((0.7 * 255).round()),
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 40),
                  _buildSectionTitle('Highlight Fitur'),
                  const SizedBox(height: 24),
                  _buildFeatureItem(
                    icon: Icons.speed,
                    title: 'Performa Superior',
                    description: 'Rasakan akselerasi yang memukau dan handling presisi di setiap tikungan.',
                  ),
                  _buildFeatureItem(
                    icon: Icons.security,
                    title: 'Keamanan Terdepan',
                    description: 'Dilengkapi dengan sistem keamanan canggih untuk perlindungan maksimal.',
                  ),
                  _buildFeatureItem(
                    icon: Icons.palette,
                    title: 'Desain Ikonik',
                    description: 'Garis desain yang elegan dan aerodinamis, menarik perhatian di mana pun Anda berada.',
                  ),
                  const SizedBox(height: 40),
                  _buildSectionTitle('Galeri Eksklusif'),
                  const SizedBox(height: 24),
                  _buildGallery(),
                  const SizedBox(height: 40),
                  _buildCallToActionButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    ImageProvider imageProvider;
    if (imageUrl != null) {
      imageProvider = NetworkImage(imageUrl!);
    } else {
      imageProvider = AssetImage(assetPath!);
    }

    return SliverAppBar(
      expandedHeight: 350.0,
      backgroundColor: const Color(0xFF1A1A1A),
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 72, bottom: 16),
        title: Text(
          experienceTitle,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider, // Use the dynamic imageProvider
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withAlpha((0.7 * 255).round()),
                  Colors.transparent,
                  Colors.black.withAlpha((0.9 * 255).round()),
                ],
              ),
            ),
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildFeatureItem({required IconData icon, required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blueAccent, size: 36),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withAlpha((0.6 * 255).round()),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGallery() {
    final List<String> galleryImages = [
      'https://images.unsplash.com/photo-1503376780353-7e6692767b70?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1542282088-fe8426682b8f?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      'https://images.unsplash.com/photo-1594398901394-4e34939a19ff?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ];

    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: galleryImages.length,
        itemBuilder: (context, index) {
          return Container(
            width: 280,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(galleryImages[index]),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha((0.4 * 255).round()),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCallToActionButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Pengalaman ini telah ditambahkan ke daftar keinginan Anda!'),
              backgroundColor: Colors.blueAccent,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 10,
          shadowColor: Colors.blueAccent.withAlpha((0.6 * 255).round()),
        ),
        child: const Text(
          'Tambahkan ke Wishlist',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
