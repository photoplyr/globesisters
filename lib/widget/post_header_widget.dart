import 'package:flutter/material.dart';
import 'package:globesisters/util/appTheme.dart';
import 'package:globesisters/widget/avatar_widget.dart';
import 'package:globesisters/widget/card_header_widget.dart';

class PostHeader extends StatelessWidget {
  String avatar;

  PostHeader(this.avatar, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 5),
              child: Avatar(avatar, 15),
            ),
          ],
        ),

        // HOA
        const CardHeaderWidget(),

        Expanded(child: Container()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              color: AppTheme.charcole,
              icon: const Icon(Icons.more_horiz),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
