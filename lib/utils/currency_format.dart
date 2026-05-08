class CurrencyFormat {
  /// Format double to string Rupiah
  static String formatToRupiah(double amount) {
    String price = amount.toStringAsFixed(0);
    String result = '';
    int count = 0;
    for (int i = price.length - 1; i >= 0; i--) {
      count++;
      result = price[i] + result;
      if (count % 3 == 0 && i != 0) {
        result = '.$result';
      }
    }
    return result;
  }
}
