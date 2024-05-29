import 'package:cloud_firestore/cloud_firestore.dart';

class ShopItem {
  final String imgPath;
  final String name;
  final double price;
  final String description;

  ShopItem(this.imgPath, this.name, this.price, this.description);

  static List<ShopItem> shopItemsPaket = [];
  static List<ShopItem> shopItemsSiomay = [];
  static List<ShopItem> shopItemsDessert = [];
  static List<ShopItem> shopItemsDooren = [];
  static List<ShopItem> shopItemsRekomendasi = [];
  static List<List<ShopItem>> combinedList = [
    shopItemsDessert,
    shopItemsDooren,
    shopItemsPaket,
    shopItemsSiomay,
  ];

  static Future<void> fetchData(String collect) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(collect) // Replace with your Firestore collection name
          .get();

      if (querySnapshot.size > 0) {
        for (QueryDocumentSnapshot document in querySnapshot.docs) {
          // Access data fields and create ShopItem objects
          String imgPath = document['imgPath'];
          String name = document['name'];
          double price;
          if (document['price'] is int) {
            price = (document['price'] as int).toDouble();
          } else {
            price = document['price'];
          }
          String description = document['description'];
          String category = document['category'];

          // Create a new ShopItem and add it to the respective list
          ShopItem item = ShopItem(imgPath, name, price, description);

          // Determine the category and add the item to the appropriate list
          if (category == 'paket') {
            shopItemsPaket.add(item);
          } else if (category == 'siomay') {
            shopItemsSiomay.add(item);
          } else if (category == 'dessert') {
            shopItemsDessert.add(item);
          } else if (category == 'dooren') {
            shopItemsDooren.add(item);
          } else if (category == 'rekomendasi') {
            shopItemsRekomendasi.add(item);
          }
        }
      } else {
        print('No documents found in Firestore');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }

    // Testing data fetch
    // for (var item in ShopItem.shopItemsPaket) {
    //   print(item.name);
    // }
  }
  static Future<void> replaceBackslashInField(String collectionName, String fieldName) async {
  // Reference to the Firestore collection
  CollectionReference collectionRef = FirebaseFirestore.instance.collection(collectionName);

  // Fetch all documents in the collection
  QuerySnapshot querySnapshot = await collectionRef.get();

  // Iterate through each document
  for (QueryDocumentSnapshot document in querySnapshot.docs) {
    // Get the current field value
    String fieldValue = document[fieldName];

    // Replace backslashes with forward slashes
    String updatedFieldValue = fieldValue.replaceAll('\\', '/');

    // Update the field in Firestore
    await document.reference.update({fieldName: updatedFieldValue});
  }

  print('Field values updated successfully');
}

}
