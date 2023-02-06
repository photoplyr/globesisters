import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:globesisters/util/appData.dart';
import 'package:globesisters/util/appTheme.dart';
import 'package:globesisters/widget/avatar_widget.dart';
import 'package:globesisters/widget/post_message_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin {
  @override
  initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width,
          height: 300,
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: AppData.backgroundImage,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.fill,
              ),
              Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 170.0),
                child: Avatar(AppData.avatar, 60),
              )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Text(AppData.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.charcole,
                            fontSize: 20.0,
                          )),
                      const Text("Software Developer",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: AppTheme.charcole,
                            fontSize: 15.0,
                          )),
                    ],
                  ),
                  TextButton(
                    style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                        backgroundColor: MaterialStateProperty.all<Color>(AppTheme.selectButton),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0), side: const BorderSide(color: AppTheme.selectButton)))),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 15.0, right: 15.0),
                      child: Text('Follow', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.normal)),
                    ),
                    onPressed: () async {},
                  ),
                ],
              ),
              _greyDivider(),
              PostMessage("", AppData.bio),
              _greyDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _stats(200, "Followers"),
                  _stats(934, "Following"),
                  _stats(37, "Trips"),
                ],
              ),
              _greyDivider(),
              SizedBox(
                width: width,
                height: height - 632,
                child: MasonryGridView.count(
                  padding: const EdgeInsets.all(0),
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 8,
                  crossAxisCount: 2,
                  itemCount: AppData.getPhotos().length,
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: AppData.getPhotos()[index],
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                      fit: BoxFit.cover,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _stats(int number, String name) {
    return Column(
      children: [
        Text(number.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
      ],
    );
  }

  Widget _greyDivider() {
    return const Padding(
      padding: EdgeInsets.all(5),
      child: Divider(color: AppTheme.greyCardBackground),
    );
  }
}
