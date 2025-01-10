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
      interests = Future.value([]); 
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
                      final ImagePicker picker = ImagePicker();
                      final XFile? image =
                          await picker.pickImage(source: ImageSource.gallery);

                      setState(() {
                        _image = image?.path ??
                            'assets/images/cat.jpeg'; // Default cat photo
                      });
                    },
                    child: Stack(
                      children: [
          Image.asset('assets/images/profile_setup_pfp.png'),

                        Container(
                          margin: const EdgeInsets.all(30),
                          child: _image != null
                              ? (_image!.startsWith('assets')
                                  ? Image.asset(
                                      _image!,
                                      width: 220,
                                      height: 220,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      File(_image!),
                                      width: 220,
                                      height: 220,
                                      fit: BoxFit.cover,
                                    ))
                              : FutureBuilder<String?>(
                                  future: _imageUrl,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<String?> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return const CircularProgressIndicator();
                                    }
                                    if (snapshot.hasError ||
                                        !snapshot.hasData ||
                                        snapshot.data!.isEmpty) {
                                      return Image.asset(
                                        'assets/images/cat.jpeg',
                                        width: 230,
                                        height: 230,
                                        fit: BoxFit.cover,
                                      ); // Default cat image
                                    }
                                    return Image.network(
                                      snapshot.data!,
                                      width: 230,
                                      height: 230,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                        ),
                        
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
                        return const CircularProgressIndicator();
                      }
                      if (snapshot.hasError) {
                        print("Error in fetching interests");
                        return const SizedBox();
                      }
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        print("No interests found");
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
