import 'package:flutter/material.dart';
import 'package:gymapp/constants/colors/Mycolors.dart';

// ignore: must_be_immutable
class PlayerCard extends StatelessWidget {
  final String name;
  final int memberId;
  final String gender;
  final String age;
  final String weight;
  final String date;
  final String height;
  final String? his_coch;
  final Color primaryColor;
  final String phoneNumber;
  final void Function() more_details;
  final void Function() deleteFunction;
  final void Function()? onTap;

  const PlayerCard({
    super.key,
    required this.date,
    required this.name,
    required this.memberId,
    required this.gender,
    required this.age,
    required this.weight,
    required this.height,
    required this.more_details,
    required this.deleteFunction,
    required this.phoneNumber,
    this.his_coch,
    this.onTap,
    this.primaryColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isDesktop = constraints.maxWidth > 800;
        bool isTablet =
            constraints.maxWidth > 500 && constraints.maxWidth <= 800;

        double fontSize = isDesktop
            ? 16
            : isTablet
            ? 14
            : 12;
        double titleFontSize = isDesktop
            ? 20
            : isTablet
            ? 18
            : 16;
        double avatarRadius = isDesktop
            ? 50
            : isTablet
            ? 40
            : 35;

        return GestureDetector(
          onTap: onTap,
          child: Center(
            child: Container(
              height: 900,
              constraints: const BoxConstraints(maxWidth: 700),
              padding: const EdgeInsets.all(8),
              child: Material(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                  side: BorderSide(width: 2, color: MyColor.primary_color),
                ),
                color: Colors.amber[50],
                shadowColor: primaryColor.withOpacity(0.3),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Header
                        Text(
                          "GYM MEMBER CARD",
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),

                        Container(
                          height: 3,
                          width: 100,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Avatar
                        CircleAvatar(
                          radius: avatarRadius,
                          backgroundColor: primaryColor.withOpacity(0.1),
                          child: Icon(
                            Icons.fitness_center,
                            color: primaryColor,
                            size: avatarRadius,
                          ),
                        ),
                        const SizedBox(height: 15),

                        // Name + ID
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Column(
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                  fontSize: fontSize + 2,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "ID: $memberId",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Info section responsive
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              width: 0.5,
                              color: MyColor.primary_color,
                            ),
                          ),
                          child: Wrap(
                            spacing: 12,
                            runSpacing: 8,
                            children: [
                              _buildInfoBox("Gender", gender, fontSize),
                              _buildInfoBox("Joined", date, fontSize),
                              _buildInfoBox("Age", age, fontSize),
                              _buildInfoBox("Weight", "$weight kg", fontSize),
                              _buildInfoBox("Height", "$height cm", fontSize),
                              _buildInfoBox(
                                "Coach",
                                his_coch ?? "---",
                                fontSize,
                              ),
                              _buildInfoBox("Phone", phoneNumber, fontSize),

                              //can add new items
                            ],
                          ),
                        ),

                        Text(
                          "Stay Strong 💪",
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: primaryColor.withOpacity(0.9),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(color: Colors.black54),

                        // Footer Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: deleteFunction,
                              icon: const Icon(Icons.delete, color: Colors.red),
                              tooltip: "Delete Member",
                            ),
                            TextButton(
                              onPressed: more_details,
                              child: Text(
                                "More Details",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoBox(String title, String value, double fontSize) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.black.withOpacity(0.4), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "$title: ",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
