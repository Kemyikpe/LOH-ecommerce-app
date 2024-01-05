import 'package:flutter/material.dart';
import 'package:loh_ecommerce_app/utils/resources/app_images.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  bool hasFocus = false;

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

  int current = 0;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(initialIndex: 0, length: tabItems.keys.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Icon cusIcon=const Icon(Icons.search);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:  Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Text("Ecommerce App"),
            ),
            const Spacer(),
            const Icon(Icons.search),

            const SizedBox(width: 10,),
            const Divider(),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return const MoreOptionsBottomSheet();
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
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        current = index;
                      });
                      _tabController?.animateTo(index);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.all(10),
                      width: 80,
                      height: 45,
                      decoration: BoxDecoration(
                        color: hasFocus ? Colors.yellow : Colors.white,
                        border: Border.all(
                          color: current == index ? Colors.blue : Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          tabItems.keys.elementAt(index),
                          style: TextStyle(
                            color: current == index ? Colors.blue : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: tabItems.keys.map((item) {
                  if (item == "shoes") {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
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
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
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
                          case "Hats":
                            itemImageUrl = AppImage.hat;
                            break;
                          case "Jewellery":
                            itemImageUrl = AppImage.jewellery;
                            break;
                          case "Shirt":
                            itemImageUrl = AppImage.shirt;
                            break;
                          case "Trouser":
                            itemImageUrl = AppImage.trouser;
                            break;
                          default:
                            itemImageUrl = '';
                        }
                        return GridTile(
                          footer: const GridTileBar(
                            backgroundColor: Colors.black45,
                            title: Text(""),
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

class MoreOptionsBottomSheet extends StatelessWidget {
  const MoreOptionsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      decoration: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
      ),
      child: Column (
        children: [
         const SizedBox(height: 12.0,) ,
          Container(
            width: 50,
            height: 5,
            decoration: ShapeDecoration(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
          const SizedBox(height: 1.0,),
          const Text(
            'Sort by',
            style: TextStyle(
              color:Colors.black,
              fontSize: 20,
              fontFamily: 'Circular Std',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 29.0,),
           MoreOptionsItem(
            title: "Popular",
               onTap: (){
                 Navigator.pop(context);
               }
          ),
             MoreOptionsItem(
            title: "Newest",
                 onTap: (){
                   Navigator.pop(context);
                 }
          ),
            MoreOptionsItem(
            title: "Customer review",
                onTap: (){
                  Navigator.pop(context);
                }
           ),
         MoreOptionsItem(
            title: "Price lowest to high",
             onTap: (){
               Navigator.pop(context);
             }
            ),
           MoreOptionsItem(
            title: "Price highest to low",
             onTap: (){
               Navigator.pop(context);
             }


          ),
        ],
      ),
    );
  }
}


class MoreOptionsItem extends StatefulWidget {
  const MoreOptionsItem({
    Key? key,
    this.textColor,
    this.focusColor,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final String title;
  final Color? textColor;
  final Color? focusColor;
  final Function() onTap;

  @override
  _MoreOptionsItemState createState() => _MoreOptionsItemState();
}

class _MoreOptionsItemState extends State<MoreOptionsItem> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isFocused = !isFocused;
        });
        widget.onTap();
      },
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      color: isFocused
                          ? widget.focusColor ?? Colors.red
                          : widget.textColor ?? Colors.black,
                      fontSize: 18,
                      fontFamily: 'Circular Std',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 3.0),
          ],
        ),
      ),
    );
  }
}




