import 'dart:io';

import 'package:alcheringa/Authentication/authenticationviewmodel.dart';
import 'package:alcheringa/Common/globals.dart';
import 'package:alcheringa/Screens/home_screen.dart';
import 'package:alcheringa/Screens/main_screen.dart';
import 'package:alcheringa/Screens/profile_setup/widgets/intrest_button.dart';
import 'package:flutter/material.dart';

class SelectInterest extends StatefulWidget {
  final String? image;
  final String? name;
  const SelectInterest({super.key, this.image, this.name});

  @override
  State<SelectInterest> createState() => _SelectInterestState();
}

class _SelectInterestState extends State<SelectInterest> {

  final List<String> selectedInterests = [];

  void updateSelectedInterests(String interest, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedInterests.add(interest);
      } else {
        selectedInterests.remove(interest);
      }
    });
  }

    void onSave() {
      if(auth.currentUser!= null && auth.currentUser!.email!=null){
        print(auth.currentUser!.email!);
        
        addIntrestToDb(selectedInterests, auth.currentUser!.email!);
        if(widget.image!= null) onUpdateProfile(context, File(widget.image!), auth.currentUser!.email!, widget.name ?? 'Unknown');
      }
      print('Selected Interests: $selectedInterests');
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute( builder: (context) =>const MainScreen()), (Route<dynamic> route) => false,);
      
    
  }
  
  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/profile_setup_bg.png',
              fit: BoxFit.cover,
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.15,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  SizedBox(height: 30,),

                  Stack(
                    children: [
                      Image.asset('assets/images/profile_setup_h1_bg.png'),
                      Positioned.fill(
                          child: Center(
                            child: Text("Select Interests",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily:'Game_Tape',
                                  color: Colors.white60,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                )),
                          ))
                    ],
                  ),

                  SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: GridView.count(
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        childAspectRatio: 129/39,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 25.3,
                        mainAxisSpacing: 15,
                        children: <Widget>[
                          IntrestButton(onSelected: updateSelectedInterests,intrest: "Sports",),
                          IntrestButton(onSelected: updateSelectedInterests,intrest: "Music",),
                          IntrestButton(onSelected: updateSelectedInterests,intrest: "DJ",),
                          IntrestButton(onSelected: updateSelectedInterests,intrest: "Events",),
                          IntrestButton(onSelected: updateSelectedInterests,intrest: "Quiz",),
                          IntrestButton(onSelected: updateSelectedInterests,intrest: "Art",),
                          IntrestButton(onSelected: updateSelectedInterests,intrest: "Dance",),
                          IntrestButton(onSelected: updateSelectedInterests,intrest: "Fashion",),
                          IntrestButton(onSelected: updateSelectedInterests,intrest: "Literary",),
                          IntrestButton(onSelected: updateSelectedInterests,intrest: "Theatre",),
                        ]),
                  ),


                  SizedBox(height: 100,),



                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Stack(
                            children: [
                              Image.asset(
                                "assets/images/profile_setup_button_b.png",),
                              Positioned.fill(
                                child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 30),
                                      child: Text(
                                        "BACK",
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
                        GestureDetector(
                          onTap: onSave,
                           //(){ Navigator.push(context, MaterialPageRoute(builder: (_)=> SelectInterest()));},
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
                                          fontFamily:'Game_Tape',
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
          ],
        ),
      ),
    );
  }
}
