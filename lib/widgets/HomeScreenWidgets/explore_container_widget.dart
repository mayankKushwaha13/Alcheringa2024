import 'package:flutter/material.dart';

class ExploreContainerWidget extends StatelessWidget {
  const ExploreContainerWidget(
      {super.key,
      required this.text,
      this.isMerchPage = false,
      required this.NavigatingPage,
      });
  final String text;
  final bool isMerchPage;
  final Widget NavigatingPage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Ink(
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.black),
        child: InkWell(
          onTap: () {

            if (isMerchPage) {
               
            } else {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => NavigatingPage));
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
