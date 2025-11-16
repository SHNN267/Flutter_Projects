import 'package:flutter/material.dart';
import 'package:gymphone/constants/fonts/Myfonts.dart';
import 'package:gymphone/screens/advertisement_page.dart';
import 'package:gymphone/utilis/models/player_model.dart';

class PlayerScreen extends StatefulWidget {
  final Player player; // ✅ required Player object

  const PlayerScreen({super.key, required this.player});

  static const page_route = "PlayerScreen";

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late Player player;

  @override
  void initState() {
    super.initState();
    player = widget.player; // ✅ take player from constructor
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Direct access from Player object
    final String? playerName = player.name;
    final String? age = player.age;
    final String? height = player.height;
    final String? weight = player.weight;
    final String? phone = player.phoneNumber;
    final String? type = player.type;
    final String coachName = player.coachName ?? "Unknown";

    // ✅ Exercises
    final Map<String, List<String>> exercises = {
      "Chest": List<String>.from(player.chest ?? []),
      "Back": List<String>.from(player.back ?? []),
      "Biceps": List<String>.from(player.biceps ?? []),
      "Triceps": List<String>.from(player.triceps ?? []),
      "Legs": List<String>.from(player.legs ?? []),
      "Shoulders": List<String>.from(player.shoulders ?? []),
      "Abs": List<String>.from(player.abs ?? []),
    };

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Player Information", style: MyFontStyle.mainTitle()),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdvertisementScreen()),
            );
          },
          icon: Icon(Icons.shopping_bag_outlined),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Player profile
            CircleAvatar(
              radius: 55,
              backgroundColor: Colors.grey.shade200,
              child: const Icon(Icons.person, size: 60, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            Text(
              playerName!,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              type!,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 25),

            // Player details
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
                child: Column(
                  children: [
                    _buildInfoRow(Icons.cake, "Age", age!),
                    _buildInfoRow(Icons.height, "Height", height!),
                    _buildInfoRow(Icons.monitor_weight, "Weight", weight!),
                    _buildInfoRow(Icons.phone, "Phone", phone!),
                    _buildInfoRow(Icons.fitness_center, "Coach", coachName),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 25),

            // Muscle groups
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Muscle Groups",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 15),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: exercises.keys.map((muscle) {
                return ActionChip(
                  label: Text(
                    muscle,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.black87,
                  onPressed: () {
                    _showExercises(context, muscle, exercises[muscle]!);
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey.shade100,
            child: Icon(icon, color: Colors.black87, size: 20),
          ),
          const SizedBox(width: 15),
          Expanded(child: Text(title, style: const TextStyle(fontSize: 16))),
          Text(value, style: MyFontStyle.normal()),
        ],
      ),
    );
  }

  void _showExercises(BuildContext context, String muscle, List<String> list) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("$muscle Exercises"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: list
                .map(
                  (e) => ListTile(
                    leading: const Icon(Icons.fitness_center),
                    title: Text(e),
                  ),
                )
                .toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
