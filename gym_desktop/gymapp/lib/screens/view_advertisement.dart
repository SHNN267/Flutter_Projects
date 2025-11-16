import 'package:flutter/material.dart';
import 'package:gymapp/constants/colors/Mycolors.dart';
import 'package:gymapp/constants/fonts/Myfonts.dart';
import 'package:gymapp/constants/strings/mystring.dart';
import 'package:gymapp/global/helper_functions.dart';
import 'package:gymapp/utilis/connection_manager/advert_connection/advert_connection_function.dart';
import 'package:gymapp/utilis/connection_manager/response.dart';
import 'package:gymapp/utilis/models/advirtisement.dart';
import 'package:gymapp/widgets/helper_widget/mybutton.dart';
import 'package:gymapp/widgets/widget_for_screens/advertisement_card.dart';

class ViewAdvertisement extends StatefulWidget {
  const ViewAdvertisement({super.key});

  @override
  State<ViewAdvertisement> createState() => _ViewAdvertisementState();

  static const page_route = "ViewAdvertisement";
}

class _ViewAdvertisementState extends State<ViewAdvertisement> {
  List<Advertisement> advertisements = [];

  @override
  void initState() {
    super.initState();
    _loadAdvertisements(); // ← this runs automatically when the screen starts
  }

  Future<void> _loadAdvertisements() async {
    try {
      MyResponse response =
          await AdvertConnectionFunction.getAllAdvertisements();

      setState(() {
        advertisements = response.body as List<Advertisement>;
      });

      // Just for testing: print the first ad title
      if (advertisements.isNotEmpty) {
        print(advertisements[0].title);
      } else {
        print("No advertisements found.");
      }
    } catch (e) {
      print("Error while loading advertisements: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "View Advertisements",
          style: MyFontStyle.mainTitle(color: MyColor.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // You can manually refresh if you want
        child: const Icon(Icons.refresh),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 15,
          childAspectRatio: 0.8,
        ),
        itemCount: advertisements.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: AdvertisementCard(
              imagePath: advertisements[index].imageUrl,
              onPressed: () async {
                deletePlayerFunction(context, advertisements[index]);

                await _loadAdvertisements();
              },
              subTitle: advertisements[index].content,
              title: advertisements[index].title,
            ),
          );
        },
      ),
    );
  }
}

void deletePlayerFunction(BuildContext context, Advertisement advert) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: MyColor.white,
      title: Text(
        "Do you want to delete this item ?",
        style: MyFontStyle.mainTitle(color: MyColor.black),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyButton(
              text: MyStrings.cancle,
              backgroundColor: MyColor.red,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            MyButton(
              text: MyStrings.ok,
              onPressed: () async {
                HelperFunctions.showLoadingDialog(context);
                try {
                  await AdvertConnectionFunction.deleteAdvertisement(
                    id: advert.id,
                  );
                  await AdvertConnectionFunction.getAllAdvertisements();

                  Navigator.pop(context); // close loading
                  HelperFunctions.showSuccessMessage(context, "advert deleted");
                } catch (e) {
                  HelperFunctions.showErrorMessage(
                    context,
                    MyStrings.error_while_deleting,
                  );
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ],
    ),
  );
}
