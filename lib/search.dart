import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/pages/detail/detail_screen.dart';
import 'package:sdurian/utils/constants/colors.dart';

class SearchBarA extends StatefulWidget {
  final String email;
  const SearchBarA({Key? key, required this.email}) : super(key: key);

  @override
  State<SearchBarA> createState() => _SearchBarAState();
}

class _SearchBarAState extends State<SearchBarA> {
  List<List<ShopItem>> shopItems = ShopItem.combinedList;
  List<ShopItem> displayList = [];
  List<ShopItem> originalList = [];

  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 2,
  );

  @override
  void initState() {
    super.initState();
    // Flatten the nested shopItems list and initialize the displayList and originalList.
    displayList.addAll(shopItems.expand((list) => list));
    originalList.addAll(displayList);
  }

  void updateList(String value) {
    setState(() {
      if (value.isEmpty) {
        // If the search query is empty, revert to the original list.
        displayList.clear();
        displayList.addAll(originalList);
      } else {
        // Filter based on the search query.
        displayList = originalList
            .where(
              (item) => item.name.toLowerCase().contains(value.toLowerCase()),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: TColors.primary,
        elevation: 0,
        titleSpacing: 0.0,
        title: Container(
          width: double.infinity,
          padding: const EdgeInsets.only(
              left: 10.0, right: 30), 
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(10.0),
            child: TextField(
              onChanged: (value) => updateList(value),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
                hintText: "Search...",
                hintStyle: TextStyle(fontSize: 16),
                prefixIcon: Icon(
                  Iconsax.search_normal,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
        shadowColor: Colors.black.withOpacity(0.8),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: displayList.length,
                itemBuilder: (context, index) {
                  final item = displayList[index];
                  return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.white,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                        imgPath: item.imgPath,
                                        name: item.name,
                                        price: item.price,
                                        description: item.description,
                                        email: widget.email,
                                      )));
                        },
                        child: ListTile(
                          contentPadding: EdgeInsets.all(8),
                          title: Text(item.name),
                          subtitle: Text(currencyFormatter.format(item.price)),
                          leading: Image.asset(
                            item.imgPath,
                          ),
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
