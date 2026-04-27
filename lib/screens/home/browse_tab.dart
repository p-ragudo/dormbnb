import 'package:flutter/material.dart';
import '../../models/dorm_model.dart';
// import 'dorm_menu.dart'; // Assume this exists or will be added

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedPriceFilter = "All";
  String _selectedCategoryFilter = "All";
  List<DormModel> _filteredDorms = [];

  // Sample data to match the image if demoDorms is not available
  final List<DormModel> sampleDorms = [
    DormModel(
      id: '1',
      name: 'Marigold Blue Dormitory',
      address: 'Sitio Lorenzo, Brgy Ibabang Dupay, Lucena City',
      rate: 3500,
      rating: 4.8,
      numOfRating: 42,
      tags: ['WiFi', 'Female', 'AC', 'Featured'],
    ),
    DormModel(
      id: '2',
      name: 'Azure Heights Dormitory',
      address: 'Sitio Little Baguio I, Brgy Ibabang Dupay, Lucena City',
      rate: 2800,
      rating: 4.7,
      numOfRating: 22,
      tags: ['WiFi', 'Male', 'AC', 'Budget Friendly'],
    ),
    DormModel(
      id: '3',
      name: 'Modern Arch Dormitory',
      address: 'Sitio Lorenzo, Brgy Ibabang Dupay, Lucena City',
      rate: 4200,
      rating: 4.9,
      numOfRating: 56,
      tags: ['WiFi', 'Co-ed', 'AC', 'Featured'],
    ),
    DormModel(
      id: '4',
      name: 'Serene Stay Dormitory',
      address: 'Sitio Rainbow, Brgy Ibabang Dupay, Lucena City',
      rate: 2600,
      rating: 4.8,
      numOfRating: 12,
      tags: ['WiFi', 'Female', 'AC', 'Budget Friendly'],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _filteredDorms = sampleDorms;
  }

  void _runFilter() {
    setState(() {
      _filteredDorms = sampleDorms.where((dorm) {
        final matchesSearch = dorm.name.toLowerCase().contains(_searchController.text.toLowerCase()) ||
            dorm.address.toLowerCase().contains(_searchController.text.toLowerCase());

        bool matchesPrice = true;
        if (_selectedPriceFilter == "≤ ₱ 2k") {
          matchesPrice = dorm.rate <= 2000;
        } else if (_selectedPriceFilter == "₱ 2k - ₱ 4k") {
          matchesPrice = dorm.rate > 2000 && dorm.rate <= 4000;
        } else if (_selectedPriceFilter == "₱ 4k - ₱ 8k") {
          matchesPrice = dorm.rate > 4000 && dorm.rate <= 8000;
        }

        bool matchesCategory = true;
        if (_selectedCategoryFilter != "All") {
          matchesCategory = dorm.tags.contains(_selectedCategoryFilter);
        }

        return matchesSearch && matchesPrice && matchesCategory;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 🔹 HEADER WITH BACKGROUND
          Stack(
            children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/images/LandingScreenBackground.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.1),
                        Colors.white.withOpacity(0.4),
                      ],
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Row(
                          children: const [
                            Icon(Icons.arrow_back, color: Color(0xFF4A7DFF), size: 24),
                            SizedBox(width: 4),
                            Text(
                              "Back",
                              style: TextStyle(
                                color: Color(0xFF4A7DFF),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        "Browse Dorms",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // 🔹 CONTENT AREA (Overlapping the header slightly)
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -20),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFF8FBFF), // Very light blue-grey background
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🔹 SEARCH BAR
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: TextField(
                                controller: _searchController,
                                decoration: const InputDecoration(
                                  hintText: "Search Dorms...",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  prefixIcon: Icon(Icons.search, color: Colors.grey, size: 28),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            height: 45,
                            child: ElevatedButton(
                              onPressed: _runFilter,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4A7DFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                elevation: 2,
                              ),
                              child: const Text(
                                "Go",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      // 🔹 FILTER CHIPS
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _priceFilterChip("All"),
                            _priceFilterChip("≤ ₱ 2k"),
                            _priceFilterChip("₱ 2k - ₱ 4k"),
                            _priceFilterChip("₱ 4k - ₱ 8k"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _categoryFilterChip("All"),
                            _categoryFilterChip("Featured"),
                            _categoryFilterChip("Budget Friendly"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      Text.rich(
                        TextSpan(
                          text: "Showing ",
                          style: const TextStyle(color: Colors.black87, fontSize: 15),
                          children: [
                            TextSpan(
                              text: "${_filteredDorms.length} Dorms",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const TextSpan(text: " near you"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),

                      // 🔹 DORM LIST
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(bottom: 20),
                          itemCount: _filteredDorms.length,
                          itemBuilder: (context, index) {
                            return _DormCard(dorm: _filteredDorms[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _priceFilterChip(String label) {
    bool isSelected = _selectedPriceFilter == label;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (val) {
          setState(() {
            _selectedPriceFilter = label;
          });
          _runFilter();
        },
        backgroundColor: Colors.white,
        selectedColor: const Color(0xFF4A7DFF),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.grey.shade400,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }

  Widget _categoryFilterChip(String label) {
    bool isSelected = _selectedCategoryFilter == label;
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (val) {
          setState(() {
            _selectedCategoryFilter = label;
          });
          _runFilter();
        },
        backgroundColor: Colors.white,
        selectedColor: const Color(0xFF4A7DFF),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.grey.shade400,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: const Color(0xFF4A7DFF),
        unselectedItemColor: Colors.grey.shade400,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30),
            activeIcon: CircleAvatar(
              backgroundColor: Color(0xFF4A7DFF),
              child: Icon(Icons.search, color: Colors.white),
            ),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined, size: 28), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.mail_outline, size: 28), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline, size: 28), label: ""),
        ],
      ),
    );
  }
}

class _DormCard extends StatelessWidget {
  final DormModel dorm;
  const _DormCard({required this.dorm});

  String _getDormImage(String name) {
    if (name.contains('Marigold')) return 'lib/assets/images/DormAlpha.png';
    if (name.contains('Azure')) return 'lib/assets/images/DormBeta.png';
    if (name.contains('Modern Arch')) return 'lib/assets/images/DormCharlie.png';
    if (name.contains('Serene Stay')) return 'lib/assets/images/DormDelta.png';
    return 'lib/assets/images/DormAlpha.png'; // Default
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // 🔹 Dorm Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: Image.asset(
                _getDormImage(dorm.name),
                width: 110,
                height: 110,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const SizedBox(width: 110, height: 110, child: Icon(Icons.image_not_supported, size: 40)),
              ),
            ),
            // 🔹 Dorm Details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      dorm.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Color(0xFF333333),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(Icons.location_on, size: 12, color: Colors.grey),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            dorm.address,
                            style: TextStyle(color: Colors.grey.shade600, fontSize: 10),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                         ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "₱ ${dorm.rate.toStringAsFixed(0)}/mo",
                          style: const TextStyle(
                            color: Color(0xFF4A7DFF),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.star, color: Color(0xFF4A7DFF), size: 16),
                            Text(
                              " ${dorm.rating} (${dorm.numOfRating})",
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      children: dorm.tags.map((tag) => _tag(tag)).toList(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 9,
          color: Colors.black54,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
