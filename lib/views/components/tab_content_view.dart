import 'package:flutter/material.dart';

import '../../models/list_item.dart';
import '../../models/list_items.dart';

class TabContentView extends StatelessWidget {
  final String tabName;
  final bool criteriaSelected;
  final Map<String, List<ListItem>> filteredTabItems;

  const TabContentView({
    Key? key,
    required this.tabName,
    required this.criteriaSelected,
    required this.filteredTabItems,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<ListItem> itemsToShow = criteriaSelected && filteredTabItems.containsKey(tabName)
        ? filteredTabItems[tabName]!
        : tabItems[tabName] ?? [];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: itemsToShow.length,
      itemBuilder: (context, index) {
        final item = itemsToShow[index];
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
