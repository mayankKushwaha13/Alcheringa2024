import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeScreenContainerWidget extends StatelessWidget {
  const HomeScreenContainerWidget(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.imgurl,
      required this.onTap,
      });
  final String title;
  final String subtitle;
  final String imgurl;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Ink(
        width: 240,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Colors.purple,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: InkWell(
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imgurl == ""
                    ? Container(
                        height: 200,
                        decoration: BoxDecoration(color: Colors.grey),
                      )
                    : Container(
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(imgurl),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(6),
                                topRight: Radius.circular(6))),
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ),
                SizedBox()
              ],
            )),
      ),
    );
  }
}
