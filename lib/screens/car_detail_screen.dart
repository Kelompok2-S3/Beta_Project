import 'package:beta_project/domain/entities/car_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart'; // Wajib import ini

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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController()..addListener(_scrollListener);
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _darkBackground,
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
                  onPressed: () => context.pop(), // Aksi Back
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets (Sama seperti kode asli Anda) ---
  
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: _imageHeight,
      backgroundColor: _darkBackground,
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
        color: const Color.fromRGBO(18, 18, 18, 0.9),
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
                        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis),
                    Text('From ${_formatPrice(widget.model.price)}',
                        style: TextStyle(color: Colors.grey[400], fontSize: 14)),
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
                style: TextStyle(color: Colors.grey[400], fontSize: 18, fontWeight: FontWeight.w500, letterSpacing: 1.2)),
            const SizedBox(height: 4),
            Text(widget.model.name,
                style: const TextStyle(color: Colors.white, fontSize: 34, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_formatPrice(widget.model.price),
                    style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500)),
              ],
            ),
            const SizedBox(height: 24),
            _buildKeySpecifications(),
            const SizedBox(height: 24),
            _buildContentTabs(),
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
      decoration: BoxDecoration(color: _darkCard, borderRadius: BorderRadius.circular(12)),
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
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 12), textAlign: TextAlign.center),
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
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey[500],
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
        const Text('Description', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        Text(widget.model.description, style: const TextStyle(color: Color(0xFFa0a0a0), fontSize: 16, height: 1.6)),
      ],
    );
  }

  Widget _buildTechSpecsTab() {
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
            decoration: BoxDecoration(color: _darkCard, borderRadius: BorderRadius.circular(12)),
            child: ExpansionTile(
              initiallyExpanded: index == 0,
              iconColor: _primaryAccentColor,
              collapsedIconColor: Colors.grey[400],
              tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              title: Text(group.title, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
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
          );
        },
      ),
    );
  }

  Widget _buildTechnicalDetailRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(flex: 2, child: Text(label, style: TextStyle(fontSize: 15, color: Colors.grey[400]))),
          const SizedBox(width: 16),
          Expanded(flex: 3, child: Text(value, textAlign: TextAlign.end, style: const TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.w600))),
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
                Container(color: _darkCard, child: const Icon(Icons.broken_image, color: Colors.grey)),
          ),
        );
      },
    );
  }
}
