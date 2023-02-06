import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:globesisters/util/appTheme.dart';
class Avatar extends StatelessWidget {
  String  photo;
  double size;


  Avatar(this.photo, this.size,  {super.key});

  @override
  Widget build(BuildContext context) {
    return   Column(
      children: [
        CircleAvatar(
            minRadius: size,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppTheme.square5,
                    AppTheme.welcome2,
                  ],
                ),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CircleAvatar(
                    minRadius: size,
                    backgroundColor: AppTheme.white,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircleAvatar(
                        minRadius: size,
                        backgroundColor: AppTheme.selectButton,
                        backgroundImage: (CachedNetworkImageProvider(photo)),
                      ),
                    ),
                  )),
            )),
      ],
    );
  }
}
