import 'package:currency_converter/functions/fetch_rates.dart';
import 'package:flutter/material.dart';

class UsdToAny extends StatefulWidget {
  final rates;
  final Map? currencies;
  const UsdToAny({super.key, this.currencies, this.rates});

  @override
  State<UsdToAny> createState() => _UsdToAnyState();
}

class _UsdToAnyState extends State<UsdToAny> {
  TextEditingController usdController = TextEditingController();
  String dropdownValue = 'AUD';
  String answer = 'Converted Currency will be shown here :)';

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'USD to Any Currency',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 20),
            // * TextFields for Entering USD
            TextFormField(
              key: const ValueKey('usd'),
              controller: usdController,
              onChanged: (_) {
                answer = "Converted Currency will be shown here :)";
                setState(() {});
              },
              decoration: const InputDecoration(hintText: 'Enter USD'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButton(
                    value: dropdownValue,
                    items: widget.currencies!.keys
                        .toList()
                        .map((value) =>
                            DropdownMenuItem(value: value, child: Text(value)))
                        .toList(),
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue = newValue.toString();
                      });
                    },
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),

                //Convert Button
                ElevatedButton(
                  onPressed: () {
                    if (usdController.text.isEmpty ||
                        double.tryParse(usdController.text) == null) {
                    } else {
                      setState(() {
                        answer =
                            "${usdController.text} USD = ${changeToUsd(widget.rates, usdController.text.toString(), dropdownValue.toString())} $dropdownValue";
                      });
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor)),
                  child: const Text('Convert'),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            // * Final Output
            const SizedBox(height: 10),
            SizedBox(child: Text(answer))
          ],
        ),
      ),
    );
  }
}
