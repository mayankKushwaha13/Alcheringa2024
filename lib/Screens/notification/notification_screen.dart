import 'package:alcheringa/Notification/notification_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Model/notification_model.dart';
import '../../Model/view_model_main.dart';
import '../../utils/styles/colors.dart';

class NotificationScreen extends StatefulWidget {
  final Future<List<NotificationModel>> notificationsFuture;

  NotificationScreen({super.key})
      : notificationsFuture = ViewModelMain().getAllNotifications();

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool _isAtBottom = false;

  @override
  Widget build(BuildContext context) {
    // List<NotificationModel> notifications = Provider.of<ViewModelMain>(context).allNotification;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            final maxScroll = scrollNotification.metrics.maxScrollExtent;
            final currentScroll = scrollNotification.metrics.pixels;

            // Update `_isAtBottom` based on whether the user is at the bottom or not
            if (currentScroll >= maxScroll) {
              if (!_isAtBottom) {
                setState(() {
                  _isAtBottom = true;
                });
              }
            } else if (currentScroll < maxScroll) {
              if (_isAtBottom) {
                setState(() {
                  _isAtBottom = false;
                });
              }
            }
            return true;
          },
          child: Column(
            children: [
              Expanded(
                  child: FutureBuilder(
                future: widget.notificationsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasData) {
                    List<NotificationModel> allNotifications = snapshot.data!;
                    List<NotificationModel> newNotifications =
                        allNotifications.take(3).toList();
                    List<NotificationModel> earlierNotifications =
                        allNotifications.skip(3).toList();

                    return ListView(
                      padding:
                          const EdgeInsets.only(top: 110, left: 18, right: 18),
                      children: [
                        // Section for new notifications
                        if (newNotifications.isNotEmpty)
                          const Padding(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              "New",
                              style: TextStyle(
                                color: AppColors.Blue,
                                fontFamily: "Game_Tape",
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ListView.builder(
                          padding: const EdgeInsets.only(top: 5),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: newNotifications.length,
                          itemBuilder: (context, index) {
                            NotificationModel notification =
                                newNotifications[index];
                            return Column(
                              children: [
                                NotificationTile(notification: notification),
                                //to be removed later
                                NotificationTile(notification: notification),
                                NotificationTile(notification: notification),
                              ],
                            );
                          },
                        ),

                        // Section for earlier notifications
                        if (earlierNotifications.isNotEmpty)
                          const Padding(
                            padding: EdgeInsets.only(top: 15),
                            child: Text(
                              "Earlier",
                              style: TextStyle(
                                color: AppColors.Blue,
                                fontFamily: "Game_Tape",
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ListView.builder(
                          padding: const EdgeInsets.only(top: 5),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: earlierNotifications.length,
                          itemBuilder: (context, index) {
                            NotificationModel notification =
                                earlierNotifications[index];
                            return NotificationTile(notification: notification);
                          },
                        ),
                        SizedBox(height: 50,)
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text("No notifications found."),
                    );
                  }
                },
              )),
               _buildMoreSection(context),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.black.withOpacity(0.5),
      title: Padding(
        padding: const EdgeInsets.only(left: 5.0, bottom: 10),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            'assets/images/back_button.png',
            width: 54.0,
            height: 54.0,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5, right: 20),
          child: Text(
            "Notification",
            style: TextStyle(
              color: AppColors.Pink,
              fontFamily: "Game_Tape",
              fontSize: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMoreSection(BuildContext context) {
    return Column(
      children: [
       if (!_isAtBottom) _buildShadedText(),
        Container(
          height: MediaQuery.of(context).size.height * 0.09,
          width: double.infinity,
          color: Colors.black.withOpacity(0.5),
          child: !_isAtBottom?Center(
            child: Image.asset(
              "assets/images/down_icon.png",
              height: 54,
              width: 54,
            ),
          ):SizedBox(),
        ),
      ],
    );
  }

  ShaderMask _buildShadedText() {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: [AppColors.Palewhite, AppColors.Blue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(
          Rect.fromLTWH(0, 8, bounds.width, bounds.height),
        );
      },
      child: Text(
        'MORE',
        style: TextStyle(
          shadows: [
            Shadow(
              offset: Offset(2.5, 2),
              color: Colors.black,
              blurRadius: 2,
            ),
          ],
          fontSize: 32,
          fontFamily: "Game_Tape",
          color: AppColors.Palewhite,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
