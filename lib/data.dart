import 'dart:convert';
import 'package:crypto/crypto.dart';
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
  late String email;

  CartItem(this.imgPath, this.name, this.price, this.description, this.amount,
      this.email);

  static List<CartItem> cartList = [];

  // Function to fetch cart data from Firebase for a specific user
  static Future<void> fetchCartData(String email) async {
    print(email);
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('poodak_cart')
          .where('email', isEqualTo: email)
          .get();

      cartList.clear();
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

          CartItem item =
              CartItem(imgPath, name, price, description, amount, email);
          cartList.add(item);
        }
      } else {
        print('No documents found in Firestore for this user');
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
    required String email,
  }) async {
    CollectionReference poodakCart =
        FirebaseFirestore.instance.collection('poodak_cart');

    try {
      QuerySnapshot querySnapshot = await poodakCart
          .where('name', isEqualTo: name)
          .where('email', isEqualTo: email)
          .get();

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
          'email': email
        });
        print("Item Added");
      }
    } catch (error) {
      print("Failed to add item: $error");
    }
  }

  // Function to update item amount in Firebase's poodak_cart collection
  static Future<void> updateItemAmount(
      String name, double increment, String email) async {
    CollectionReference poodakCart =
        FirebaseFirestore.instance.collection('poodak_cart');

    try {
      QuerySnapshot querySnapshot = await poodakCart
          .where('name', isEqualTo: name)
          .where('email', isEqualTo: email)
          .get();

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
  static Future<void> removeItemFromCart(String name, String email) async {
    CollectionReference poodakCart =
        FirebaseFirestore.instance.collection('poodak_cart');

    try {
      QuerySnapshot querySnapshot = await poodakCart
          .where('name', isEqualTo: name)
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs.first.reference;
        await docRef.delete();
        print("Item removed from cart");
      }
    } catch (error) {
      print("Failed to remove item from cart: $error");
    }
  }

  static Future<void> saveCartDataToHistory(
      double totalPrice, String email) async {
    // Retrieve cart data and save it to cart_history collection
    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentReference historyRef =
            FirebaseFirestore.instance.collection('poodak_cart_history').doc();

        Map<String, dynamic> data = {
          'timestamp': Timestamp.now(),
          'total_price': totalPrice,
          'email': email,
          'cart_items': cartList.map((item) => item.toMap()).toList(),
        };
        transaction.set(historyRef, data);
      });
    } catch (e) {
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
      'email': email,
    };
  }

  static Future<void> clearCartDataInFirebase(String email) async {
    // Clear cart data in Firebase for a specific user
    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('poodak_cart')
          .where('email', isEqualTo: email)
          .get();

      cartSnapshot.docs.forEach((doc) {
        batch.delete(doc.reference);
      });
      await batch.commit();
    } catch (e) {
      print("Error clearing cart data in Firebase: $e");
    }
  }
}

class HistoryItem {
  final Timestamp timestamp;
  final double totalPrice;
  late String email;
  final List<CartItem> cartItem;

  HistoryItem(this.timestamp, this.totalPrice, this.email, this.cartItem);

  static List<HistoryItem> historyList = [];

  static Future<void> fetchHistoryData(String email) async {
    print(email);
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("poodak_cart_history")
          .where('email',
              isEqualTo: email) // Replace with your Firestore collection name
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
          String email = document['email'];
          List<dynamic> cartItemsData = document['cart_items'];

          List<CartItem> cartItems = cartItemsData.map((data) {
            // Convert each item in the list to a CartItem object
            return CartItem(data['imgPath'], data['name'], data['price'],
                data['description'], data['amount'], data['email']);
          }).toList();

          // Create a new ShopItem and add it to the respective list
          HistoryItem item =
              HistoryItem(timestamp, totalPrice, email, cartItems);

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
  late String email;

  CartItemUSS(this.name, this.price, this.description, this.amount, this.email);

  static List<CartItemUSS> cartList = [];

  static Future<void> fetchCartData(String email) async {
    try {
      // For taking data from database
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("uss_cart")
          .where('email', isEqualTo: email)
          .get();

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
          String email = document['email'];

          CartItemUSS item =
              CartItemUSS(name, price, description, amount, email);

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

  static Future<void> addItemToCart(
      {required String name,
      required double price,
      required String description,
      required double amount,
      required String email}) async {
    CollectionReference ussCart =
        FirebaseFirestore.instance.collection('uss_cart');

    try {
      QuerySnapshot querySnapshot =
          await ussCart.where('name', isEqualTo: name).get();
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
          'email': email,
        });
        print("Item Added");
      }
    } catch (error) {
      print("Failed to add item: $error");
    }
  }

