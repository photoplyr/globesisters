import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PostPhoto extends StatelessWidget {
  double width;
  double height;
  List photos;

  PostPhoto(this.width, this.height, this.photos, {super.key});

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        SizedBox(
          width: width,
          height: (height > 400 ? 400 : height),
          child: PageView(
              scrollDirection: Axis.horizontal,
              pageSnapping: true,
              children: List.generate(photos.length, (index) {
                return GestureDetector(
                    onTap: () async {
                      await showDialog(
                          context: context,
                          builder: (_) => Scaffold(
                              backgroundColor: Colors.black,
                              body: Stack(
                                children: [
                                  PhotoView(
                                    imageProvider: NetworkImage(photos[index]),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                      icon: const Icon(Icons.close, color: Colors.white),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              )));
                    },
                    child: Stack(children: [
                      SizedBox(
                        width: width,
                        height: 400,
                        child: CachedNetworkImage(
                          imageUrl: photos[index],
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                      if (photos.length > 1)
                        const Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.only(top: 20, right: 20),
                              child: Icon(
                                Icons.photo_album_rounded,
                                color: Colors.white,
                              ),
                            )),
                    ]));
              })),
        ),
      ],
    );
  }
}
