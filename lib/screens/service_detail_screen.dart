import 'package:flutter/material.dart';

class ServiceDetailScreen extends StatelessWidget {
  final String serviceTitle;
  final String serviceDescription;

  const ServiceDetailScreen({
    super.key,
    required this.serviceTitle,
    required this.serviceDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Allows the body to extend behind the app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove shadow
        title: Text(
          serviceTitle,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white), // White back arrow
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/utility/911.jpg', // Using the 911.jpg image
              fit: BoxFit.cover,
            ),
          ),
          // Dark overlay for better text readability
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.7), // Adjust opacity as needed
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppBar().preferredSize.height + 20), // Space for app bar
                  Text(
                    serviceTitle,
                    style: const TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    serviceDescription,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Placeholder for Key Features Section
                  _buildSectionTitle('Key Features'),
                  const SizedBox(height: 20),
                  _buildFeatureItem('Expert Technicians', 'Our team consists of highly trained and certified professionals.'),
                  _buildFeatureItem('Genuine Parts', 'We only use authentic parts to ensure optimal performance and longevity.'),
                  _buildFeatureItem('Advanced Diagnostics', 'Utilizing the latest technology for precise problem identification.'),
                  const SizedBox(height: 40),

                  // Placeholder for Gallery/More Info Section
                  _buildSectionTitle('Gallery'),
                  const SizedBox(height: 20),
                  // You can add a Horizontal ListView of images here
                  Container(
                    height: 150,
                    color: Colors.grey.withOpacity(0.2),
                    child: const Center(
                      child: Text(
                        'Image Gallery Placeholder',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Call to Action Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle service booking or inquiry
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent, // A striking color
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Book This Service',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        decoration: TextDecoration.underline,
        decorationColor: Colors.redAccent,
        decorationThickness: 2,
      ),
    );
  }

  Widget _buildFeatureItem(String title, String description) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
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
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}
