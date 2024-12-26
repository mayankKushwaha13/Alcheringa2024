import 'package:flutter/material.dart';
import '../Model/notification_model.dart';
import '../Model/view_model_main.dart';
import '../utils/styles/colors.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ViewModelMain().getAllNotifications(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasData) {
          List<NotificationModel> allNotifications = snapshot.data!;
          List<NotificationModel> newNotifications = allNotifications.take(3).toList();
          List<NotificationModel> earlierNotifications = allNotifications.skip(3).toList();

          return ListView(
            padding: EdgeInsets.only(top:110,left: 18,right: 18),
            children: [
              // Section for new notifications
              if (newNotifications.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "New",
                    style: TextStyle(
                      color: AppColors.Blue,
                      fontFamily: 'AlcherPixel',
                      fontSize: 28,
                    ),
                  ),
                ),
              ListView.builder(
                padding: EdgeInsets.only(top: 8),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: newNotifications.length,
                itemBuilder: (context, index) {
                  NotificationModel notification = newNotifications[index];
                  return NotificationTile(notification: notification);
                },
              ),

              // Section for earlier notifications
              if (earlierNotifications.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Earlier",
                    style: TextStyle(
                      color: AppColors.Blue,
                      fontFamily: 'AlcherPixel',
                      fontSize: 30,
                    ),
                  ),
                ),
              ListView.builder(
                padding: EdgeInsets.only(top: 8),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: earlierNotifications.length,
                itemBuilder: (context, index) {
                  NotificationModel notification = earlierNotifications[index];
                  return NotificationTile(notification: notification);
                },
              ),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

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
              fontFamily: 'AlcherPixel',
              fontSize: 25,
            ),
          ),
          Text(
            "${notification.body}",
            style: TextStyle(
              color: AppColors.Palewhite,
              fontFamily: 'AlcherPixel',
              fontSize: 20,
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
