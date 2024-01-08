// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Rates welcomeFromJson(String str) => Rates.fromJson(json.decode(str));

String welcomeToJson(Rates data) => json.encode(data.toJson());

class Rates {
    String disclaimer;
    String license;
    int timestamp;
    String base;
    Map<String, double> rates;

    Rates({
        required this.disclaimer,
        required this.license,
        required this.timestamp,
        required this.base,
        required this.rates,
    });

    factory Rates.fromJson(Map<String, dynamic> json) => Rates(
        disclaimer: json["disclaimer"],
        license: json["license"],
        timestamp: json["timestamp"],
        base: json["base"],
        rates: Map.from(json["rates"]).map((k, v) => MapEntry<String, double>(k, v?.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "disclaimer": disclaimer,
        "license": license,
        "timestamp": timestamp,
        "base": base,
        "rates": Map.from(rates).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };
}
