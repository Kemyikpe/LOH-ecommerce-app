import 'package:flutter/material.dart';

import 'filter_item.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

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
            'Filter by',
            style: TextStyle(
              color:Colors.black,
              fontSize: 20,
              fontFamily: 'Circular Std',
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 29.0,),
          FilterItem(
              title: "Popular",
              onTap: (){
                Navigator.pop(context);
              }
          ),
          FilterItem(
              title: "Newest",
              onTap: (){
                Navigator.pop(context);
              }
          ),
          FilterItem(
              title: "Customer review",
              onTap: (){
                Navigator.pop(context);
              }
          ),
          FilterItem(
              title: "Price lowest to high",
              onTap: (){
                Navigator.pop(context);
              }
          ),
          FilterItem(
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