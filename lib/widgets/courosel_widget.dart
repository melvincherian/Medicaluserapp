// // import 'package:carousel_slider/carousel_slider.dart';
// // import 'package:flutter/material.dart';
// // import 'package:medical_user_app/providers/language_provider.dart';

// // class OrderMedicineCarouselWithAppText extends StatefulWidget {
// //   const OrderMedicineCarouselWithAppText({Key? key}) : super(key: key);

// //   @override
// //   State<OrderMedicineCarouselWithAppText> createState() => _OrderMedicineCarouselWithAppTextState();
// // }

// // class _OrderMedicineCarouselWithAppTextState extends State<OrderMedicineCarouselWithAppText> {
// //   int _currentIndex = 0;
// //   final CarouselController _carouselController = CarouselController();

// //   // Sample data for carousel items with translation keys
// //   final List<Map<String, String>> carouselData = [
// //     {
// //       'titleKey': 'order_medicine',
// //       'subtitleKey': 'delivery_line',
// //       'image': 'assets/deliveryBoy.png',
// //       'buttonKey': 'order_now',
// //     },
// //     {
// //       'titleKey': 'order_medicine',
// //       'subtitleKey': 'delivery_line',
// //       'image': 'assets/deliveryBoy.png',
// //       'buttonKey': 'order_now',
// //     },
// //     {
// //       'titleKey': 'order_medicine',
// //       'subtitleKey': 'delivery_line',
// //       'image': 'assets/deliveryBoy.png',
// //       'buttonKey': 'order_now',
// //     },
// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: [
// //         // Carousel Slider
// //         CarouselSlider.builder(
// //           // carouselController: _carouselController,
// //           itemCount: carouselData.length,
// //           itemBuilder: (context, index, realIndex) {
// //             final item = carouselData[index];
// //             return Container(
// //               width: double.infinity,
// //               margin: const EdgeInsets.symmetric(horizontal: 5),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(16),
// //                 boxShadow: const [
// //                   BoxShadow(
// //                     color: Color(0x40000000),
// //                     blurRadius: 7,
// //                     offset: Offset(0, 3),
// //                   ),
// //                 ],
// //               ),
// //               child: Stack(
// //                 children: [
// //                   Positioned(
// //                     right: 0,
// //                     bottom: 0,
// //                     child: Image.asset(
// //                       item['image']!,
// //                       height: 120,
// //                       fit: BoxFit.contain,
// //                     ),
// //                   ),
// //                   Padding(
// //                     padding: const EdgeInsets.all(20.0),
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       children: [
// //                         Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             AppText(
// //                               item['titleKey']!,
// //                               style: const TextStyle(
// //                                 fontSize: 18,
// //                                 fontWeight: FontWeight.bold,
// //                                 color: Color.fromARGB(255, 17, 17, 17),
// //                               ),
// //                             ),
// //                             const SizedBox(height: 8),
// //                             AppText(
// //                               item['subtitleKey']!,
// //                               style: const TextStyle(
// //                                 fontSize: 14,
// //                                 color: Color(0XFF000000),
// //                               ),
// //                             ),
// //                           ],
// //                         ),
// //                         const SizedBox(height: 6),
// //                         // ElevatedButton(
// //                         //   onPressed: () {
// //                         //     _handleButtonPress(index);
// //                         //   },
// //                         //   style: ElevatedButton.styleFrom(
// //                         //     backgroundColor: const Color(0xFF5931DD),
// //                         //     foregroundColor: Colors.white,
// //                         //     textStyle: const TextStyle(fontWeight: FontWeight.bold),
// //                         //     padding: const EdgeInsets.symmetric(
// //                         //         horizontal: 20, vertical: 10),
// //                         //     shape: RoundedRectangleBorder(
// //                         //       borderRadius: BorderRadius.circular(20),
// //                         //     ),
// //                         //   ),
// //                         //   child: AppText(item['buttonKey']!),
// //                         // ),
// //                       ],
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             );
// //           },
// //           options: CarouselOptions(
// //             height: 188,
// //             viewportFraction: 0.9,
// //             initialPage: 0,
// //             enableInfiniteScroll: true,
// //             reverse: false,
// //             autoPlay: true,
// //             autoPlayInterval: const Duration(seconds: 4),
// //             autoPlayAnimationDuration: const Duration(milliseconds: 800),
// //             autoPlayCurve: Curves.fastOutSlowIn,
// //             enlargeCenterPage: true,
// //             enlargeFactor: 0.2,
// //             scrollDirection: Axis.horizontal,
// //             onPageChanged: (index, reason) {
// //               setState(() {
// //                 _currentIndex = index;
// //               });
// //             },
// //           ),
// //         ),

