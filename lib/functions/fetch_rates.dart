import 'package:currency_converter/models/rates_model.dart';
import 'package:currency_converter/models/all_currencies.dart';
import 'package:currency_converter/utils/key.dart';
import 'package:http/http.dart' as http;

Future<Map> fetchCurrencies() async {
  var response = await http.get(Uri.parse(
      "https://openexchangerates.org/api/currencies.json?app_id=$key"));
  final allCurrencies = allCurrenciesFromJson(response.body);
  return allCurrencies;
}

Future<Rates> fetchRates() async {
  var response = await http.get(
    Uri.parse("https://openexchangerates.org/api/latest.json?app_id=$key"),
  );
  final allRates = welcomeFromJson(response.body);
  return allRates;
}

String changeToUsd(Map rates, String usd, String currency) {
  String output =
      ((rates[currency] * double.parse(usd)).toStringAsFixed(2)).toString();
  return output;
}

String convertToAny(
    Map rates, String amount, String currencyBase, String currencyFinal) {
  String output =
      (double.parse(amount) / rates[currencyBase] * rates[currencyFinal])
          .toStringAsFixed(2)
          .toString();
  return output;
}