  static Future<void> updateItemAmount(
      String name, double increment, String email) async {
    CollectionReference ussCart =
        FirebaseFirestore.instance.collection('uss_cart');

    try {
      QuerySnapshot querySnapshot = await ussCart
          .where('name', isEqualTo: name)
          .where('email', isEqualTo: email)
          .get();

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

  static Future<void> removeItemFromCart(String name, String email) async {
    CollectionReference ussCart =
        FirebaseFirestore.instance.collection('uss_cart');

    try {
      QuerySnapshot querySnapshot = await ussCart
          .where('name', isEqualTo: name)
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentReference docRef = querySnapshot.docs.first.reference;
        await docRef.delete();
        print("Item removed from cart");
      }
    } catch (error) {
      print("Failed to remove item from cart: $error");
    }
  }

  static Future<void> saveCartDataToHistory(
      double totalPrice, String email) async {
    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        DocumentReference historyRef =
            FirebaseFirestore.instance.collection('uss_cart_history').doc();

        Map<String, dynamic> data = {
          'timestamp': Timestamp.now(),
          'total_price': totalPrice,
          'email': email,
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
      'email': email
    };
  }

  static Future<void> clearCartDataInFirebase(String email) async {
    try {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      QuerySnapshot cartSnapshot = await FirebaseFirestore.instance
          .collection('uss_cart')
          .where('email', isEqualTo: email)
          .get();
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
  late String email;
  final List<CartItemUSS> cartItem;

  HistoryItemUSS(this.timestamp, this.totalPrice, this.email, this.cartItem);

  static List<HistoryItemUSS> historyList = [];

  static Future<void> fetchHistoryData(String email) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("uss_cart_history")
          .where('email', isEqualTo: email)
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
          String email = document['email'];
          List<dynamic> cartItemsData = document['cart_items'];

          List<CartItemUSS> cartItems = cartItemsData.map((data) {
            return CartItemUSS(data['name'], data['price'], data['description'],
                data['amount'], data['email']);
          }).toList();

          // Create a new ShopItem and add it to the respective list
          HistoryItemUSS item =
              HistoryItemUSS(timestamp, totalPrice, email, cartItems);

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

class User {
  final String email;
  final String password;
  final String salt;
  String username;
  String firstName;
  String lastName;
  String phoneNumber;
  String address;

  User(this.email, this.password, this.salt, this.username, this.firstName,
      this.lastName, this.phoneNumber, this.address);

  static List<User> userList = [];
  static List<User> currentUser = [];

  static String hashPassword(String password, String salt) {
    var bytes =
        utf8.encode(password + salt); // Convert the password to a list of bytes
    var digest = sha256.convert(bytes); // Compute the hash
    return digest.toString(); // Return the hash as a hexadecimal string
  }

  static Future<void> fetchUserData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users") // Replace with your Firestore collection name
          .get();

      if (querySnapshot.size > 0) {
        for (QueryDocumentSnapshot document in querySnapshot.docs) {
          // Access data fields and create ShopItem objects
          String email = document['email'];
          String password = document['password'];
          String salt = document['salt'];
          String username = document['username'];
          String firstName = document['first_name'];
          String lastName = document['last_name'];
          String phoneNumber = document['phone_number'];
          String address = document['address'];

          // Create a new ShopItem and add it to the respective list
          User item = User(email, password, salt, username, firstName, lastName,
              phoneNumber, address);

          // Determine the category and add the item to the appropriate list

          userList.add(item);
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

  static Future<void> fetchUserByEmail(String email) async {
    try {
      currentUser.clear();
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .where('email', isEqualTo: email)
          .limit(1) // Only one document expected
          .get();

      if (querySnapshot.size > 0) {
        DocumentSnapshot document = querySnapshot.docs.first;
        String email = document['email'];
        String password = document['password'];
        String salt = document['salt'];
        String username = document['username'];
        String firstName = document['first_name'];
        String lastName = document['last_name'];
        String phoneNumber = document['phone_number'];
        String address = document['address'];

        // Create a new ShopItem and add it to the respective list
        User item = User(email, password, salt, username, firstName, lastName,
            phoneNumber, address);

        // Determine the category and add the item to the appropriate list

        currentUser.add(item);
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

  static Future<void> createUser({
    required String email,
    required String password,
    required String salt,
    required String username,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required String address,
  }) async {
    CollectionReference userData =
        FirebaseFirestore.instance.collection('users');

    String hashedPassword = hashPassword(password, salt);

    try {
      await userData.add({
        'email': email,
        'password': hashedPassword,
        'salt': salt,
        'username': username,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'address': address,
      });
      print("User Added");
    } catch (error) {
      print("Failed to add item: $error");
    }
  }

  static Future<void> updateUser({
    required String emailToUpdate,
    required String newUsername,
    required String newFirstName,
    required String newLastName,
    required String newPhoneNumber,
    required String newAddress,
  }) async {
    try {
      // Get the reference to the users collection in Firestore
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Query Firestore to find the document with the matching email
      QuerySnapshot querySnapshot =
          await users.where('email', isEqualTo: emailToUpdate).get();

      // Check if any document with the specified email exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the reference to the document containing user data
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

        // Extract the current user data

        // Construct a map for updated data, initially empty
        Map<String, dynamic> updatedData = {};

        // Compare each field with the new value and update the updatedData map

        updatedData['username'] = newUsername;

        updatedData['first_name'] = newFirstName;

        updatedData['last_name'] = newLastName;

        updatedData['phone_number'] = newPhoneNumber;

        updatedData['address'] = newAddress;

        // If there are updated fields, update the document in Firestore
        if (updatedData.isNotEmpty) {
          await documentSnapshot.reference.update(updatedData);
          print('User data updated successfully for $emailToUpdate');
        } else {
          print('No changes detected for user $emailToUpdate');
        }
      } else {
        print('User with email $emailToUpdate not found');
        // Handle the case where the user is not found (e.g., show a message)
      }
    } catch (error) {
      print('Error updating user: $error');
      // Handle error (e.g., show a message)
    }
  }

  static Future<void> deleteDocumentWithEmail(
      String collectionPath, String fieldName, String email) async {
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(collectionPath);
    final QuerySnapshot querySnapshot =
        await collectionReference.where(fieldName, isEqualTo: email).get();

    for (DocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }
}

class UserLogin {
  final String email;
  final String password;
  final String salt;

  UserLogin(this.email, this.password, this.salt);

  static List<UserLogin> userList = [];

  static String hashPassword(String password, String salt) {
    var bytes =
        utf8.encode(password + salt); // Convert the password to a list of bytes
    var digest = sha256.convert(bytes); // Compute the hash
    return digest.toString(); // Return the hash as a hexadecimal string
  }

  static Future<void> fetchUserData() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(
              "users_login") // Replace with your Firestore collection name
          .get();

      if (querySnapshot.size > 0) {
        for (QueryDocumentSnapshot document in querySnapshot.docs) {
          // Access data fields and create ShopItem objects
          String email = document['email'];
          String password = document['password'];
          print("firebase" + password);
          String salt = document['salt'];

          // Create a new ShopItem and add it to the respective list
          UserLogin item = UserLogin(email, password, salt);

          // Determine the category and add the item to the appropriate list

          userList.add(item);
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

  static Future<String?> fetchPasswordByEmail(String email) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users_login")
          .where('email', isEqualTo: email)
          .limit(1) // Only one document expected
          .get();

      if (querySnapshot.size > 0) {
        DocumentSnapshot document = querySnapshot.docs.first;
        String password = document['password'];
        print("Fetched password from Firebase: $password");
        return password;
      } else {
        print('No document found for email: $email');
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }

  static Future<void> createUser({
    required String email,
    required String password,
    required String salt,
  }) async {
    CollectionReference userData =
        FirebaseFirestore.instance.collection('users_login');

    String hashedPassword = hashPassword(password, salt);

    try {
      await userData.add({
        'email': email,
        'password': hashedPassword,
        'salt': salt,
      });
      print("User Added");
    } catch (error) {
      print("Failed to add item: $error");
    }
  }

  static Future<void> deleteDocumentWithEmail(String email) async {
    final CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("users_login");
    final QuerySnapshot querySnapshot =
        await collectionReference.where("email", isEqualTo: email).get();

    for (DocumentSnapshot doc in querySnapshot.docs) {
      await doc.reference.delete();
    }
  }
}
