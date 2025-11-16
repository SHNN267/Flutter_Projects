import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymapp/constants/colors/Mycolors.dart';
import 'package:gymapp/constants/fonts/Myfonts.dart';
import 'package:gymapp/constants/strings/mystring.dart';
import 'package:gymapp/cubit/advirtesement_cubit/adviritesment_cubit_state.dart';
import 'package:gymapp/cubit/advirtesement_cubit/advirtesement_cubit.dart';
import 'package:gymapp/screens/view_advertisement.dart';
import 'package:gymapp/widgets/helper_widget/mybutton.dart';
import 'package:gymapp/widgets/helper_widget/mytext_form_fild.dart';
import 'package:image_picker/image_picker.dart';

class AdvertisementScreen extends StatefulWidget {
  const AdvertisementScreen({super.key});

  @override
  State<AdvertisementScreen> createState() => _AdvertisementScreenState();
  static const page_route = "AdvertisementScreen";
}

class _AdvertisementScreenState extends State<AdvertisementScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  bool _isActive = true;
  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  void _uploadAd(BuildContext context) {
    if (_selectedImage == null ||
        _titleController.text.isEmpty ||
        _contentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields and select an image"),
        ),
      );
      return;
    }

    context.read<AdvertisementCubit>().uploadAdvertisement(
      title: _titleController.text,
      content: _contentController.text,
      isActive: _isActive,
      imageFile: _selectedImage!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          MyStrings.Add_New_Advertisement,
          style: MyFontStyle.mainTitle(color: MyColor.white),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<AdvertisementCubit, AdvertisementState>(
        listener: (context, state) {
          if (state is AdvertisementSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Advertisement uploaded successfully ✅"),
              ),
            );
          } else if (state is AdvertisementError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Error: ${state.message}")));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MyTextFormFild(
                  controller: _titleController,
                  labelText: "Advertisement Title",
                ),
                const SizedBox(height: 15),
                MyTextFormFild(
                  controller: _contentController,
                  maxLines: 3,
                  labelText: "Advertisement Content",
                ),
                const SizedBox(height: 15),
                SwitchListTile(
                  title: const Text("Activate Advertisement"),
                  value: _isActive,
                  activeColor: Colors.green,
                  onChanged: (value) {
                    setState(() {
                      _isActive = value;
                    });
                  },
                ),
                const SizedBox(height: 15),
                _selectedImage != null
                    ? Image.file(
                        _selectedImage!,
                        height: 200,
                        fit: BoxFit.contain,
                      )
                    : const Text("No image selected yet"),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // button color
                    foregroundColor: Colors.white, // text/icon color
                  ),
                  onPressed: _pickImage,
                  icon: const Icon(Icons.image),
                  label: const Text("Choose Image from Device"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, // button color
                    foregroundColor: Colors.white, // text/icon color
                  ),

                  onPressed: state is AdvertisementLoading
                      ? null
                      : () => _uploadAd(context),
                  child: state is AdvertisementLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Upload Advertisement"),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: MyButton(
        backgroundColor: Colors.black,
        text: "view my advert",
        onPressed: () {
          Navigator.pushNamed(context, ViewAdvertisement.page_route);
        },
        height: 75,
        width: 200,
        border: BorderSide(color: MyColor.white, width: 2),
      ),
    );
  }
}
