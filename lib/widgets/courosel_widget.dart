import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:medical_user_app/providers/language_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderMedicineCarouselWithAppText extends StatefulWidget {
  const OrderMedicineCarouselWithAppText({Key? key}) : super(key: key);

  @override
  State<OrderMedicineCarouselWithAppText> createState() => _OrderMedicineCarouselWithAppTextState();
}

class _OrderMedicineCarouselWithAppTextState extends State<OrderMedicineCarouselWithAppText> {
  int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();
  
  List<String> bannerImages = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchBanners();
  }

  Future<void> fetchBanners() async {
    try {
      setState(() {
        isLoading = true;
        hasError = false;
      });

      final response = await http.get(
        Uri.parse('http://31.97.206.144:7021/api/admin/getallbanners'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['banners'] != null && data['banners'].isNotEmpty) {
          final List<String> images = [];
          
          // Extract all images from all banners
          for (var banner in data['banners']) {
            if (banner['images'] != null) {
              for (var image in banner['images']) {
                images.add(image.toString());
              }
            }
          }
          
          setState(() {
            bannerImages = images;
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
            hasError = true;
          });
        }
      } else {
        setState(() {
          isLoading = false;
          hasError = true;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        hasError = true;
      });
      print('Error fetching banners: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        height: 220,
        child: const Center(
          child: CircularProgressIndicator(
            color: Color(0xFF5931DD),
          ),
        ),
      );
    }

    if (hasError || bannerImages.isEmpty) {
      return Container(
        height: 220,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 48,
                color: Colors.grey,
              ),
              const SizedBox(height: 8),
              const Text(
                'Failed to load banners',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: fetchBanners,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5931DD),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: [
        // Carousel Slider
        CarouselSlider.builder(
          // carouselController: _carouselController,
          itemCount: bannerImages.length,
          itemBuilder: (context, index, realIndex) {
            final imageUrl = bannerImages[index];
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x40000000),
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 188,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 188,
                      child: Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                          color: const Color(0xFF5931DD),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 188,
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.broken_image,
                              size: 48,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 8),
                            // Text(
                            //   'Failed to load image',
                            //   style: TextStyle(
                            //     color: Colors.grey,
                            //     fontSize: 14,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: 140,
            viewportFraction: 0.9,
            initialPage: 0,
            enableInfiniteScroll: bannerImages.length > 1,
            reverse: false,
            autoPlay: bannerImages.length > 1,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.2,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),

        const SizedBox(height: 16),

        // Dot Indicators
        if (bannerImages.length > 1)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: bannerImages.asMap().entries.map((entry) {
              int index = entry.key;
              return GestureDetector(
                onTap: () {
                  // _carouselController.animateToPage(index);
                },
                child: Container(
                  width: _currentIndex == index ? 24 : 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentIndex == index
                        ? const Color(0xFF5931DD)
                        : Colors.grey.withOpacity(0.4),
                  ),
                ),
              );
            }).toList(),
          ),
      ],
    );
  }

  void _handleBannerPress(int index) {
    // Handle banner tap action
    print('Banner $index pressed');
    // You can add navigation or other actions here
  }
}