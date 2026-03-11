import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyFormatter {
  static NumberFormat getFormatter(String currencyCode) {
    if (currencyCode == 'IDR') {
      return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);
    } else if (currencyCode == 'USD') {
      return NumberFormat.currency(locale: 'en_US', symbol: '\$ ', decimalDigits: 2);
    } else if (currencyCode == 'EUR') {
      return NumberFormat.currency(locale: 'eu_ES', symbol: '€ ', decimalDigits: 2);
    } else if (currencyCode == 'MYR') {
      return NumberFormat.currency(locale: 'en_MY', symbol: 'RM ', decimalDigits: 2);
    } else if (currencyCode == 'SGD') {
      return NumberFormat.currency(locale: 'en_SG', symbol: 'S\$ ', decimalDigits: 2);
    }
    // Fallback
    return NumberFormat.simpleCurrency(name: currencyCode, decimalDigits: 0);
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  final String currencyCode;
  
  CurrencyInputFormatter({required this.currencyCode});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // If the new value is empty, return it.
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    // Only keep numeric digits
    final String cleanText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanText.isEmpty) {
      return newValue.copyWith(
          text: '', selection: const TextSelection.collapsed(offset: 0));
    }

    final double value = double.parse(cleanText);
    
    // For IDR, we don't use decimal digits for input typically
    int decimalDigits = 0;
    String locale = 'id_ID';
    
    if (currencyCode == 'USD') {
        locale = 'en_US';
        // Usually money trackers without decimal point input assume the last 2 digits are cents? 
        // Or we just allow raw integer formatting for simplicity. Let's use 0 decimal digits for input formatting to avoid complex float parsing for now, or just integer format
    } else if (currencyCode == 'MYR' || currencyCode == 'SGD' || currencyCode == 'EUR') {
        locale = 'en_US'; // Standard comma/dot logic
    }

    final formatter = NumberFormat.decimalPattern(locale);
    final String newText = formatter.format(value);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
