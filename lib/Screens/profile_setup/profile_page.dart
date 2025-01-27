import 'dart:io';

import 'package:alcheringa/Authentication/authenticationviewmodel.dart';
import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Common/resource.dart';
import 'package:alcheringa/Screens/profile_setup/widgets/intrest_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEdit = false;
  List<String> interests = [];
  String? _image;
  final TextEditingController nicknameController = TextEditingController();
  late Future<String> _imageUrl;
  String? imageUri;
  List<String> selectedIntrests = [];

  @override
  void initState() {
    super.initState();
    _imageUrl = viewModelMain.getValue('PhotoURL');

    //nicknameController.text = auth.currentUser?.displayName ?? "Nickname";
    getDatas();
  }

  Future<void> getDatas() async {
    nicknameController.text = await viewModelMain.getValue('userName');
    if (auth.currentUser != null && auth.currentUser!.email != null) {
      interests = await viewModelMain.getInterests(auth.currentUser!.email!);
      imageUri = await viewModelMain.getValue('PhotoURL');
    } else {
      interests = []; // Return an empty list for safety
    }

    setState(() {});
  }

  Future<void> onSave() async {
    isLoading = true;
    setState(() {});
    try {
      print('Couln\'t update profile 1');
      if (auth.currentUser != null && auth.currentUser!.email != null) {
        if (_image != null) {
          onUpdateProfile(context, File(_image!), auth.currentUser!.email!,
              nicknameController.text.trim());
        }
        await updateUserName(
            nicknameController.text.trim(), auth.currentUser!.email!);
        await addIntrestToDb(selectedIntrests, auth.currentUser!.email!);
      }
      interests = selectedIntrests;
    } catch (e) {
      print('Couln\'t update profile $e');
      showMessage('Couldn\'t update the profile', context);
    }
    setState(() => isEdit = false);
    isLoading = false;
  }

  // Function to show a confirmation dialog
  Future<bool> _showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Confirm Deletion"),
              content: Text(
                  "Are you sure you want to delete your account? This action cannot be undone."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pop(false); // User chose not to delete
                  },
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.of(context).pop(true); // User confirmed deletion
                  },
                  child: Text("Delete"),
                ),
              ],
            );
          },
        ) ??
        false; // Default to false if the dialog is dismissed
  }

  void updateSelectedInterests(String interest, bool isSelected) {
    setState(() {
      if (isSelected) {
        if (!selectedIntrests.contains(interest)) {
          selectedIntrests.add(interest);
        }
      } else {
        selectedIntrests.remove(interest);
      }
    });
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() => _image = image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        onPopInvokedWithResult: (_, __) {
          setState(() {
            isLoading = false;
          });
        },
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: kToolbarHeight + 20,
            backgroundColor: Color.fromRGBO(63, 19, 42, 1),
            automaticallyImplyLeading: false,
            title: Container(
              padding: EdgeInsets.only(right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/images/back_button.png',
                      width: 50.0,
                      height: 50.0,
                    ),
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(
                      fontFamily: 'Game_Tape',
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFFFF1E8),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Container(
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/profile_setup_bg.png'),
                      fit: BoxFit.fill)),
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 10.0, top: 5.0),
                              child: GestureDetector(
                                onTap: () {
                                  if (!isEdit) {
                                    setState(() => isEdit = true);
                                  } else {
                                    onSave();
                                  }
                                },
                                child: Icon(
                                  isEdit ? Icons.save : Icons.edit,
                                  color: Color(0xFFfff1e8),
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: 140.0,
                              ),
                              GestureDetector(
                                onTap: () => isEdit ? _pickImage() : null,
                                child: Stack(
                                  children: [
                                    Positioned.fill(
                                      child: FutureBuilder<String?>(
                                        future: _imageUrl,
                                        builder:
                                            (BuildContext context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }

                                          if (snapshot.hasError ||
                                              snapshot.data == null ||
                                              snapshot.data!.isEmpty) {
                                            print(_imageUrl);
                                            return Positioned.fill(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        15, 10, 15, 30.0),
                                                child: Image.asset(
                                                  "assets/images/default_profile_pic.png",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            );
                                          }

                                          final String? uri = snapshot.data;

                                          if (uri == null || uri.isEmpty) {
                                            print(
                                                "uri is empty or null in profile page");
                                            return _buildImageOverlay(
                                                "Add your\nimage");
                                          }

                                          return Stack(
                                            children: [
                                              Positioned.fill(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          15, 10, 15, 30.0),
                                                  child: CachedNetworkImage(
                                                    imageUrl: uri,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              if (isEdit && _image == null)
                                                _buildEditOverlay(),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                    if (_image != null)
                                      Positioned.fill(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              15, 10, 15, 30.0),
                                          child: Image.file(
                                            File(_image!),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    Image.asset(
                                        'assets/images/profile_setup_pfp.png'),
                                  ],
                                ),
                              ),

                              //Name
                              const SizedBox(height: 24),
                              Stack(
                                children: [
                                  Image.asset(
                                      'assets/images/profile_setup_h2_bg.png'),
                                  Positioned.fill(
                                    child: Center(
                                      child: TextField(
                                        enabled: isEdit,
                                        controller: nicknameController,
                                        style: const TextStyle(
                                          fontFamily: 'Game_Tape',
                                          color: Colors.white60,
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              ElevatedButton(
                                onPressed: () async {
                                  // Show confirmation dialog before deleting account
                                  final shouldDelete =
                                      await _showDeleteConfirmationDialog(
                                          context);
                                  if (shouldDelete) {
                                    // Proceed to delete the account
                                    await deleteAccount(context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors
                                      .transparent, // Transparent background
                                  shadowColor:
                                      Colors.transparent, // Remove shadow
                                  elevation: 0, // Remove elevation if desired
                                ),
                                child: Text(
                                  "Delete Account",
                                  style: const TextStyle(
                                    fontFamily: 'Game_Tape',
                                    color: Colors.white60,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              isEdit
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: GridView.count(
                                          crossAxisCount: 2,
                                          shrinkWrap: true,
                                          childAspectRatio: 129 / 39,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          crossAxisSpacing: 25.3,
                                          mainAxisSpacing: 15,
                                          children: <Widget>[
                                            IntrestButton(
                                              onSelected:
                                                  updateSelectedInterests,
                                              intrest: "Sports",
                                            ),
                                            IntrestButton(
                                              onSelected:
                                                  updateSelectedInterests,
                                              intrest: "Music",
                                            ),
                                            IntrestButton(
                                              onSelected:
                                                  updateSelectedInterests,
                                              intrest: "DJ",
                                            ),
                                            IntrestButton(
                                              onSelected:
                                                  updateSelectedInterests,
                                              intrest: "Events",
                                            ),
                                            IntrestButton(
                                              onSelected:
                                                  updateSelectedInterests,
                                              intrest: "Quiz",
                                            ),
                                            IntrestButton(
                                              onSelected:
                                                  updateSelectedInterests,
                                              intrest: "Art",
                                            ),
                                            IntrestButton(
                                              onSelected:
                                                  updateSelectedInterests,
                                              intrest: "Dance",
                                            ),
                                            IntrestButton(
                                              onSelected:
                                                  updateSelectedInterests,
                                              intrest: "Fashion",
                                            ),
                                            IntrestButton(
                                              onSelected:
                                                  updateSelectedInterests,
                                              intrest: "Literary",
                                            ),
                                            IntrestButton(
                                              onSelected:
                                                  updateSelectedInterests,
                                              intrest: "Theatre",
                                            ),
                                          ]),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: GridView.count(
                                        crossAxisCount: 2,
                                        shrinkWrap: true,
                                        childAspectRatio: 129 / 39,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        crossAxisSpacing: 25.3,
                                        mainAxisSpacing: 15,
                                        children: interests
                                            .map((e) => IntrestButton(
                                                  onSelected: null,
                                                  intrest: e,
                                                ))
                                            .toList(),
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    )),
        ),
      ),
    );
  }
}

Widget _buildImageOverlay(String text) {
  return Positioned.fill(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 30.0),
      child: Container(
        color: Color(0xFF1D2B53),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Game_Tape',
              color: Colors.white60,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _buildEditOverlay() {
  return Positioned.fill(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 30.0),
      child: Container(
        color: Colors.black45,
        child: const Center(
          child: Icon(
            Icons.edit,
            size: 30,
            color: Color.fromARGB(255, 228, 228, 228),
          ),
        ),
      ),
    ),
  );
}
