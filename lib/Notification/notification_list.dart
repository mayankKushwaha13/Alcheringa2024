import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/styles/colors.dart';
import 'notification_provider.dart';

class notificationlist extends StatelessWidget {
  const notificationlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
      builder: (context, provider, child) {
        final notifications = provider.notifications;
        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${notification.title}",style: TextStyle(color: AppColors.Pink,fontFamily: 'AlcherPixel',fontSize:25),),
                  Text("${notification.body}",style: TextStyle(color: AppColors.Palewhite,fontFamily: 'AlcherPixel',fontSize:20),),
                  const Divider(color: AppColors.Grey,thickness: 2,),
                ],),);
          },
        );
      },
    );
  }
}
