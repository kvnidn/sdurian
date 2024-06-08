import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sdurian/utils/constants/colors.dart';
import 'package:sdurian/utils/constants/sizes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentsScreen extends StatefulWidget {
  PaymentsScreen({Key? key}) : super(key: key);

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  String selectedPayment = '';
  String cardNumber = '';
  String expiresDate = '';
  String cvv = '';
  bool isExpanded = false; // Set the card to condensed

  String UPSCreditsData = '';
  String giftCardsData = '';

  int UPSCreditsPoints = 1000;

  List<Map<String, dynamic>> vouchers = [
    {
      'name': 'Buy 2 Get 1',
      'description': 'Get 1 free with your purchase',
      'expiryDate': DateTime(2024, 7, 16),
      'used': false,
    },
    {
      'name': '50% Discount',
      'description': 'Enjoy a 50% discount on your purchase',
      'expiryDate': DateTime(2024, 7, 28),
      'used': false,
    },
  ];

  String giftCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primary,
        title: Text(
          "Payments",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .apply(fontWeightDelta: 2),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildPaymentsScreen(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadSavedData();
  }

  _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cardNumber = prefs.getString('cardNumber') ?? '';
      expiresDate = prefs.getString('expiresDate') ?? '';
      cvv = prefs.getString('cvv') ?? '';
    });
  }

  _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cardNumber', cardNumber);
    prefs.setString('expiresDate', expiresDate);
    prefs.setString('cvv', cvv);
  }

  Widget _buildPaymentsScreen() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPaymentsItem("Kartu Debit/Kredit", Icons.credit_card),
          if (selectedPayment == "Kartu Debit/Kredit" && isExpanded) ...[
            const SizedBox(height: TSizes.spaceBtwItems),
            _buildCreditCardImage(),
            const SizedBox(height: TSizes.spaceBtwItems),
            _buildCreditCardForm(),
            const SizedBox(height: TSizes.spaceBtwItems),
            _buildSaveButton(),
          ],
          _buildDivider(),
          _buildPaymentsItem(
              "Universal Poodak Studio Poin", Icons.monetization_on,
              showPoints: true),
          if (selectedPayment == "Universal Poodak Studio Poin" &&
              isExpanded) ...[
            const SizedBox(height: TSizes.spaceBtwItems),
            _buildUPSCreditsInfo(),
            const SizedBox(height: TSizes.spaceBtwItems),
            _buildSaveUPSCreditsButton(),
          ],
          _buildDivider(),
          _buildPaymentsItem("Vouchers", Icons.confirmation_num),
          if (selectedPayment == "Vouchers" && isExpanded) ...[
            const SizedBox(height: TSizes.spaceBtwItems),
            _buildVouchersForm(),
            const SizedBox(height: TSizes.spaceBtwItems),
            _buildSaveVouchersButton(),
          ],
          _buildDivider(),
          _buildPaymentsItem("Claim Voucher", Icons.card_giftcard),
          if (selectedPayment == "Claim Voucher" && isExpanded) ...[
            const SizedBox(height: TSizes.spaceBtwItems),
            _buildGiftCardsInstructions(),
            const SizedBox(height: TSizes.spaceBtwItems),
            _buildGiftCardImage(),
            const SizedBox(height: TSizes.spaceBtwItems),
            _buildGiftCardCodeInput(),
            const SizedBox(height: TSizes.spaceBtwItems),
            _buildRedeemGiftCardButton(),
          ],
          _buildDivider(),
        ],
      ),
    );
  }

  Widget _buildPaymentsItem(String item, IconData iconData,
      {bool showPoints = false}) {
    final isSelected = selectedPayment == item;
    return Card(
      elevation: 4.0,
      child: ListTile(
        leading: Icon(
          iconData,
          size: 36.0,
          color: TColors.black,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (showPoints)
              Text(
                "Poin yang kamu miliki: $UPSCreditsPoints",
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
        onTap: () {
          setState(() {
            if (isSelected) {
              isExpanded = !isExpanded;
            } else {
              selectedPayment = item;
              isExpanded = true;
            }
          });
        },
      ),
    );
  }

  Widget _buildCreditCardImage() {
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        'lib/assets/Payment/Debit_Card.jpg',
        height: 200.0,
      ),
    );
  }

  Widget _buildCreditCardForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          onChanged: (value) {
            cardNumber = value;
          },
          decoration: InputDecoration(
            labelText: "Card Number",
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (value) {
                  expiresDate = value;
                },
                decoration: InputDecoration(
                  labelText: "Expires Date",
                ),
              ),
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  cvv = value;
                },
                decoration: InputDecoration(
                  labelText: "CVV",
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: () {
        _saveData();
        Fluttertoast.showToast(
          msg: "Your card data has been successfully saved",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: TColors.primary,
          textColor: TColors.white,
          fontSize: 16.0,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: TColors.primary,
      ),
      child: Text(
        "Save",
        style:
            Theme.of(context).textTheme.bodySmall!.apply(color: TColors.white),
      ),
    );
  }

  Widget _buildDivider() {
    return const SizedBox(height: TSizes.spaceBtwItems);
  }

  Widget _buildUPSCreditsInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: TSizes.md),
              width: 360,
              child: Text(
                "You have $UPSCreditsPoints Universal Poodak Studio points",
                style: Theme.of(context).textTheme.titleSmall,
                overflow: TextOverflow.ellipsis,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSaveUPSCreditsButton() {
    return Container();
  }

  Widget _buildVouchersForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: vouchers.map((voucher) {
        bool isExpired = voucher['expiryDate'].isBefore(DateTime.now());
        return Card(
          elevation: 4.0,
          color: isExpired ? Colors.grey : Colors.white,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: TSizes.sm),
            child: ListTile(
              title: Text(
                voucher['name'],
                style: Theme.of(context).textTheme.titleLarge,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    voucher['description'],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    'Expires on: ${voucher['expiryDate'].toString().split(' ')[0]}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    'Status: ${voucher['used'] ? 'Used' : 'Not Used'}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              onTap: () {
                if (!isExpired && !voucher['used']) {
                  setState(() {
                    voucher['used'] = true;
                  });
                  Fluttertoast.showToast(
                    msg: "Voucher '${voucher['name']}' has been used",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: TColors.grey,
                    textColor: TColors.black,
                  );
                } else {
                  setState(() {
                    voucher['used'] = false;
                  });
                  Fluttertoast.showToast(
                    msg: "Voucher '${voucher['name']}' has not been used",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: TColors.grey,
                    textColor: TColors.black,
                  );
                }
              },
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSaveVouchersButton() {
    return ElevatedButton(
      onPressed: () {
        Fluttertoast.showToast(
          msg: "Voucher data has been successfully saved",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: TColors.grey,
          textColor: TColors.black,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: TColors.primary,
      ),
      child: Text(
        "Save Vouchers",
        style:
            Theme.of(context).textTheme.bodySmall!.apply(color: TColors.white),
      ),
    );
  }

  Widget _buildGiftCardsInstructions() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: TSizes.md),
      child: Text(
        "Enter your voucher code below:",
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }

  Widget _buildGiftCardImage() {
    return Container(
      alignment: Alignment.center,
      child: Image.asset(
        'lib/assets/Payment/gift_card.jpg',
        height: 200.0,
      ),
    );
  }

  Widget _buildGiftCardCodeInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          onChanged: (value) {
            giftCode = value;
          },
          decoration: InputDecoration(
            labelText: "Voucher Code",
          ),
        ),
      ],
    );
  }

  Widget _buildRedeemGiftCardButton() {
    return ElevatedButton(
      onPressed: () {
        Fluttertoast.showToast(
          msg: "Voucher has been redeemed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: TColors.grey,
          textColor: TColors.black,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: TColors.primary,
      ),
      child: Text(
        "Redeem Now",
        style:
            Theme.of(context).textTheme.bodySmall!.apply(color: TColors.white),
      ),
    );
  }
}
