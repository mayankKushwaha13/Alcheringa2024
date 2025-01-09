import 'dart:io';

import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Model/view_model_main.dart';
import 'package:alcheringa/Screens/profile_setup/select_intrest.dart';
import 'package:alcheringa/Screens/profile_setup/widgets/intrest_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final Future<List<String>> interests;
  String? _image;
  final TextEditingController nicknameController = TextEditingController();
  late Future<String> _imageUrl;

  @override
  void initState() {
    super.initState();
    if (auth.currentUser != null && auth.currentUser!.email != null) {
      interests = ViewModelMain().getInterests(auth.currentUser!.email!);
      _imageUrl = ViewModelMain().getValue('PhotoURL');
    } else {
      interests = Future.value([]); // Return an empty list for safety
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  GestureDetector(
                    onTap: () async {
                      /* final ImagePicker picker = ImagePicker();
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);

                      if (image != null) {
                        setState(() {
                          _image = image.path;
                        });
                      } */
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: 
                          FutureBuilder<String?>(
                    future: _imageUrl,
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox();
                      }
                      if (snapshot.hasError) {
                        print("error in fetching image");
                        return _image == null
                              ? Center(
                                  child: Container(
                                    color: Colors.green,
                                    child: const Text(
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
                              : Padding(
                                padding: const EdgeInsets.fromLTRB(15,10,15,30.0),
                                child: Image.file(
                                    File(_image!),
                                    fit: BoxFit.cover,
                                  ),
                              );
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        print("no image found");
                         return _image == null
                              ? Center(
                                  child: Container(
                                    color: Colors.green,
                                    child: const Text(
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
                              : Padding(
                                padding: const EdgeInsets.fromLTRB(15,10,15,30.0),
                                child: Image.file(
                                    File(_image!),
                                    fit: BoxFit.cover,
                                  ),
                              );;
                      }

                      final String? uri = snapshot.data!;
                      if(_imageUrl!=null||_imageUrl==" "){
                      return Padding(
                                padding: const EdgeInsets.fromLTRB(15,10,15,30.0),
                                child: Image.network(
                                    uri!,
                                    fit: BoxFit.cover,
                                  ),
                              );
                              }

                              return _image == null
                              ? Center(
                                  child: Container(
                                    color: Colors.green,
                                    child: const Text(
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
                              : Padding(
                                padding: const EdgeInsets.fromLTRB(15,10,15,30.0),
                                child: Image.file(
                                    File(_image!),
                                    fit: BoxFit.cover,
                                  ),
                              );
                    },
                  )
                
                          
                          
                          ,
                        ),
                        Image.asset('assets/images/profile_setup_pfp.png'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Stack(
                    children: [
                      Image.asset('assets/images/profile_setup_h2_bg.png'),
                      Positioned.fill(
                        child: Center(
                          child: Text(
                            auth.currentUser?.displayName ?? "Nickname",
                            style: const TextStyle(
                              fontFamily: 'Game_Tape',
                              color: Colors.white60,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  FutureBuilder<List<String>>(
                    future: interests,
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox();
                      }
                      if (snapshot.hasError) {
                        print("error in fetching intrests");
                        return const SizedBox();
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        print("no intrets found");
                         return const SizedBox();
                      }

                      final List<String> interestList = snapshot.data!;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          childAspectRatio: 129 / 39,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 25.3,
                          mainAxisSpacing: 15,
                          children: interestList
                              .map((e) => IntrestButton(
                                    onSelected: null,
                                    intrest: e,
                                  ))
                              .toList(),
                        ),
                      );
                    },
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
