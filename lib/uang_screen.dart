import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class uangScreen extends StatefulWidget {
  const uangScreen({Key? key}) : super(key: key);

  @override
  _uangScreenState createState() => _uangScreenState();
}

class _uangScreenState extends State<uangScreen> {
  TextEditingController nominalController = TextEditingController();
  TextEditingController hasilController = TextEditingController();
  String selectedCurrencyFrom = 'Indonesia [Rupiah]';
  String selectedCurrencyTo = 'Indonesia [Rupiah]';

  final currencies = [
    'Indonesia [Rupiah]',
    'Malaysia [Ringgit]',
    'Singapore [Dolar]',
    'Arab [Riyal]',
    'Japan [Yen]',
  ];

  double convertCurrency(double nominal, String from, String to) {
    double conversionRate = 1.0; // Default conversion rate, jika mata uang tidak ada dalam daftar

    if (from == 'Indonesia [Rupiah]') {
      // Konversi dari Rupiah
      if (to == 'Malaysia [Ringgit]') {
        conversionRate = 0.024;
      } else if (to == 'Singapore [Dolar]') {
        conversionRate = 0.000089;
      } else if (to == 'Arab [Riyal]') {
        conversionRate = 0.00024;
      } else if (to == 'Japan [Yen]') {
        conversionRate = 0.0081;
      }
    } else if (from == 'Malaysia [Ringgit]') {
      // Konversi dari Ringgit
      if (to == 'Indonesia [Rupiah]') {
        conversionRate = 41.67;
      } else if (to == 'Singapore [Dolar]') {
        conversionRate = 0.379;
      } else if (to == 'Arab [Riyal]') {
        conversionRate = 1.03;
      } else if (to == 'Japan [Yen]') {
        conversionRate = 34.34;
      }
    } else if (from == 'Singapore [Dolar]') {
      // Konversi dari Dolar Singapura
      if (to == 'Indonesia [Rupiah]') {
        conversionRate = 11225.81;
      } else if (to == 'Malaysia [Ringgit]') {
        conversionRate = 2.636;
      } else if (to == 'Arab [Riyal]') {
        conversionRate = 3.759;
      } else if (to == 'Japan [Yen]') {
        conversionRate = 84.5;
      }
    } else if (from == 'Arab [Riyal]') {
      // Konversi dari Riyal Arab
      if (to == 'Indonesia [Rupiah]') {
        conversionRate = 4183.33;
      } else if (to == 'Malaysia [Ringgit]') {
        conversionRate = 0.974;
      } else if (to == 'Singapore [Dolar]') {
        conversionRate = 0.265;
      } else if (to == 'Japan [Yen]') {
        conversionRate = 22.36;
      }
    } else if (from == 'Japan [Yen]') {
      // Konversi dari Yen Jepang
      if (to == 'Indonesia [Rupiah]') {
        conversionRate = 123.46;
      } else if (to == 'Malaysia [Ringgit]') {
        conversionRate = 0.029;
      } else if (to == 'Singapore [Dolar]') {
        conversionRate = 0.012;
      } else if (to == 'Arab [Riyal]') {
        conversionRate = 0.045;
      }
    }

    return nominal * conversionRate;
  }


  void calculateConversion() {
    double nominal = double.tryParse(nominalController.text) ?? 0.0;
    double hasil = convertCurrency(nominal, selectedCurrencyFrom, selectedCurrencyTo);
    hasilController.text = hasil.toStringAsFixed(2);
  }

  @override
  void initState() {
    super.initState();
    nominalController.addListener(() {
      calculateConversion();
    });
    nominalController.text = "0"; // Set default value
    calculateConversion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Konversi Mata Uang',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Color.fromRGBO(80, 59, 163, 1),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Masukkan nominal uang:'),
              TextField(
                controller: nominalController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              Text('Konversi dari :'),
              DropdownButton<String>(
                value: selectedCurrencyFrom,
                items: currencies.map((String currency) {
                  return DropdownMenuItem<String>(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCurrencyFrom = newValue!;
                    calculateConversion();
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text('Konversikan ke :'),
              DropdownButton<String>(
                value: selectedCurrencyTo,
                items: currencies.map((String currency) {
                  return DropdownMenuItem<String>(
                    value: currency,
                    child: Text(currency),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCurrencyTo = newValue!;
                    calculateConversion();
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text('Hasil Konversi'),
              TextField(
                controller: hasilController,
                enabled: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
