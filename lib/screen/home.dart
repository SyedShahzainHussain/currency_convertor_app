import 'package:currency_converter/components/any_to_any.dart';
import 'package:currency_converter/components/usd_to_any.dart';
import 'package:currency_converter/functions/fetch_rates.dart';
import 'package:currency_converter/models/rates_model.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  late Future<Rates> result;
  late Future<Map> allCurrencies;

  @override
  void initState() {
    super.initState();
    setState(() {
      result = fetchRates();
      allCurrencies = fetchCurrencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.sizeOf(context).height;
    double w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Open Exchange Rates"),
      ),
      body: Container(
        height: h,
        width: w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/currency.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: FutureBuilder(
                future: result,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: h -
                          MediaQuery.paddingOf(context).top -
                          MediaQuery.paddingOf(context).bottom,
                      width: w,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return Center(
                    child: FutureBuilder(
                        future: allCurrencies,
                        builder: (context, currSnapshot) {
                          if (currSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return SizedBox(
                              height: h -
                                  MediaQuery.paddingOf(context).top -
                                  MediaQuery.paddingOf(context).bottom,
                              width: w,
                              child: const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              UsdToAny(
                                  currencies: currSnapshot.data,
                                  rates: snapshot.data!.rates),
                              AnyToAny(
                                currencies: currSnapshot.data,
                                rates: snapshot.data!.rates,
                              ),
                            ],
                          );
                        }),
                  );
                }),
          ),
        ),
      ),
    );
  }
}
