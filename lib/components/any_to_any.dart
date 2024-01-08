import 'package:currency_converter/functions/fetch_rates.dart';
import 'package:flutter/material.dart';

class AnyToAny extends StatefulWidget {
  final rates;
  final Map? currencies;
  const AnyToAny({super.key, this.rates, this.currencies});

  @override
  State<AnyToAny> createState() => _AnyToAnyState();
}

class _AnyToAnyState extends State<AnyToAny> {
  TextEditingController amountController = TextEditingController();
  String answer = 'Converted Currency will be shown here :)';
  String dropdownValue1 = 'AUD';
  String dropdownValue2 = 'AUD';

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
              "Convert Any Currency",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 20),
            TextFormField(
              key: const ValueKey('amount'),
              controller: amountController,
              decoration: const InputDecoration(hintText: 'Enter Amount'),
              keyboardType: TextInputType.number,
              onChanged: (_) {
                answer = "Converted Currency will be shown here :)";
                setState(() {});
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: DropdownButton(
                    value: dropdownValue1,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Colors.grey.shade400,
                    ),
                    items: widget.currencies!.keys
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue1 = newValue!;
                      });
                    },
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Text('To')),
                Expanded(
                  child: DropdownButton(
                    value: dropdownValue2,
                    icon: const Icon(Icons.arrow_drop_down_rounded),
                    iconSize: 24,
                    elevation: 16,
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Colors.grey.shade400,
                    ),
                    items: widget.currencies!.keys
                        .toSet()
                        .toList()
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue2 = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (amountController.text.isEmpty ||
                    double.tryParse(amountController.text) == null) {
                } else {
                  setState(() {
                    answer =
                        "${amountController.text} $dropdownValue1 ${convertToAny(
                      widget.rates,
                      amountController.text,
                      dropdownValue1,
                      dropdownValue2,
                    )} $dropdownValue2";
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
            const SizedBox(height: 10),
            SizedBox(child: Text(answer))
          ],
        ),
      ),
    );
  }
}
