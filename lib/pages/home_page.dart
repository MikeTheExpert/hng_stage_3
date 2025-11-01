import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hng_stage_3/design_widgets/list_view.dart';
import 'package:hng_stage_3/design_widgets/home_page_card.dart';
import 'package:hng_stage_3/design_widgets/nav_bar_widget.dart';

import '../models/helper_class.dart';
import '../models/wallpaper_model.dart';
import 'create_images.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final db = DatabaseHelper();
  List<Wallpaper> wallpapers = [];
  bool isGrid = true;

  @override
  void initState() {
    super.initState();
    _loadWallpapers();
  }

  Future<void> _loadWallpapers() async {
    final data = await db.getWallpapers();
    setState(() {
      wallpapers = data;
    });
  }

  void toggleDisplayView() {
    setState(() {
      isGrid != isGrid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: NavBar(),
      ),
      floatingActionButton: IconButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateWallpaperPage(),
            ),
          );
          if (result == true) {
            // Refresh your wallpapers list after insertion
            setState(() {});
          }
        },
        icon: Icon(Icons.add_outlined),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton.outlined(
                  onPressed: toggleDisplayView,
                  icon: isGrid ? SvgPicture.asset(
                    'assets/icons/gridView.svg',
                    width: 15,
                    height: 15,
                  ) : SvgPicture.asset(
                    'assets/icons/listView.svg',
                    width: 15,
                    height: 15,
                  ),
                ),
              ],
            ),
            wallpapers.isEmpty
                ? Center(child: Text('Nothing here'))
                : Expanded(
                  child:
                      isGrid
                          ? homepageCard(wallpapers, context)
                          : listView(wallpapers,),
                ),
          ],
        ),
      ),
    );
  }
}
