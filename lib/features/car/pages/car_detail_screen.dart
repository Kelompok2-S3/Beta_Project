/*
 * Project: GearGauge
 * Created by: Rizma Indra, Putera, Roin, Rendy, Naufal Y, Dava, Naufal A
 * Year: 2025
 */

import 'package:beta_project/domain/entities/car_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:beta_project/models/car_model.dart' as api_model;
import 'package:beta_project/services/car_service.dart';

const Color _primaryAccentColor = Color(0xFFD5001C);
const Color _darkBackground = Color(0xFF121212);
const Color _darkCard = Color(0xFF1E1E1E);

class CarDetailScreen extends StatefulWidget {
  final CarModel model;
  const CarDetailScreen({super.key, required this.model});

  @override
  State<CarDetailScreen> createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> with SingleTickerProviderStateMixin {
  late final ScrollController _scrollController;
  late final TabController _tabController;
  bool _isStickyHeaderVisible = false;
  final double _imageHeight = 350.0;
  
  final CarService _carService = CarService();
  late Future<api_model.Car?> _apiCarFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController()..addListener(_scrollListener);
    _apiCarFuture = _fetchMatchingCar();
  }

  Future<api_model.Car?> _fetchMatchingCar() async {
    try {
      final cars = await _carService.fetchCars();
      // Try to find a match based on name or fuzzy matching
      try {
        return cars.firstWhere((car) {
          // 1. Check if source URL contains the name (most reliable if URL follows pattern)
          final urlName = _extractModelFromUrl(car.sourceUrl).toLowerCase();
          final localName = widget.model.name.toLowerCase();
          
          if (urlName.isNotEmpty && (localName.contains(urlName) || urlName.contains(localName))) {
             return true;
          }
          
          // 2. Fallback: Check if brand matches AND name contains parts
          if (car.brand.toLowerCase() == widget.model.brand.toLowerCase()) {
             // Simple containment check
             return localName.contains(car.brand.toLowerCase()) || 
                    localName.contains(car.year) || // Sometimes year is in name
                    car.sourceUrl.toLowerCase().contains(localName.replaceAll(' ', '_'));
          }
          return false;
        });
      } catch (e) {
        return null; // No match found
      }
    } catch (e) {
      debugPrint('Error fetching API cars: $e');
      return null;
    }
  }

  String _extractModelFromUrl(String url) {
    try {
      final uri = Uri.parse(url);
      final segments = uri.pathSegments;
      if (segments.isNotEmpty) {
        String title = segments.last;
        title = Uri.decodeComponent(title);
        title = title.replaceAll('_', ' ');
        return title;
      }
    } catch (_) {}
    return '';
  }

