import 'dart:io';
import 'package:alcheringa/Screens/profile_setup/select_intrest.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSetup extends StatefulWidget {
  const ProfileSetup({super.key});

  @override
  State<ProfileSetup> createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  String? _image;
  TextEditingController nicknameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/profile_setup_bg.png',
              fit: BoxFit.cover,
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.asset('assets/images/profile_setup_h1_bg.png'),
                        Positioned.fill(
                            child: Center(
                          child: Text("Setup Profile",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Game_Tape',
                                color: Colors.white60,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              )),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final ImagePicker picker = ImagePicker();

                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);

                        if (image != null) {
                          print(image.path);
                          setState(() {
                            _image = image.path;
                          });
                        }
                      },
                      child: Stack(
                        children: [
                          // Image.asset('assets/images/profile_setup_pfp.png'),
                          Positioned.fill(
                            child: _image == null
                                ? Center(
                                    child: Container(
                                      child: Text(
                                        "Pick your\n image",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: 'Game_Tape',
                                          color: Colors.white60,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  )
                                : Positioned(
                                    top: 10,
                                    left: 15,
                                    right: 15,
                                    bottom: 30,
                                    child: Image.file(
                                      File(_image!),
                                      fit: BoxFit.cover,
                                    )),
                          ),
                          Image.asset('assets/images/profile_setup_pfp.png'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Stack(
                      children: [
                        Image.asset('assets/images/profile_setup_h2_bg.png'),
                        Positioned.fill(
                          child: Center(
                            child: TextField(
                              controller: nicknameController,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Game_Tape',
                                color: Colors.white60,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: InputDecoration(
                                hintText: "NICKNAME  -  OPTIONAL",
                                hintStyle: TextStyle(
                                  fontFamily: 'Game_Tape',
                                  color: Colors.white60,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Stack(
                              children: [
                                Image.asset(
                                  "assets/images/profile_setup_button_bd.png",
                                ),
                                Positioned.fill(
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Text(
                                      "BACK",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Game_Tape',
                                        color: Color(0xFFC2C3C7),
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,MaterialPageRoute(builder: (_) => SelectInterest(image: _image, name: nicknameController.text.trim(),)));
                            },
                            child: Stack(
                              children: [
                                Image.asset(
                                    "assets/images/profile_setup_button_n.png"),
                                Positioned.fill(
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.only(right: 30),
                                    child: Text(
                                      "NEXT",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'Game_Tape',
                                        color: Color(0xFF1D2B53),
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
