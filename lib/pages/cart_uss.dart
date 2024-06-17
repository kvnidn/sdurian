import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:sdurian/components/TicketBuilder/widget/border_painter.dart';
import 'package:sdurian/components/TicketBuilder/widget/ticket_clipper.dart';
import 'package:sdurian/components/widgets/product_price_text.dart';
import 'package:sdurian/components/widgets/square_icon.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/pages/history_uss.dart';
import 'package:sdurian/size_config.dart';
import 'package:sdurian/components/default_button.dart';
import 'package:sdurian/utils/constants/colors.dart';
import 'package:sdurian/utils/constants/sizes.dart';

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
          icon: const Icon(Icons.arrow_back, color: TColors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("USS's Cart",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .apply(fontWeightDelta: 2, color: TColors.black)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: TColors.black),
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
    double ticketHeight = 150;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.spaceBtwItems),
      child: PhysicalShape(
        color: TColors.white,
        elevation: 4,
        shadowColor: Color(0xFFE4E4E4).withOpacity(0.5),
        clipper: TicketClipper(),
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: TicketClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: ticketHeight,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: Offset(0, 0.5),
                    ),
                  ],
                ),
              ),
            ),
            CustomPaint(
              painter: BorderPainter(),
              child: Container(
                height: ticketHeight,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Positioned.fill(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          list[index].name,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .apply(fontWeightDelta: 2),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8),
                                Text(
                                  'Date: ${DateFormat('dd MMM yyyy').format(list[index].date).toString()}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  'Time: ${list[index].time}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  'No. of Visitors: ${list[index].person}',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                SizedBox(height: TSizes.xs),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Price : ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    TProductPriceText(
                                        price: list[index].price *
                                            list[index].amount),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 70,
                height: ticketHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TSquareIcon(
                            icon: Iconsax.add,
                            width: 35,
                            height: 35,
                            size: TSizes.sm * 1.5,
                            color: TColors.white,
                            backgroundColor: TColors.primary,
                            onPressed: () {
                              _incrementItem(list[index]);
                              setState(() {
                                amount++;
                              });
                            },
                          ),
                          SizedBox(height: TSizes.spaceBtwItems),
                          Text(
                            (amount.toInt()).toString(),
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: TSizes.spaceBtwItems),
                          TSquareIcon(
                            icon: Icons.remove,
                            width: 35,
                            height: 35,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// Delete Item Icon
            Positioned(
              top: 57.5,
              right: 57.5,
              child: InkWell(
                onTap: () {
                  _removeItem(list[index]);
                  ussCart.remove(list[index]);
                },
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
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
                    isPrimary: false,
                    press: () {
                      if (ussCart.length > 0) {
                        CartItemUSS.saveCartDataToHistory(
                                totalPrice, widget.user.email)
                            .then((_) => CartItemUSS.clearCartDataInFirebase(
                                    widget.user.email)
                                .then((_) => _clearCart()));
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