  void _scrollListener() {
    final bool shouldBeVisible = _scrollController.offset >= _imageHeight - 80;
    if (shouldBeVisible != _isStickyHeaderVisible) {
      setState(() {
        _isStickyHeaderVisible = shouldBeVisible;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  String _formatPrice(String price) {
    final numericPrice = double.tryParse(price.replaceAll(RegExp(r'[^0-9.]'), ''));
    if (numericPrice == null) return price;
    return NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 0).format(numericPrice);
  }

  @override
  void didUpdateWidget(CarDetailScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model.name != oldWidget.model.name) {
      _apiCarFuture = _fetchMatchingCar();
      _scrollController.jumpTo(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              _buildSliverAppBar(),
              _buildContentBody(),
            ],
          ),
          _buildStickyHeader(),
          // TOMBOL BACK
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Colors.black.withAlpha((0.5 * 255).round()),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  onPressed: () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      context.go('/');
                    }
                  },
                ),
              ),
            ),
          ).animate().fadeIn(delay: 300.ms),
        ],
      ),
    );
  }

  // --- Helper Widgets (Sama seperti kode asli Anda) ---
  
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: _imageHeight,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      pinned: true,
      stretch: true,
      automaticallyImplyLeading: false, 
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: widget.model.assetPath,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                widget.model.assetPath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                const Center(child: Text('Image not found', style: TextStyle(color: Colors.white))),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, const Color.fromRGBO(0, 0, 0, 0.8)],
                    stops: const [0.4, 1.0],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStickyHeader() {
    return AnimatedOpacity(
      opacity: _isStickyHeaderVisible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 300),
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SafeArea(
          bottom: false,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(widget.model.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
                        overflow: TextOverflow.ellipsis),
                    Text('From ${_formatPrice(widget.model.price)}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 14)),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryAccentColor,
                    foregroundColor: Colors.white,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                child: const Text('Configure'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContentBody() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.model.brand.toUpperCase(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 18, letterSpacing: 1.2))
                .animate().fadeIn().slideX(begin: -0.1, end: 0),
            const SizedBox(height: 4),
            Text(widget.model.name,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 34))
                .animate().fadeIn(delay: 100.ms).slideX(begin: -0.1, end: 0),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatPrice(widget.model.price),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 22)),
              ],
            ).animate().fadeIn(delay: 200.ms),
            const SizedBox(height: 24),
            _buildKeySpecifications().animate().fadeIn(delay: 300.ms).slideY(begin: 0.1, end: 0),
            const SizedBox(height: 24),
            _buildContentTabs().animate().fadeIn(delay: 400.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildKeySpecifications() {
    final keySpecs = {
      "Power (HP)": widget.model.power,
      "0-100 km/h": widget.model.acceleration,
      "Top Speed": widget.model.topSpeed,
    };
    final items = keySpecs.entries.toList();
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length * 2 - 1, (index) {
          if (index.isEven) {
            final item = items[index ~/ 2];
            return _buildSpecItem(item.key, item.value);
          }
          return _buildVerticalDivider();
        }),
      ),
    );
  }

  Widget _buildSpecItem(String label, String value) {
    return Flexible(
      child: Column(
        children: [
          Text(value, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() => Container(height: 40, width: 1, color: Colors.grey[800]);

  Widget _buildContentTabs() {
    return Column(
      children: [
        Theme(
          data: ThemeData(splashColor: Colors.transparent, highlightColor: Colors.transparent),
          child: TabBar(
            controller: _tabController,
            indicatorColor: _primaryAccentColor,
            indicatorWeight: 3,
            labelColor: Theme.of(context).textTheme.bodyLarge?.color,
            unselectedLabelColor: Theme.of(context).textTheme.bodyMedium?.color,
            labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            tabs: const [Tab(text: 'Overview'), Tab(text: 'Tech Specs'), Tab(text: 'Gallery')],
          ),
        ),
        const SizedBox(height: 24),
        IndexedStack(
          index: _tabController.index,
          children: [
            Visibility(visible: _tabController.index == 0, child: _buildOverviewTab()),
            Visibility(visible: _tabController.index == 1, child: _buildTechSpecsTab()),
            Visibility(visible: _tabController.index == 2, child: _buildGalleryTab()),
          ],
        ),
      ],
    );
  }

  Widget _buildOverviewTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        Text(widget.model.description, style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6)),
      ],
    ).animate().fadeIn();
  }

  Widget _buildTechSpecsTab() {
    return FutureBuilder<api_model.Car?>(
      future: _apiCarFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(color: _primaryAccentColor),
            ),
          );
        }

        if (snapshot.hasData && snapshot.data != null) {
          final apiCar = snapshot.data!;
          // Use API data
          final specs = {
            'Engine': {'Type': apiCar.engine, 'Power': apiCar.power, 'Torque': apiCar.torque},
            'Performance': {'Weight': apiCar.weight},
            'General': {'Category': apiCar.category, 'Year': apiCar.year},
          };

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: specs.length,
            itemBuilder: (context, index) {
              final category = specs.keys.elementAt(index);
              final details = specs[category]!;
              
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)),
                child: ExpansionTile(
                  initiallyExpanded: true,
                  iconColor: _primaryAccentColor,
                  collapsedIconColor: Theme.of(context).iconTheme.color,
                  tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  title: Text(category, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
                  children: [
                    const Divider(height: 1, color: Color(0xFF333333)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Column(
                        children: details.entries.map((entry) {
                          return _buildTechnicalDetailRow(label: entry.key, value: entry.value);
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: (100 * index).ms).slideX();
            },
          );
        }

        // Fallback to existing hardcoded data
        final validSpecGroups = widget.model.technicalData.where((group) {
          group.specs.removeWhere((key, value) => value.trim().isEmpty);
          return group.specs.isNotEmpty;
        }).toList();

        if (validSpecGroups.isEmpty) {
          return const Center(child: Text("No technical specifications available.", style: TextStyle(color: Colors.grey)));
        }

        return Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: validSpecGroups.length,
            itemBuilder: (context, index) {
              final group = validSpecGroups[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(12)),
                child: ExpansionTile(
                  initiallyExpanded: index == 0,
                  iconColor: _primaryAccentColor,
                  collapsedIconColor: Theme.of(context).iconTheme.color,
                  tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  title: Text(group.title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
                  children: [
                    const Divider(height: 1, color: Color(0xFF333333)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: Column(
                        children: group.specs.entries.map((entry) {
                          return _buildTechnicalDetailRow(label: entry.key, value: entry.value);
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ).animate().fadeIn(delay: (100 * index).ms).slideX();
            },
          ),
        );
      },
    );
  }

  Widget _buildTechnicalDetailRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 2, child: Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 15))),
          const SizedBox(width: 16),
          Expanded(flex: 3, child: Text(value, textAlign: TextAlign.end, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }

  Widget _buildGalleryTab() {
    final galleryImages = widget.model.galleryImages;
    if (galleryImages.isEmpty) {
      return const Center(child: Text("No images available in the gallery.", style: TextStyle(color: Colors.grey)));
    }
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: galleryImages.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.4),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            galleryImages[index],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Container(color: Theme.of(context).cardColor, child: Icon(Icons.broken_image, color: Theme.of(context).iconTheme.color)),
          ),
        ).animate().fadeIn(delay: (100 * index).ms).scale();
      },
    );
  }
}
