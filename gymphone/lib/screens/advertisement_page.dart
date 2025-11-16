import 'package:flutter/material.dart';
import 'package:gymphone/utilis/connection_manager/connection_manager_app.dart';
import 'package:gymphone/utilis/connection_manager/response.dart';
import 'package:gymphone/utilis/models/advirtisement.dart';

class AdvertisementScreen extends StatefulWidget {
  const AdvertisementScreen({super.key});

  static const pageRoute = "AdvertisementScreen";

  @override
  State<AdvertisementScreen> createState() => _AdvertisementScreenState();
}

class _AdvertisementScreenState extends State<AdvertisementScreen> {
  late Future<MyResponse> futureAds;

  @override
  void initState() {
    super.initState();
    futureAds = ConnectionFunctions.getAllAdvertisements();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Advertisements",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: FutureBuilder<MyResponse>(
        future: futureAds,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "❌ Error: ${snapshot.error}",
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData ||
              snapshot.data!.body == null ||
              (snapshot.data!.body as List).isEmpty) {
            return const Center(
              child: Text("No advertisements available right now."),
            );
          }

          // ✅ Parse ads list
          List<Advertisement> ads = List<Advertisement>.from(
            snapshot.data!.body,
          );

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: ads.length,
            itemBuilder: (context, index) {
              final ad = ads[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 🖼️ Image
                    if (ad.imageUrl.isNotEmpty)
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                        child: Image.network(
                          ad.imageUrl,
                          width: double.infinity,
                          height: 180,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                height: 180,
                                color: Colors.grey.shade300,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.broken_image,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                              ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ad.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            ad.content,
                            style: const TextStyle(fontSize: 15),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ad.isActive ? "🟢 Active" : "🔴 Inactive",
                                style: TextStyle(
                                  color: ad.isActive
                                      ? Colors.green
                                      : Colors.red,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                ad.createdAt,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
