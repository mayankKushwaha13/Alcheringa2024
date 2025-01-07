import 'package:alcheringa/Screens/sponsersScreen/sponsors_list.dart';
import 'package:alcheringa/utils/styles/colors.dart';
import 'package:flutter/material.dart';

class sponsorScreen extends StatefulWidget {
  const sponsorScreen({super.key});

  @override
  State<sponsorScreen> createState() => _sponsorScreenState();
}

class _sponsorScreenState extends State<sponsorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBar(context),
      body: Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/images/background.png"),fit: BoxFit.cover)
              ),
              child:sponsors_list()
    )
    );
  }
}

AppBar _appBar(BuildContext context){
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.black.withOpacity(.5),
    title: GestureDetector(
      onTap: (){
      },
      child:Padding(
        padding: const EdgeInsets.only(left: 5.0,bottom: 10),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            'assets/images/back_button.png',
            width: 54.0,
            height: 54.0,
          ),
        ),),
    ),
    actions: [
      Padding(
          padding: EdgeInsets.only(bottom: 5,right: 20),
          child: Text("Sponsors",
            style: TextStyle(
                color: AppColors.Pink,
                fontFamily: 'Game_Tape',
                fontSize: 35),))
    ],);
}
