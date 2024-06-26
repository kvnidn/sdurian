import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/utils/constants/colors.dart';

class HistoryUSS extends StatefulWidget {
  final User user;
  const HistoryUSS({Key? key, required this.user}) : super(key: key);

  @override
  State<HistoryUSS> createState() => _HistoryUSSState();
}

class _HistoryUSSState extends State<HistoryUSS> {
  List<HistoryItemUSS> ussHistory = [];
  List<bool> _expandedState = [];

  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 2,
  );

  Future<void> _fetchHistoryData() async {
    await HistoryItemUSS.fetchHistoryData(widget.user.email);
    setState(() {
      ussHistory = HistoryItemUSS.historyList;
      ussHistory.sort((a, b) => b.timestamp.compareTo(a.timestamp));
      _expandedState = List<bool>.filled(ussHistory.length, false);
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchHistoryData();
  }

  @override
  void dispose() {
    ussHistory.clear();
    super.dispose();
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
        title: Text("Order History",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .apply(fontWeightDelta: 2, color: TColors.black)),
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
                      children: ussHistory.map<Widget>((HistoryItemUSS item) {
                        int index = ussHistory.indexOf(item);
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
                                      .map<Widget>((CartItemUSS cartItem) {
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