// //         const SizedBox(height: 16),

// //         // Dot Indicators
// //         Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: carouselData.asMap().entries.map((entry) {
// //             int index = entry.key;
// //             return GestureDetector(
// //               onTap: () {
// //                 // _carouselController.animateToPage(index);
// //               },
// //               child: Container(
// //                 width: _currentIndex == index ? 24 : 8,
// //                 height: 8,
// //                 margin: const EdgeInsets.symmetric(horizontal: 3),
// //                 decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.circular(4),
// //                   color: _currentIndex == index
// //                       ? const Color(0xFF5931DD)
// //                       : Colors.grey.withOpacity(0.4),
// //                 ),
// //               ),
// //             );
// //           }).toList(),
// //         ),
// //       ],
// //     );
// //   }

// //   void _handleButtonPress(int index) {
// //     // Handle different actions based on carousel item
// //     switch (index) {
// //       case 0:
// //         // Order Medicine action
// //         print('Order Medicine pressed');
// //         break;
// //       case 1:
// //         // Fast Delivery action
// //         print('Get Started pressed');
// //         break;
// //       case 2:
// //         // Quality Assured action
// //         print('Shop Now pressed');
// //         break;
// //     }
// //   }
// // }












// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:medical_user_app/models/banner_model.dart';
// import 'dart:convert';
// import 'package:medical_user_app/providers/language_provider.dart';

// class OrderMedicineCarouselWithAppText extends StatefulWidget {
//   const OrderMedicineCarouselWithAppText({Key? key}) : super(key: key);

//   @override
//   State<OrderMedicineCarouselWithAppText> createState() => _OrderMedicineCarouselWithAppTextState();
// }

// class _OrderMedicineCarouselWithAppTextState extends State<OrderMedicineCarouselWithAppText> {
//   int _currentIndex = 0;
//   final CarouselController _carouselController = CarouselController();
  
//   List<BannerModel> banners = [];
//   bool isLoading = true;
//   bool hasError = false;

//   @override
//   void initState() {
//     super.initState();
//     fetchBanners();
//   }

//   Future<void> fetchBanners() async {
//     try {
//       setState(() {
//         isLoading = true;
//         hasError = false;
//       });

//       final response = await http.get(
//         Uri.parse('http://31.97.206.144:7021/api/admin/getallbanners'),
//         headers: {
//           'Content-Type': 'application/json',
//         },
//       );

//       if (response.statusCode == 200) {
//         final Map<String, dynamic> responseData = json.decode(response.body);
        
//         if (responseData['success'] == true && responseData['data'] != null) {
//           final List<dynamic> bannerList = responseData['data'];
//           setState(() {
//             banners = bannerList.map((banner) => BannerModel.fromJson(banner)).toList();
//             isLoading = false;
//           });
//         } else {
//           throw Exception('Invalid response format');
//         }
//       } else {
//         throw Exception('Failed to load banners: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching banners: $e');
//       setState(() {
//         hasError = true;
//         isLoading = false;
//         // Fallback to sample data
//         // _loadSampleData();
//       });
//     }
//   }

//   // void _loadSampleData() {
//   //   banners = [
//   //     BannerModel(
//   //       id: '1',
//   //       title: 'Order Medicine',
//   //       description: 'Fast delivery to your doorstep',
//   //       imageUrl: 'assets/deliveryBoy.png',
//   //       isActive: true,
//   //     ),
//   //     BannerModel(
//   //       id: '2',
//   //       title: 'Quality Assured',
//   //       description: 'Genuine medicines from trusted sources',
//   //       imageUrl: 'assets/deliveryBoy.png',
//   //       isActive: true,
//   //     ),
//   //     BannerModel(
//   //       id: '3',
//   //       title: 'Easy Ordering',
//   //       description: 'Order with just a few taps',
//   //       imageUrl: 'assets/deliveryBoy.png',
//   //       isActive: true,
//   //     ),
//   //   ];
//   // }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Container(
//         height: 240,
//         child: const Center(
//           child: CircularProgressIndicator(
//             color: Color(0xFF5931DD),
//           ),
//         ),
//       );
//     }

//     if (banners.isEmpty) {
//       return Container(
//         height: 240,
//         child: const Center(
//           child: Text('No banners available'),
//         ),
//       );
//     }

