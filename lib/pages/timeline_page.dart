import 'dart:math';

import 'package:flutter/material.dart';
import 'package:globesisters/util/appData.dart';
import 'package:globesisters/widget/post_header_widget.dart';
import 'package:globesisters/widget/post_message_widget.dart';
import 'package:globesisters/widget/post_photo_widget.dart';
import 'package:globesisters/widget/support_banner_widget.dart';

import '../util/appTheme.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TimelinePageState createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> with TickerProviderStateMixin {
  int currentPage = 0;
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final int _rows = 25;
  Random randpmPic =  Random(10);

  @override
  initState() {
    super.initState();
    // dataInit();
    _tabController = TabController(vsync: this, length: 3);
  }


  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: AppTheme.greyBackground,
            body: Column(children: <Widget>[
              Expanded(
                  child: ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: _rows,
                      itemBuilder: (context, index) {
                        return _timelineCardWidget(width, height);
                      })),
            ])));
  }

  Widget _timelineCardWidget(width, height) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 1,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              PostHeader(AppData.avatar),
              PostMessage(AppData.header, AppData.message),
              _greyDivider(),
              PostPhoto(width, height, [AppData.getRandomPhoto(randpmPic.nextInt(AppData.getPhotos().length))]),
              SupportBannerWidget(width, height)
            ]),
      ),
    );
  }

  Widget _greyDivider() {
    return const Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10),
      child: Divider(color: AppTheme.dividerGrey),
    );
  }
}
