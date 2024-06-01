import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdurian/data.dart';

class HistoryPoodak extends StatefulWidget {
  final User user;
  const HistoryPoodak({Key? key, required this.user}) : super(key: key);

  @override
  State<HistoryPoodak> createState() => _HistoryPoodakState();
}

class _HistoryPoodakState extends State<HistoryPoodak> {
  List<HistoryItem> poodakHistory = [];
  List<bool> _expandedState = [];

  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 2,
  );

  Future<void> _fetchHistoryData() async {
    await HistoryItem.fetchHistoryData(widget.user.email);
    setState(() {
      poodakHistory = HistoryItem.historyList;
      // Sort by timestamp in descending order
      poodakHistory.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      // Initialize the expansion state for each history item
      _expandedState = List<bool>.filled(poodakHistory.length, false);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchHistoryData();
  }

  @override
  void dispose() {
    poodakHistory.clear(); // Clear the list when the page is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFBF00),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Poodak's Cart History",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: poodakHistory.map<Widget>((HistoryItem item) {
                        int index = poodakHistory.indexOf(item);
                        final DateFormat formatter =
                            DateFormat('yyyy-MM-dd HH:mm:ss');
                        final String formattedTimestamp =
                            formatter.format(item.timestamp.toDate());

                        return Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 16.0),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text("Order Time: $formattedTimestamp"),
                                subtitle: Text(
                                    "Total Price: ${currencyFormatter.format(item.totalPrice)}"),
                                trailing: IconButton(
                                  icon: Icon(
                                    _expandedState[index]
                                        ? Icons.expand_less
                                        : Icons.expand_more,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _expandedState[index] =
                                          !_expandedState[index];
                                    });
                                  },
                                ),
                              ),
                              if (_expandedState[index])
                                Column(
                                  children: item.cartItem
                                      .map<Widget>((CartItem cartItem) {
                                    return ListTile(
                                      title: Text("${cartItem.name}"),
                                      subtitle: Text(
                                          "Item Total Price: ${currencyFormatter.format(cartItem.price * cartItem.amount)}\nAmount: ${cartItem.amount.toInt()}"),
                                    );
                                  }).toList(),
                                ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
