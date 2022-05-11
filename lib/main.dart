import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "package:ndialog/ndialog.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BitcoinConverter(),
    );
  }
}

class BitcoinConverter extends StatefulWidget {
  const BitcoinConverter({Key? key}) : super(key: key);

  @override
  State<BitcoinConverter> createState() => _BitcoinConverterState();
}

class _BitcoinConverterState extends State<BitcoinConverter> {
  String selectCurrency = "btc",
      unit = "Please choose the currency that you would like to convert",
      type = "crypto",
      name = "bitcoin";

  var value = 0.0;
  List<String> currencyList = [
    "btc",
    "eth",
    "ltc",
    "bch",
    "bnb",
    "eos",
    "xrp",
    "xlm",
    "link",
    "dot",
    "yfi",
    "usd",
    "aed",
    "ars",
    "aud",
    "bdt",
    "bhd",
    "bmd",
    "brl",
    "cad",
    "chf",
    "clp",
    "cny",
    "czk",
    "dkk",
    "eur",
    "gbp",
    "hkd",
    "huf",
    "idr",
    "ils",
    "inr",
    "jpy",
    "krw",
    "kwd",
    "lkr",
    "mmk",
    "mxn",
    "myr",
    "ngn",
    "nok",
    "nzd",
    "php",
    "pkr",
    "pln",
    "rub",
    "sar",
    "sek",
    "sgd",
    "thb",
    "try",
    "twd",
    "uah",
    "vef",
    "vnd",
    "zar",
    "xdr",
    "xag",
    "xau",
    "bits",
    "sats",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Bitcoin Converter")),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Bitcoin Cryptocurrency Converter",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          DropdownButton(
            itemHeight: 60,
            value: selectCurrency,
            onChanged: (newValue) {
              setState(() {
                selectCurrency = newValue.toString();
              });
            },
            items: currencyList.map((selectCurrency) {
              return DropdownMenuItem(
                child: Text(
                  selectCurrency,
                ),
                value: selectCurrency,
              );
            }).toList(),
          ),
          ElevatedButton(
              onPressed: _loadConversion, child: const Text("Load Conversion")),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Container(
              color: Colors.amberAccent,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    unit,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 32),
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  Future<void> _loadConversion() async {
    ProgressDialog progressDialog = ProgressDialog(context,
        message: const Text("Progress"), title: const Text("Searching..."));
    progressDialog.show();

    var url = Uri.parse('https://api.coingecko.com/api/v3/exchange_rates');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedData = json.decode(jsonData);
      name = parsedData['rates'][selectCurrency]['name'];
      unit = parsedData['rates'][selectCurrency]['unit'];
      value = parsedData['rates'][selectCurrency]['value'];
      type = parsedData['rates'][selectCurrency]['type'];
      setState(() {
        unit = "The value of $name in type $type is $value $unit.";
      });
      progressDialog.dismiss();
    }
  }
}
