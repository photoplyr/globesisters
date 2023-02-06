import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:globesisters/util/appTheme.dart';

class PostMessage extends StatelessWidget {
  String header;
  String message;

  PostMessage(this.header, this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return  MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Container(
            margin: const EdgeInsets.only(left: 15, top: 5, bottom: 0, right: 15),
            width: MediaQuery.of(context).size.width - 25,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Text(header, textScaleFactor: 1.0, style: const TextStyle(color: AppTheme.charcole, fontSize: 16, fontWeight: FontWeight.bold)),
              ExpandableNotifier(
                  // <-- Provides ExpandableController to its children
                  child: Column(children: [
                Expandable(
                  // <-- Driven by ExpandableController from ExpandableNotifier
                  collapsed: ExpandableButton(
                    // <-- Expands when tapped on the cover photo
                    child: Text(
                      message,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(color: AppTheme.charcole, fontSize: 14),
                    ),
                  ),
                  expanded: Column(children: [
                    ExpandableButton(
                        child: Linkify(
                      onOpen: (link) {},
                      text: message,
                      maxLines: 100,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppTheme.charcole, fontSize: 14),
                    )),
                  ]),
                ),
              ]))
            ])));
  }
}
