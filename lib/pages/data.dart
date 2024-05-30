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
}

class CartItem {
  final String imgPath;
  final String name;
  final double price;
  final String description;
  late double amount;

  CartItem(this.imgPath, this.name, this.price, this.description, this.amount);

  static List<CartItem> cartList = [];

  // Function to fetch cart data from Firebase
  static Future<void> fetchCartData(String collect) async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection(collect).get();

      if (querySnapshot.size > 0) {
        for (QueryDocumentSnapshot document in querySnapshot.docs) {
          String imgPath = document['imgPath'];
          String name = document['name'];
          double price;
          if (document['price'] is int) {
            price = (document['price'] as int).toDouble();
          } else {
            price = document['price'];
          }
          String description = document['description'];
          double amount;
          if (document['amount'] is int) {
            amount = (document['amount'] as int).toDouble();
          } else {
            amount = document['amount'];
          }

          CartItem item = CartItem(imgPath, name, price, description, amount);

          cartList.add(item);
        }
      } else {
        print('No documents found in Firestore');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }

    for (var item in CartItem.cartList) {
      print(item.name);
    }
  }

  // Function to add item to Firebase's poodak_cart collection
  static Future<void> addItemToPoodakCart({
    required String imgPath,
    required String name,
    required double price,
    required String description,
    required double amount,
  }) async {
    CollectionReference poodakCart =
        FirebaseFirestore.instance.collection('poodak_cart');

    try {
      QuerySnapshot querySnapshot =
          await poodakCart.where('name', isEqualTo: name).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs.first.reference;
        await docRef.update({
          'amount': FieldValue.increment(amount),
        });
        print("Item amount incremented");
      } else {
        await poodakCart.add({
          'imgPath': imgPath,
          'name': name,
          'price': price,
          'description': description,
          'amount': amount,
        });
        print("Item Added");
      }
    } catch (error) {
      print("Failed to add item: $error");
    }
  }

  // Function to update item amount in Firebase's poodak_cart collection
  static Future<void> updateItemAmount(String name, double increment) async {
    CollectionReference poodakCart =
        FirebaseFirestore.instance.collection('poodak_cart');

    try {
      QuerySnapshot querySnapshot =
          await poodakCart.where('name', isEqualTo: name).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs.first.reference;
        double currentAmount = querySnapshot.docs.first['amount'];

        if (currentAmount + increment < 1) {
          await docRef.delete();
          print("Item removed from cart");
        } else {
          await docRef.update({
            'amount': FieldValue.increment(increment),
          });
          print("Item amount updated");
        }
      }
    } catch (error) {
      print("Failed to update item amount: $error");
    }
  }

  // Function to remove item from Firebase's poodak_cart collection
  static Future<void> removeItemFromCart(String name) async {
    CollectionReference poodakCart =
        FirebaseFirestore.instance.collection('poodak_cart');

    try {
      QuerySnapshot querySnapshot =
          await poodakCart.where('name', isEqualTo: name).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs.first.reference;
        await docRef.delete();
        print("Item removed from cart");
      }
    } catch (error) {
      print("Failed to remove item from cart: $error");
    }
  }

  static Future<void> saveCartDataToHistory(double totalPrice) async {
    // Retrieve cart data and save it to cart_history collection
    // For example, you can use a transaction to ensure atomicity
    try {
      // Begin Firestore transaction
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        // Get a reference to the cart_history document
        DocumentReference historyRef =
            FirebaseFirestore.instance.collection('poodak_cart_history').doc();

        // Save cart data to history document
        Map<String, dynamic> data = {
          'timestamp': Timestamp.now(),
          'total_price': totalPrice,
          'cart_items': cartList.map((item) => item.toMap()).toList(),
        };
        transaction.set(historyRef, data);
      });
    } catch (e) {
      // Handle error
      print("Error saving cart data to history: $e");
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'amount': amount,
      'imgPath': imgPath,
      'description': description,
    };
  }

  static Future<void> clearCartDataInFirebase() async {
    // Clear cart data in Firebase
    // For example, you might delete all documents in the cart collection
    try {
      // Run batch operation to delete all documents in cart collection
      WriteBatch batch = FirebaseFirestore.instance.batch();
      QuerySnapshot cartSnapshot =
          await FirebaseFirestore.instance.collection('poodak_cart').get();
      cartSnapshot.docs.forEach((doc) {
        batch.delete(doc.reference);
      });
      await batch.commit();
    } catch (e) {
      // Handle error
      print("Error clearing cart data in Firebase: $e");
    }
  }
}

class HistoryItem {
  final Timestamp timestamp;
  final double totalPrice;
  final List<CartItem> cartItem;

  HistoryItem(this.timestamp, this.totalPrice, this.cartItem);

  static List<HistoryItem> historyList = [];

  static Future<void> fetchHistoryData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(
              "poodak_cart_history") // Replace with your Firestore collection name
          .get();

      if (querySnapshot.size > 0) {
        for (QueryDocumentSnapshot document in querySnapshot.docs) {
          // Access data fields and create ShopItem objects
          Timestamp timestamp = document['timestamp'];
          double totalPrice;
          if (document['total_price'] is int) {
            totalPrice = (document['total_price'] as int).toDouble();
          } else {
            totalPrice = document['total_price'];
          }
          List<dynamic> cartItemsData = document['cart_items'];

          List<CartItem> cartItems = cartItemsData.map((data) {
            // Convert each item in the list to a CartItem object
            return CartItem(
              data['imgPath'],
              data['name'],
              data['price'],
              data['description'],
              data['amount'],
            );
          }).toList();

          // Create a new ShopItem and add it to the respective list
          HistoryItem item = HistoryItem(timestamp, totalPrice, cartItems);

          // Determine the category and add the item to the appropriate list
          historyList.add(item);
        }
      } else {
        print('No documents found in Firestore');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }

