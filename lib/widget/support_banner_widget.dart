import 'package:flutter/material.dart';
import 'package:globesisters/util/appTheme.dart';

class SupportBannerWidget extends StatelessWidget {
  double width;
  double height;

  SupportBannerWidget(this.width, this.height, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width - 18,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: SizedBox(
                  height: 40,
                  width: 50,
                  child: IconButton(
                    color: AppTheme.white,
                    icon: Image.asset("assets/Icon_Chat.png"),
                    onPressed: () {},
                  ),
                ),
              ),
              // reationButton(repository, AppTheme.charcole),
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: SizedBox(
                  height: 38,
                  child: IconButton(
                    icon: Image.asset("assets/gif.png"),

                    //`Text` to display
                    onPressed: () async {},
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 40.0,
                  width: 60,
                  child: TextButton.icon(
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)))),
                    icon: const Icon(
                      Icons.chat_bubble,
                      color: AppTheme.pillBlue,
                      size: 15,
                    ),
                    label: const Text("3", textScaleFactor: 1.0, style: TextStyle(color: AppTheme.charcole, fontSize: 14)),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ], //
      ),
    );
  }
}
