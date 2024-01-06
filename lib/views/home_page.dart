import 'package:flutter/material.dart';
import 'package:loh_ecommerce_app/views/components/tab_chips_view.dart';
import 'package:loh_ecommerce_app/views/components/tab_content_view.dart';
import 'package:loh_ecommerce_app/views/view_model/app_view_model.dart';
import 'package:loh_ecommerce_app/views/view_model/base_view.dart';

import '../models/list_items.dart';
import 'filter_bottom_sheet_view.dart';

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
      if (tabIndex != null && tabIndex != current) {
        setState(() {
          current = tabIndex;
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
    return BaseView<AppViewModel>(
        onModelReady: (model) {},
        builder: (context, model, child) => Scaffold(
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
                        ).then((selectedFilter) {
                          if (selectedFilter != null) {
                            final String currentTab =
                                tabItems.keys.elementAt(current);
                            model.applyFilter(
                                selectedFilter, currentTab, tabItems);
                          }
                        });
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
                    TabChipsView(
                      tabController: _tabController!,
                      currentTab: current,
                      onTabSelected: (index) {
                        setState(() {
                          current = index;
                        });
                        _tabController?.animateTo(index);
                      },
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: tabItems.keys.map((tabName) {
                          return TabContentView(
                              tabName: tabName,
                              criteriaSelected: model.criteriaSelected,
                              filteredTabItems: model.filteredTabItems,
                          );
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
              floatingActionButton: Visibility(
                visible: model.criteriaSelected == true,
                child: FloatingActionButton(
                  elevation: 8,
                  onPressed: () {
                    model.clearFilter();
                  },
                  backgroundColor: Colors.blue,
                  child: const Text(
                    'Clear Filter',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
              ),
            ));
  }

}
