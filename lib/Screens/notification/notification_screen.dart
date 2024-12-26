import 'package:alcheringa/Notification/notification_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Model/notification_model.dart';
import '../../Model/view_model_main.dart';
import '../../utils/styles/colors.dart';

class notification_screen extends StatefulWidget {
  const notification_screen({super.key});

  @override
  State<notification_screen> createState() => _notification_screenState();
}

class _notification_screenState extends State<notification_screen> {
  @override
  Widget build(BuildContext context) {
    List<NotificationModel> list = Provider.of<ViewModelMain>(context).allNotification;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _appBar(context),
      body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,)
        ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                NotificationList(),
                Positioned(
                  bottom: 0,
                  child: Container(
                      height: MediaQuery.of(context).size.height*.09,
                      width: MediaQuery.of(context).size.width,
                      color:Colors.black.withOpacity(0.5),
                      child: Container(
                          height: 54,
                          width: 54,
                          child: Image.asset("assets/images/down_icon.png",)),
                    ),),
                Positioned(
                    left: MediaQuery.of(context).size.width*.40 ,
                    bottom: MediaQuery.of(context).size.height*.055,
                    child: _shadedText()
                ),
              ],
            ),
          ),
        ),
    );
  }
}

AppBar _appBar(BuildContext context){
  return AppBar(
    backgroundColor: Colors.black.withOpacity(.5),
    title: GestureDetector(
      onTap: (){
      },
      child:Padding(
        padding: const EdgeInsets.only(left: 5.0,bottom: 10),
        child: Image.asset(
          'assets/images/back_button.png',
          width: 54.0,
          height: 54.0,
        ),),
    ),
    actions: [
      Padding(
          padding: EdgeInsets.only(bottom: 5,right: 5),
          child: Text("Notification",
            style: TextStyle(
                color: AppColors.Pink,
                fontFamily: 'AlcherPixel',
                fontSize: 35),))
    ],);
}

ShaderMask _shadedText(){
  return ShaderMask(
    shaderCallback: (bounds) {
      return LinearGradient(
        colors: [AppColors.Palewhite,AppColors.Blue],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(
        Rect.fromLTWH(0, 8, bounds.width, bounds.height),
      );
    },
    child: Text('MORE',
        style: TextStyle(
        fontSize: 35,
        fontFamily: "AlcherPixel",
        color: AppColors.Palewhite,
          fontWeight: FontWeight.w800
      ),
    ),
  );
}