    // Testing data fetch
    for (var item in historyList) {
      for (var cart in item.cartItem) {
        print(cart.name);
      }
    }
  }
}


// ==============================================
class CartItemUSS {
  final String name;
  final double price;
  final String description;
  late double amount; 

  CartItemUSS(this.name, this.price, this.description, this.amount);

  static List<CartItemUSS> cartList = [];

  static Future<void> fetchCartData(String collect) async {
    try {
      // For taking data from database
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(collect).get();
    
      if (querySnapshot.size > 0) {
        for (QueryDocumentSnapshot document in querySnapshot.docs) {
          String name = document['name'];
          double price;
          if (document['price'] is int) {
            price = (document['price'] as int).toDouble();
          } else {
            price = document['price'];
          }
          String description = document['description'];
          double amount;
          if (document['amount'] is int) {
            amount = (document['amount'] as int).toDouble();
          } else {
            amount = document['amount'];
          }

          CartItemUSS item = CartItemUSS(name, price, description, amount);
        
          cartList.add(item);
        }
      } else {
        print("No document found");
      }
    } catch (e) {
      print('Error fetching data: $e');
    }

    for (var item in CartItemUSS.cartList) {
      print(item.name);
    }    
  }

  
  static Future<void> addItemToCart({
    required String name,
    required double price,
    required String description,
    required double amount,
  }) async {
    CollectionReference ussCart = FirebaseFirestore.instance.collection('uss_cart');
  
    try {
      QuerySnapshot querySnapshot = await ussCart.where('name', isEqualTo: name).get();
      if (querySnapshot.docs.isNotEmpty) {
          DocumentReference docRef = querySnapshot.docs.first.reference;
          await docRef.update({
            'amount': FieldValue.increment(amount),
          });
          print("Item amount incremented");
        } else {
          await ussCart.add({
            'name': name,
            'price': price,
            'description': description,
            'amount': amount,
          });
          print("Item Added");
        }
      } catch (error) {
        print("Failed to add item: $error");
      }
    }

  static Future<void> updateItemAmount(String name, double increment) async {
    CollectionReference ussCart =
        FirebaseFirestore.instance.collection('uss_cart');

    try {
      QuerySnapshot querySnapshot =
          await ussCart.where('name', isEqualTo: name).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs.first.reference;
        double currentAmount = querySnapshot.docs.first['amount'];

        if (currentAmount + increment < 1) {
          await docRef.delete();
          print("Item removed from cart");
        } else {
          await docRef.update({
            'amount': FieldValue.increment(increment),
          });
          print("Item amount updated");
        }
      }
    } catch (error) {
      print("Failed to update item amount: $error");
    }
  }

  static Future<void> removeItemFromCart(String name) async {
    CollectionReference ussCart = FirebaseFirestore.instance.collection('uss_cart');

    try {
      QuerySnapshot querySnapshot =
          await ussCart.where('name', isEqualTo: name).get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs.first.reference;
        await docRef.delete();
        print("Item removed from cart");
      }
    } catch (error) {
      print("Failed to remove item from cart: $error");
    }
  }

  static Future<void> saveCartDataToHistory(double totalPrice) async {
    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {

        DocumentReference historyRef =
            FirebaseFirestore.instance.collection('uss_cart_history').doc();

        Map<String, dynamic> data = {
          'timestamp': Timestamp.now(),
          'total_price': totalPrice,
          'cart_items': cartList.map((item) => item.toMap()).toList(),
        };
        transaction.set(historyRef, data);
      });
    } catch (e) {
      // Handle error
      print("Error saving cart data to history: $e");
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'amount': amount,
      'description': description,
    };
  }

  static Future<void> clearCartDataInFirebase() async {
      try {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      QuerySnapshot cartSnapshot =
          await FirebaseFirestore.instance.collection('uss_cart').get();
      cartSnapshot.docs.forEach((doc) {
        batch.delete(doc.reference);
      });
      await batch.commit();
    } catch (e) {
      print("Error clearing cart data in Firebase: $e");
    }
  }
}


class HistoryItemUSS {
  final Timestamp timestamp;
  final double totalPrice;
  final List<CartItemUSS> cartItem;

  HistoryItemUSS(this.timestamp, this.totalPrice, this.cartItem);

  static List<HistoryItemUSS> historyList = [];

  static Future<void> fetchHistoryData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(
              "uss_cart_history")
          .get();

      if (querySnapshot.size > 0) {
        for (QueryDocumentSnapshot document in querySnapshot.docs) {
          Timestamp timestamp = document['timestamp'];
          double totalPrice;
          if (document['total_price'] is int) {
            totalPrice = (document['total_price'] as int).toDouble();
          } else {
            totalPrice = document['total_price'];
          }
          List<dynamic> cartItemsData = document['cart_items'];

          List<CartItemUSS> cartItems = cartItemsData.map((data) {
            return CartItemUSS(
              data['name'],
              data['price'],
              data['description'],
              data['amount'],
            );
          }).toList();

          // Create a new ShopItem and add it to the respective list
          HistoryItemUSS item = HistoryItemUSS(timestamp, totalPrice, cartItems);

          // Determine the category and add the item to the appropriate list
          historyList.add(item);
        }
      } else {
        print('No documents found in Firestore');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }

    // Testing data fetch
    for (var item in historyList) {
      for (var cart in item.cartItem) {
        print(cart.name);
      }
    }
  }
}
