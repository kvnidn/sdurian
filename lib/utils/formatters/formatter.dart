import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

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

// Phone Number Input Formatter
class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newText = newValue.text;

    String formattedText = '';
    // Format the first 3 digits
    if (newText.length >= 3) {
      formattedText += '${newText.substring(0, 3)} ';
    } else {
      formattedText += newText.substring(0, newText.length);
    }

    // Format the next 4 digits
    if (newText.length >= 7) {
      formattedText += '${newText.substring(3, 7)} ';
    } else if (newText.length > 3) {
      formattedText += newText.substring(3, newText.length);
    }

    // Append the remaining digits
    if (newText.length > 7) {
      formattedText += newText.substring(7, newText.length);
    }

    // Remove trailing space if it exists
    if (formattedText.endsWith(' ')) {
      formattedText = formattedText.substring(0, formattedText.length - 1);
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
