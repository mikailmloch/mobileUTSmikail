import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class suhuScreen extends StatefulWidget {
  const suhuScreen({Key? key}) : super(key: key);

  @override
  _suhuScreenState createState() => _suhuScreenState();
}

class _suhuScreenState extends State<suhuScreen> {
  TextEditingController inputTemperatureController = TextEditingController();
  TextEditingController resultController = TextEditingController();
  String selectedUnitFrom = 'Celsius';
  String selectedUnitTo = 'Celsius';

  final temperatureUnits = ['Celsius', 'Fahrenheit', 'Kelvin'];

  double convertTemperature(double temperature, String from, String to) {
    if (from == to) {
      return temperature;
    }

    if (from == 'Celsius') {
      if (to == 'Fahrenheit') {
        return (temperature * 9 / 5) + 32;
      } else if (to == 'Kelvin') {
        return temperature + 273.15;
      }
    } else if (from == 'Fahrenheit') {
      if (to == 'Celsius') {
        return (temperature - 32) * 5 / 9;
      } else if (to == 'Kelvin') {
        return (temperature + 459.67) * 5 / 9;
      }
    } else if (from == 'Kelvin') {
      if (to == 'Celsius') {
        return temperature - 273.15;
      } else if (to == 'Fahrenheit') {
        return (temperature * 9 / 5) - 459.67;
      }
    }

    return temperature; // Default jika unit tidak valid
  }

  void calculateConversion() {
    double inputTemperature = double.tryParse(inputTemperatureController.text) ?? 0.0;
    double result = convertTemperature(inputTemperature, selectedUnitFrom, selectedUnitTo);
    resultController.text = result.toStringAsFixed(2);
  }

  @override
  void initState() {
    super.initState();
    inputTemperatureController.addListener(() {
      calculateConversion();
    });
    inputTemperatureController.text = "0.0"; // Set default value
    calculateConversion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Konversi Suhu',
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
              Text('Masukkan temperatur :'),
              TextField(
                controller: inputTemperatureController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              Text('Konversi dari :'),
              DropdownButton<String>(
                value: selectedUnitFrom,
                items: temperatureUnits.map((String unit) {
                  return DropdownMenuItem<String>(
                    value: unit,
                    child: Text(unit),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedUnitFrom = newValue!;
                    calculateConversion();
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text('Konversikan ke :'),
              DropdownButton<String>(
                value: selectedUnitTo,
                items: temperatureUnits.map((String unit) {
                  return DropdownMenuItem<String>(
                    value: unit,
                    child: Text(unit),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedUnitTo = newValue!;
                    calculateConversion();
                  });
                },
              ),
              SizedBox(height: 16.0),
              Text('Hasil Konversi :'),
              TextField(
                controller: resultController,
                enabled: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
