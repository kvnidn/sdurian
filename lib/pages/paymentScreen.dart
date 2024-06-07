import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
        backgroundColor: const Color(0xFFFFBF00),
        title: Text("Payments"),
      ),
      backgroundColor: Colors.white,
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
            SizedBox(height: 16.0),
            _buildCreditCardImage(),
            SizedBox(height: 16.0),
            _buildCreditCardForm(),
            SizedBox(height: 16.0),
            _buildSaveButton(),
          ],
          _buildDivider(),
          _buildPaymentsItem(
              "Universal Poodak Studio Poin", Icons.monetization_on,
              showPoints: true),
          if (selectedPayment == "Universal Poodak Studio Poin" &&
              isExpanded) ...[
            SizedBox(height: 16.0),
            _buildUPSCreditsInfo(),
            SizedBox(height: 16.0),
            _buildSaveUPSCreditsButton(),
          ],
          _buildDivider(),
          _buildPaymentsItem("Vouchers", Icons.confirmation_num),
          if (selectedPayment == "Vouchers" && isExpanded) ...[
            SizedBox(height: 16.0),
            _buildVouchersForm(),
            SizedBox(height: 16.0),
            _buildSaveVouchersButton(),
          ],
          _buildDivider(),
          _buildPaymentsItem("Claim Voucher", Icons.card_giftcard),
          if (selectedPayment == "Claim Voucher" && isExpanded) ...[
            SizedBox(height: 16.0),
            _buildGiftCardsInstructions(),
            SizedBox(height: 16.0),
            _buildGiftCardImage(),
            SizedBox(height: 16.0),
            _buildGiftCardCodeInput(),
            SizedBox(height: 16.0),
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
          color: const Color(0xFF0912C7),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            if (showPoints)
              Text(
                "Poin yang kamu miliki: $UPSCreditsPoints",
                style: TextStyle(fontSize: 13),
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
        SizedBox(height: 16.0),
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
            SizedBox(width: 16.0),
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
          backgroundColor: const Color(0xFFFFBF00),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFBF00),
      ),
      child: Text(
        "Save",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return SizedBox(height: 16.0);
  }

  Widget _buildUPSCreditsInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                "You have $UPSCreditsPoints Universal Poodak Studio points",
                style: TextStyle(fontSize: 16.0),
                overflow: TextOverflow.ellipsis,
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
          child: ListTile(
            title: Text(
              voucher['name'],
              style: TextStyle(fontSize: 18.0),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  voucher['description'],
                  style: TextStyle(fontSize: 14.0),
                ),
                Text(
                  'Expires on: ${voucher['expiryDate'].toString().split(' ')[0]}',
                  style: TextStyle(fontSize: 12.0),
                ),
                Text(
                  'Status: ${voucher['used'] ? 'Used' : 'Not Used'}',
                  style: TextStyle(fontSize: 12.0),
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
                  backgroundColor: const Color(0xFFFFBF00),
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              } else {
                setState(() {
                  voucher['used'] = false;
                });
                Fluttertoast.showToast(
                  msg: "Voucher '${voucher['name']}' has not been used",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: const Color(0xFFFFBF00),
                  textColor: Colors.white,
                  fontSize: 16.0,
                );
              }
            },
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
          backgroundColor: const Color(0xFFFFBF00),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFBF00),
      ),
      child: Text(
        "Save Vouchers",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildGiftCardsInstructions() {
    return Text(
      "Enter your voucher code below:",
      style: TextStyle(fontSize: 18.0),
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
          backgroundColor: const Color(0xFFFFBF00),
          textColor: Colors.white,
          fontSize: 16.0,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFFBF00),
      ),
      child: Text(
        "Redeem Now",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PaymentsScreen(),
  ));
}
