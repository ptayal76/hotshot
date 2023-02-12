import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Search for restaurants...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
                alignLabelWithHint: false,

              ),
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search,size: 30),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.filter_alt_outlined,size: 30),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
