import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sdurian/components/widgets/circular_icon.dart';
import 'package:sdurian/components/widgets/product_price_text.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/pages/history_poodak.dart';
import 'package:sdurian/size_config.dart';
import 'package:sdurian/components/default_button.dart';
import 'package:sdurian/utils/constants/colors.dart';
import 'package:sdurian/utils/constants/sizes.dart';

class CartPoodak extends StatefulWidget {
  final User user;
  const CartPoodak({Key? key, required this.user}) : super(key: key);

  @override
  State<CartPoodak> createState() => _CartPoodakState();
}

class _CartPoodakState extends State<CartPoodak> {
  List<CartItem> poodakCart = [];

  Future<void> _fetchCartData() async {
    await CartItem.fetchCartData(widget.user.email);
    setState(() {
      poodakCart = CartItem.cartList;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchCartData();
  }

  @override
  void dispose() {
    poodakCart.clear(); // Clear the list when the page is disposed
    super.dispose();
  }

  void _updateCart() {
    setState(() {
      poodakCart = CartItem.cartList;
    });
  }

  void _clearCart() {
    for (var item in poodakCart) {
      _removeItem(item);
    }
    setState(() {
      poodakCart.clear();
    });
  }

  void _incrementItem(CartItem item) {
    setState(() {
      item.amount++; // Update the amount directly
    });
    CartItem.updateItemAmount(item.name, 1, widget.user.email)
        .then((_) => _updateCart());
  }

  void _decrementItem(CartItem item) {
    setState(() {
      if (item.amount > 0) {
        item.amount--; // Update the amount directly
        if (item.amount == 0) {
          // Remove the item from the list when amount hits 0
          poodakCart.remove(item);
        }
      }
    });
    CartItem.updateItemAmount(item.name, -1, widget.user.email)
        .then((_) => _updateCart());
  }

  void _removeItem(CartItem item) {
    CartItem.removeItemFromCart(item.name, widget.user.email)
        .then((_) => _updateCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Poodak's Cart",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .apply(fontWeightDelta: 2)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Colors.black),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HistoryPoodak(
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
                itemCount: poodakCart.length,
                itemBuilder: (context, index) {
                  return _buildItemCard(poodakCart, index);
                },
              ),
            ),
            _checkoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(List<CartItem> list, int index) {
    Key itemKey = ValueKey(list[index].name);

    double amount = list[index].amount;
    return Container(
      key: itemKey,
      padding: EdgeInsets.only(top: 10),
      margin: EdgeInsets.only(top: 14, left: 10, right: 10),
      width: 360,
      height: 100,
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
                padding: const EdgeInsets.only(left: 12, top: 2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    list[index].imgPath,
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 200,
                      child: Text(
                        list[index].name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall!
                            .apply(fontWeightDelta: 1),
                      ),
                    ),
                    Container(
                      width: 200,
                      child: Text(
                        list[index].description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(fontSizeFactor: 0.8),
                      ),
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Container(
                      padding: EdgeInsets.only(bottom: TSizes.xs * 1.5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TCircularIcon(
                            icon: Icons.remove,
                            width: 28,
                            height: 28,
                            size: TSizes.sm * 1.5,
                            color: TColors.black,
                            backgroundColor: TColors.light,
                            onPressed: () {
                              _decrementItem(list[index]);
                              setState(() {
                                amount--;
                              });
                            },
                          ),
                          SizedBox(width: TSizes.spaceBtwItems),
                          Text(
                            (amount.toInt()).toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: TSizes.spaceBtwItems),
                          TCircularIcon(
                            icon: Iconsax.add,
                            width: 28,
                            height: 28,
                            size: TSizes.sm * 1.5,
                            color: TColors.black,
                            backgroundColor: TColors.primary,
                            onPressed: () {
                              _incrementItem(list[index]);
                              setState(() {
                                amount++;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 12,
            right: 14,
            child: TProductPriceText(
              price: list[index].price * list[index].amount,
            ),
          ),
          Positioned(
            top: 2,
            right: 14,
            child: InkWell(
              onTap: () {
                _removeItem(list[index]);
                poodakCart.remove(list[index]);
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
        poodakCart.fold(0, (sum, item) => sum + item.price * item.amount);

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
                      TProductPriceText(
                        price: totalPrice,
                        isLarge: true,
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
                      if (poodakCart.length > 0) {
                        CartItem.saveCartDataToHistory(
                                totalPrice, widget.user.email)
                            .then((_) => CartItem.clearCartDataInFirebase(
                                    widget.user.email)
                                .then((_) =>
                                    _clearCart())); // Save cart data to history
                        ElegantNotification(
                          position: Alignment.topCenter,
                          animation: AnimationType.fromTop,
                          width: 360,
                          height: 60,
                          description: Text(
                            "Checkout Succesfully!",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(fontWeightDelta: 2),
                            textAlign: TextAlign.center,
                          ),
                          icon: const Icon(
                            Icons.check_circle,
                            color: TColors.primary,
                          ),
                          progressIndicatorColor: TColors.primary,
                        ).show(context);
                      } else {
                        ElegantNotification.error(
                          position: Alignment.topCenter,
                          animation: AnimationType.fromTop,
                          width: 360,
                          height: 60,
                          description: Text(
                            "The cart is empyty!",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .apply(fontWeightDelta: 2),
                            textAlign: TextAlign.center,
                          ),
                        ).show(context);
                        print("Cart is Empty");
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
