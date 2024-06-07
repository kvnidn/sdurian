import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/pages/history_uss.dart';
import 'package:sdurian/size_config.dart';
import 'package:sdurian/components/default_button.dart';
import 'package:sdurian/utils/constants/colors.dart';

class CartUSS extends StatefulWidget {
  final User user;
  const CartUSS({Key? key, required this.user}) : super(key: key);

  @override
  State<CartUSS> createState() => _CartUSSState();
}

class _CartUSSState extends State<CartUSS> {
  List<CartItemUSS> ussCart = [];

  Future<void> _fetchCartData() async {
    await CartItemUSS.fetchCartData(widget.user.email);
    setState(() {
      ussCart = CartItemUSS.cartList;
    });
  }

  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 2,
  );

  @override
  void initState() {
    super.initState();
    _fetchCartData();
  }

  @override
  void dispose() {
    ussCart.clear(); // Clear the list when the page is disposed
    super.dispose();
  }

  void _updateCart() {
    setState(() {
      ussCart = CartItemUSS.cartList;
    });
  }

  void _clearCart() {
    for (var item in ussCart) {
      _removeItem(item);
    }
    setState(() {
      ussCart.clear();
    });
  }

  void _incrementItem(CartItemUSS item) {
    setState(() {
      item.amount++;
    });
    CartItemUSS.updateItemAmount(item.name, 1, widget.user.email)
        .then((_) => _updateCart());
  }

  void _decrementItem(CartItemUSS item) {
    setState(() {
      if (item.amount > 0) {
        item.amount--;
        if (item.amount == 0) {
          ussCart.remove(item);
        }
      }
    });
    CartItemUSS.updateItemAmount(item.name, -1, widget.user.email)
        .then((_) => _updateCart());
  }

  void _removeItem(CartItemUSS item) {
    CartItemUSS.removeItemFromCart(item.name, widget.user.email)
        .then((_) => _updateCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "USS's Cart",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.history, color: Colors.black),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HistoryUSS(
                            user: widget.user,
                          )));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: ussCart.length,
                itemBuilder: (context, index) {
                  return _buildItemCard(ussCart, index);
                },
              ),
            ),
            _checkoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(List<CartItemUSS> list, int index) {
    double amount = list[index].amount;

    return Container(
      padding: EdgeInsets.only(top: 10),
      margin: EdgeInsets.only(top: 14, left: 10, right: 10),
      width: 360,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, 0.5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      list[index].name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      constraints: BoxConstraints(maxWidth: 350),
                      child: Text(
                        list[index].description,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            left: 20,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    _decrementItem(list[index]);
                    setState(() {
                      amount--;
                    });
                  },
                  child: Icon(Icons.remove_circle),
                ),
                SizedBox(width: 10),
                Text(
                  (amount.toInt()).toString(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    _incrementItem(list[index]);
                    setState(() {
                      amount++;
                    });
                  },
                  child: Icon(Icons.add_circle),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Text(
              '${currencyFormatter.format((list[index].price * list[index].amount))}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
          Positioned(
            top: 2,
            right: 10,
            child: InkWell(
              onTap: () {
                _removeItem(list[index]);
                ussCart.remove(list[index]);
              },
              child: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Center(
                  child: Icon(
                    Icons.delete_forever_outlined,
                    size: 24,
                    color: Colors.redAccent,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkoutButton() {
    double totalPrice =
        ussCart.fold(0, (sum, item) => sum + item.price * item.amount);

    return Container(
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: getProportionateScreenHeight(120),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  spreadRadius: 4,
                  offset: Offset(0, -1),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 16.0, bottom: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Price:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${currencyFormatter.format(totalPrice)}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 16.0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: DefaultButton(
                    text: "Checkout",
                    press: () {
                      if (ussCart.length > 0) {
                        CartItemUSS.saveCartDataToHistory(
                                totalPrice, widget.user.email)
                            .then((_) => CartItemUSS.clearCartDataInFirebase(
                                    widget.user.email)
                                .then((_) => _clearCart()));
                      } else {
                        print("Cart Empty");
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
