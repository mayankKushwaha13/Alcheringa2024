import 'package:flutter/material.dart';
import '../Model/notification_model.dart';
import '../utils/styles/colors.dart';



class NotificationTile extends StatelessWidget {
  final NotificationModel notification;

  const NotificationTile({required this.notification, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${notification.title}",
            style: TextStyle(
              color: AppColors.Pink,
              fontFamily: "Game_Tape",
              fontSize: 20,
            ),
          ),
          Text(
            "${notification.body}",
            style: TextStyle(
              color: AppColors.Palewhite,
              fontFamily: "Game_Tape",
              fontSize: 18,
            ),
          ),
          const Divider(
            color: AppColors.Grey,
            thickness: 2,
          ),
        ],
      ),
    );
  }
}
