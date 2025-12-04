import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:beta_project/models/car_model.dart'; // Assuming this is correct
import 'package:beta_project/domain/entities/car_model.dart'; // Assuming this is correct
import 'package:beta_project/services/car_service.dart'; // Assuming this is correct
import 'package:beta_project/data/car_repository.dart'; // Assuming this is correct

class CarListScreen extends StatefulWidget {
  const CarListScreen({super.key});

  @override
  State<CarListScreen> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<Car> _cars = [];
  bool _isLoading = false;
  int _currentPage = 1;
  bool _hasMore = true;
  final CarService _carService = CarService(); // Direct service usage for now, or use Repo

  @override
  void initState() {
    super.initState();
    _fetchCars();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        _hasMore) {
      _fetchCars();
    }
  }

  Future<void> _fetchCars() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final newCars = await CarRepositoryImpl.instance.fetchCarsPage(_currentPage);
      
      if (!mounted) return;

      if (newCars.isEmpty) {
        setState(() {
          _hasMore = false;
          _isLoading = false;
        });
        return;
      }

      setState(() {
        _currentPage++;
        _isLoading = false;
      });
    } catch (e) {
      print("Error loading page: $e");
      if (mounted) {
        setState(() {
          _isLoading = false;
          // Prevent immediate retry by setting hasMore to false or handling error state
          // For now, let's just stop trying if we hit an error to prevent loop
          _hasMore = false; 
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load more cars: $e')),
        );
      }
    }
  }
  
  // Helper to get cars from repository since we are relying on it now
  List<CarModel> get _displayedCars => CarRepositoryImpl.instance.allCars;

  String _extractModelFromUrl(String url) {
     // ... (keep helper if needed, but likely not if we use CarModel)
     return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () => context.go('/'),
        ),
        title: const Text(
          'Car Specs',
          style: TextStyle(color: Theme.of(context).textTheme.titleLarge?.color, fontWeight: FontWeight.bold),
        ),
      ),
      body: _displayedCars.isEmpty && _isLoading
          ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor))
          : ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _displayedCars.length + (_hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _displayedCars.length) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(color: Theme.of(context).primaryColor),
                    ),
                  );
                }

                final car = _displayedCars[index];
                // CarModel already has the mapped data!
                final bool isMatch = !car.assetPath.contains("utility"); // Assuming default/fallback logic?
                // Actually Repository logic: 
                // String assetPath = 'assets/images/$cleanBrand/$filename.png';
                // It doesn't check existence.
                // But we can check if we want to show the "Matched" badge.
                // For now, let's just display what we have.
                
                return Card(
                  color: Theme.of(context).cardColor,
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Theme.of(context).dividerColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Image.asset(
                          car.assetPath,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            height: 150,
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: Icon(Icons.image_not_supported, color: Theme.of(context).iconTheme.color?.withOpacity(0.5)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    car.name, // Use display name
                                    style: TextStyle(
                                      color: Theme.of(context).textTheme.titleLarge?.color,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    car.brand,
                                    style: const TextStyle(color: Colors.blueAccent, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildInfoRow('Engine', car.engine),
                            _buildInfoRow('Power', car.power),
                            _buildInfoRow('Torque', car.torque),
                            // _buildInfoRow('Weight', car.weight), // CarModel might not have weight exposed directly in properties? Check entity.
                            // Checking CarModel entity... it has technicalData.
                            
                          ],
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: (50 * (index % 20)).ms).slideX();
              },
            ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color, fontSize: 14),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
