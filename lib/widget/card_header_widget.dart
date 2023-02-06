import 'package:flutter/material.dart';
import 'package:globesisters/util/appData.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../util/appTheme.dart';

class CardHeaderWidget extends StatelessWidget {
  const CardHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime d = DateTime.now().toUtc();
    DateTime dd = DateTime.parse("2023-01-01");
    Duration ago = d.difference(dd);
    final timeAgo = DateTime.now().subtract(ago);

    var name = AppData.name;

    return Container(
      padding: const EdgeInsets.only(left: 10, top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RichText(
              text: TextSpan(
            style: const TextStyle(
              fontSize: 16.0,
            ),
            children: [
              TextSpan(
                  text: (name.length > 30 ? name.substring(0, 30) : name),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.charcole,
                    fontSize: 14.0,
                  )),
            ],
          )),
          const Text("New Zealand",
              textScaleFactor: 1.0,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppTheme.charcole,
                fontSize: 12.0,
              )),
          Row(
            children: [
              Text(timeago.format(timeAgo).replaceAll("about an", "a"),
                  textScaleFactor: 1.0,
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: AppTheme.charcole,
                    fontSize: 12.0,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
