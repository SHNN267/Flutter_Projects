import 'package:flutter/material.dart';

class AdvertisementCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subTitle;
  final void Function()? onPressed;

  const AdvertisementCard({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(25),
        shadowColor: Colors.black45,
        child: Container(
          width: screenWidth * 0.95,
          height: screenHeight * 0.75,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              // Image Banner with Gradient Overlay
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(25),
                ),
                child: Stack(
                  children: [
                    Image.network(
                      imagePath,
                      height: screenHeight * 0.4,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      height: screenHeight * 0.4,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.6),
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 28,
                          color: Colors.amber,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black54,
                              blurRadius: 6,
                              offset: Offset(1, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Description
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Text(
                      subTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ),

              // Action buttons and footer
              Container(
                decoration: BoxDecoration(
                  color: Colors.amber[50],
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(25),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.campaign, color: Colors.black54),
                        SizedBox(width: 8),
                        Text(
                          "Sponsored",
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: onPressed,
                      icon: const Icon(
                        Icons.delete_outline,
                        size: 20,
                        color: Colors.white,
                      ),
                      label: const Text(
                        "Remove",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
