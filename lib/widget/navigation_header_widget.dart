import 'package:flutter/material.dart';
import 'package:globesisters/util/appTheme.dart';

class NavitationPostHeaderWidget extends StatelessWidget {
  bool showclose;
  bool showbutton;
  EdgeInsets insets;
  String title;
  final Function() notifyParent;

  NavitationPostHeaderWidget(this.showclose, this.title, this.notifyParent,this.showbutton,
      {this.insets = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
     if (title.length > 30) {
       this.title = this.title.substring(0,30);
     }
    
    double height = MediaQuery.of(context).size.height;
    return Container(
        color: Colors.white,
        height: height >= 640 ? 100 : 75,
        child: Column(children: <Widget>[
          Container(
            height: height >= 640 ? 55 : 40,
            margin: (insets != EdgeInsets.zero
                ? insets
                : EdgeInsets.fromLTRB(
                    14.0, height >= 640 ? 40.0 : 30, 5.0, 0.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                Text(title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.charcole,
                      fontSize: 15.0,
                    )),

                Padding(
                  padding: const EdgeInsets.only(right:15.0),
                  child: 
                  GestureDetector(
                    onTap: () { },
                  child:Text("Post",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:  ( (showbutton? AppTheme.selectButton: AppTheme.lightGrey)),
                        fontSize: 15.0,
                      )),
                )),

              ],
            ),
          ),
          const Divider(height: 5),
        ]));
  }
}
