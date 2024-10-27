import 'package:flutter/material.dart';
import 'package:trip_show_planner/core/config/assets/appImages.dart';
import 'package:trip_show_planner/screens/momument_display.dart/sub_sheets/01_find_location.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image with Overlay
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
              stops: const [0.5, 1.0],
            ).createShader(bounds),
            blendMode: BlendMode.darken,
            child: Image.asset(
              Appimages.tajMahal,
              fit: BoxFit.cover,
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Top Spacer
                  const Spacer(flex: 2),

                  // Title
                  const Text(
                    'Taj Mahal',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      height: 1.2,
                      letterSpacing: 1.2,
                      shadows: [
                        Shadow(
                          blurRadius: 8.0,
                          color: Colors.black45,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 24),

                  // Description
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Text(
                      'The Taj Mahal is an Islamic ivory-white marble mausoleum located in Agra, India.\n\n'
                      'It was commissioned in 1632 by Mughal emperor Shah Jahan to house the tomb of his favorite wife, Mumtaz Mahal.\n\n'
                      'The Taj Mahal is widely considered one of the most beautiful buildings in the world and a symbol of India\'s rich history.\n\n'
                      'It is a UNESCO World Heritage Site and attracts millions of visitors each year.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        height: 1.5,
                        shadows: [
                          Shadow( 
                            blurRadius: 4.0,
                            color: Colors.black45,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  // Bottom Spacer
                  const Spacer(flex: 1),

                  // Schedule Trip Button
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => const LocationBottomSheet(),
                          );
                        },
                        icon: const Icon(
                          Icons.rocket_launch_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                        label: const Text(
                          'Schedule Trip',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade600,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 32,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 0,
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
}
