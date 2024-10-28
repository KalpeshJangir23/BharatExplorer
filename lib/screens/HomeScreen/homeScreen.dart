import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trip_show_planner/provider/booking_provider.dart';
import 'package:trip_show_planner/provider/list_distination_provider.dart';
import 'package:trip_show_planner/screens/HomeScreen/widgets/adventure/beach.dart';
import 'package:trip_show_planner/screens/HomeScreen/widgets/adventure_Container.dart';
import 'package:trip_show_planner/screens/momument_display.dart/booking.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _Home();
}

class _Home extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          // Wrap with SingleChildScrollView
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 20),
                _buildCarousel(),
                const SizedBox(height: 20),
                Expanded(child: _buildAdventureSection()), // Wrap with Expanded
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Discover',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          CircleAvatar(
            backgroundColor: Colors.grey[800],
            child: const Icon(Icons.person, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel() {
    final destinations = ref.watch(destinationListProvider);
    return CarouselSlider.builder(
      itemCount: destinations.length,
      itemBuilder: (context, index, realIndex) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    BookingPage(
                  index: index,
                  imageName: destinations[index].imagePath,
                  placeName: destinations[index].title,
                  description: destinations[index].discription,
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
            ref.read(bookingProvider.notifier).updateDistination(ref, index);
          },
          child: destinations[index],
        );
      },
      options: CarouselOptions(
        height: 400, // Reduced height
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        viewportFraction: 0.8,
      ),
    );
  }

  Widget _buildAdventureSection() {
    final val = Navigator.of(context);
    final List<BlurImageContainer> adventures = [
      BlurImageContainer(
          name: 'Beach',
          onTap: () {
            val.push(MaterialPageRoute(
              builder: (context) => const Beach(title: 'Beach'),
            ));
          },
          imageUrl: 'assets/images/desert.jpg'),
      BlurImageContainer(
          name: 'Mountain',
          onTap: () {
            val.push(MaterialPageRoute(
              builder: (context) => const Beach(title: 'Beach'),
            ));
          },
          imageUrl: 'assets/images/desert.jpg'),
      BlurImageContainer(
          name: 'Forest',
          onTap: () {
            val.push(MaterialPageRoute(
              builder: (context) => const Beach(title: 'Beach'),
            ));
          },
          imageUrl: 'assets/images/desert.jpg'),
      BlurImageContainer(
          name: 'Desert',
          onTap: () {
            val.push(MaterialPageRoute(
              builder: (context) => const Beach(title: 'Beach'),
            ));
          },
          imageUrl: 'assets/images/desert.jpg'),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Feeling Adventurous ?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Get inspiration from these trending categories',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.builder(
              physics:
                  const NeverScrollableScrollPhysics(), // Disable scrolling
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2 / 1,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: adventures.length,
              itemBuilder: (context, index) {
                return BlurImageContainer(
                  name: adventures[index].name,
                  imageUrl: adventures[index].imageUrl,
                  onTap: adventures[index].onTap,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}