import 'package:flutter/material.dart';
import 'package:loh_ecommerce_app/models/list_item.dart';

import '../models/list_items.dart';
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
                children: tabItems.keys.map((tabName) {
                  return _buildTabContent(tabName);
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTabContent(String tabName) {

    List<ListItem> items = tabItems[tabName] ?? [];

    return GridView.builder(
      gridDelegate:
      const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black45,
            title: Text(item.title),
          ),
          child: Image.asset(
            item.imagePath,
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

}
