import 'package:flutter/material.dart';
import 'package:globesisters/pages/post_page.dart';
import 'package:globesisters/pages/profile_page.dart';
import 'package:globesisters/pages/timeline_page.dart';
import 'package:globesisters/util/appTheme.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with TickerProviderStateMixin {
  int currentPage = 0;
  late TabController _tabController;

  @override
  initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            const TimelinePage(),
            const PostPage(),
            const ProfilePage(),
          ],
        ),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title:
              const Text('GlobeSisters', textScaleFactor: 1.0, style: TextStyle(color: AppTheme.charcole, fontWeight: FontWeight.bold, fontSize: 20)),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_alert, color: AppTheme.pillBlue),
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ],
        ),
        bottomNavigationBar: Material(
          color: Colors.white,
          child: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            controller: _tabController,
            labelStyle: const TextStyle(fontSize: 10),
            tabs: const <Widget>[
              Tab(
                icon: Icon(Icons.home_outlined),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.create),
                text: "Post",
              ),
              Tab(
                icon: Icon(Icons.person_outline),
                text: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
