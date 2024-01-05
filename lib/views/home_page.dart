import 'package:flutter/material.dart';

import '../utils/resources/app_images.dart';
import 'chip_item.dart';
import 'filter_view.dart';

class AppHomePage extends StatefulWidget {
  const AppHomePage({super.key});

  @override
  State<AppHomePage> createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  bool hasFocus = false;
  int current = 0;

  Map<String, List<String>> tabItems = {
    "All": ["Item 1", "Item 2", "Item 3"],
    "shoes": ["Shoe 1", "Shoe 2", "Shoe 3"],
    "Belts": ["Belt 1", "Belt 2", "Belt 3"],
    "Gloves": ["Glove 1", "Glove 2", "Glove 3"],
    "Hats": ["Hat 1", "Hat 2", "Hat 3"],
    "Jewellery": ["Jewelry 1", "Jewelry 2", "Jewelry 3"],
    "shirts": ["Shirt 1", "Shirt 2", "Shirt 3"],
    "Trousers": ["Trouser 1", "Trouser 2", "Trouser 3"],
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        initialIndex: 0, length: tabItems.keys.length, vsync: this);

    _tabController?.animation?.addListener(() {
      if (!mounted) return;
      final int? tabIndex = _tabController?.animation?.value.round();
      if (tabIndex != current) {
        setState(() {
          current = tabIndex!;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Icon cusIcon = const Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Text("Ecommerce App"),
            ),
            const Spacer(),
            const Icon(Icons.search),
            const SizedBox(
              width: 10,
            ),
            const Divider(),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const FilterBottomSheet();
                  },
                );
              },
              child: const Icon(Icons.filter_list),
            )
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 60,
              width: double.infinity,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: tabItems.keys.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (ctx, index) {
                  return ChipItem(
                    title: tabItems.keys.elementAt(index),
                    hasFocus: hasFocus,
                    current: current,
                    index: index,
                    onTap: () {
                    setState(() {
                      current = index;
                    });
                    _tabController?.animateTo(index);
                  },  );
                },
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: tabItems.keys.map((item) {
                  if (item == "shoes") {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        String imageUrl = AppImage.shoeOne;

                        return GridTile(
                          footer: const GridTileBar(
                            backgroundColor: Colors.black45,
                          ),
                          child: Image.asset(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  } else {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 4.0,
                      ),
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        String itemImageUrl;

                        switch (item) {
                          case "Belts":
                            itemImageUrl = AppImage.belt;
                            break;
                          case "Gloves":
                            itemImageUrl = AppImage.gloves;
                            break;
                          default:
                            itemImageUrl = AppImage.shoeTen;
                        }
                        return GridTile(
                          footer: const GridTileBar(
                            backgroundColor: Colors.black45,
                            title: Text("Title"),
                          ),
                          child: Image.asset(
                            itemImageUrl,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  }
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