//     return Column(
//       children: [
//         // Carousel Slider
//         CarouselSlider.builder(
//           // carouselController: _carouselController,
//           itemCount: banners.length,
//           itemBuilder: (context, index, realIndex) {
//             final banner = banners[index];
//             return Container(
//               width: double.infinity,
//               margin: const EdgeInsets.symmetric(horizontal: 5),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: const [
//                   BoxShadow(
//                     color: Color(0x40000000),
//                     blurRadius: 7,
//                     offset: Offset(0, 3),
//                   ),
//                 ],
//               ),
//               child: Stack(
//                 children: [
//                   // Show only API network images
//                   if (banner.imageUrl.isNotEmpty && banner.imageUrl.startsWith('http'))
//                     Positioned(
//                       right: 0,
//                       bottom: 0,
//                       child: Image.network(
//                         banner.imageUrl,
//                         height: 120,
//                         fit: BoxFit.contain,
//                         loadingBuilder: (context, child, loadingProgress) {
//                           if (loadingProgress == null) return child;
//                           return Container(
//                             height: 120,
//                             width: 120,
//                             alignment: Alignment.center,
//                             child: CircularProgressIndicator(
//                               value: loadingProgress.expectedTotalBytes != null
//                                   ? loadingProgress.cumulativeBytesLoaded /
//                                       loadingProgress.expectedTotalBytes!
//                                   : null,
//                               strokeWidth: 2,
//                               color: const Color(0xFF5931DD),
//                             ),
//                           );
//                         },
//                         errorBuilder: (context, error, stackTrace) {
//                           return const SizedBox.shrink(); // Don't show anything if image fails
//                         },
//                       ),
//                     ),
//                   Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               banner.title,
//                               style: const TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                                 color: Color.fromARGB(255, 17, 17, 17),
//                               ),
//                             ),
//                             const SizedBox(height: 8),
//                             Text(
//                               banner.description,
//                               style: const TextStyle(
//                                 fontSize: 14,
//                                 color: Color(0XFF000000),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const SizedBox(height: 6),
//                         if (banner.buttonText != null && banner.buttonText!.isNotEmpty)
//                           ElevatedButton(
//                             onPressed: () {
//                               // _handleButtonPress(banner, index);
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: const Color(0xFF5931DD),
//                               foregroundColor: Colors.white,
//                               textStyle: const TextStyle(fontWeight: FontWeight.bold),
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 20, vertical: 10),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                             ),
//                             child: Text(banner.buttonText!),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//           options: CarouselOptions(
//             height: 188,
//             viewportFraction: 0.9,
//             initialPage: 0,
//             enableInfiniteScroll: banners.length > 1,
//             reverse: false,
//             autoPlay: banners.length > 1,
//             autoPlayInterval: const Duration(seconds: 4),
//             autoPlayAnimationDuration: const Duration(milliseconds: 800),
//             autoPlayCurve: Curves.fastOutSlowIn,
//             enlargeCenterPage: true,
//             enlargeFactor: 0.2,
//             scrollDirection: Axis.horizontal,
//             onPageChanged: (index, reason) {
//               setState(() {
//                 _currentIndex = index;
//               });
//             },
//           ),
//         ),

//         const SizedBox(height: 16),

//         // Dot Indicators
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: banners.asMap().entries.map((entry) {
//             int index = entry.key;
//             return GestureDetector(
//               onTap: () {
//                 // _carouselController.animateToPage(index);
//               },
//               child: Container(
//                 width: _currentIndex == index ? 24 : 8,
//                 height: 8,
//                 margin: const EdgeInsets.symmetric(horizontal: 3),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(4),
//                   color: _currentIndex == index
//                       ? const Color(0xFF5931DD)
//                       : Colors.grey.withOpacity(0.4),
//                 ),
//               ),
//             );
//           }).toList(),
//         ),

//         // Error message and refresh button
//         if (hasError)
//           Padding(
//             padding: const EdgeInsets.only(top: 8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const Icon(Icons.warning, color: Colors.orange, size: 16),
//                 const SizedBox(width: 4),
//                 const Text('Using offline data', style: TextStyle(fontSize: 12)),
//                 const SizedBox(width: 8),
//                 GestureDetector(
//                   onTap: fetchBanners,
//                   child: const Text(
//                     'Retry',
//                     style: TextStyle(
//                       fontSize: 12,
//                       color: Color(0xFF5931DD),
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//       ],
//     );
//   }


// }












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