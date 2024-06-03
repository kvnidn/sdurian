import 'package:intl/intl.dart';

class TFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date); // Customize date format
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp')
        .format(amount); // Customize currency format
  }

  static String formatPhoneNumber(String phoneNumber) {
    // Assuming a 11 digit ID (exc. country code) phone number format: +62 8xx-xxxx-xxxx
    String countryCode = '+62';
    if (phoneNumber.length == 11 && phoneNumber.length == 12) {
      return '${countryCode} ${phoneNumber.substring(0, 3)}-${phoneNumber.substring(3, 7)}-${phoneNumber.substring(7)}';
    } else if (phoneNumber.length == 10) {
      return '${countryCode} ${phoneNumber.substring(0, 3)}-${phoneNumber.substring(3, 6)}-${phoneNumber.substring(6)}';
    }
    return phoneNumber;
  }
}
