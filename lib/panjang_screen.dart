import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class panjangScreen extends StatefulWidget {
  const panjangScreen({Key? key}) : super(key: key);

  @override
  _panjangScreenState createState() => _panjangScreenState();
}

class _panjangScreenState extends State<panjangScreen> {
  TextEditingController inputLengthController = TextEditingController();
  TextEditingController resultController = TextEditingController();
  String selectedUnitFrom = 'Meter';
  String selectedUnitTo = 'Meter';

  final lengthUnits = ['Meter', 'Kilometer', 'Hektometer', 'Dekameter', 'Centimeter', 'Milimeter'];

  double convertLength(double length, String from, String to) {
    if (from == to) {
      return length;
    }

    if (from == 'Meter') {
      if (to == 'Kilometer') {
        return length / 1000;
      } else if (to == 'Hektometer') {
        return length / 100;
      } else if (to == 'Dekameter') {
        return length / 10;
      } else if (to == 'Centimeter') {
        return length * 100;
      } else if (to == 'Milimeter') {
        return length * 1000;
      }
    } else if (from == 'Kilometer') {
      if (to == 'Meter') {
        return length * 1000;
      } else if (to == 'Hektometer') {
        return length * 10;
      } else if (to == 'Dekameter') {
        return length * 100;
      } else if (to == 'Centimeter') {
        return length * 100000;
      } else if (to == 'Milimeter') {
        return length * 1000000;
      }
    } else if (from == 'Hektometer') {
      if (to == 'Meter') {
        return length * 100;
      } else if (to == 'Kilometer') {
        return length / 10;
      } else if (to == 'Dekameter') {
        return length * 10;
      } else if (to == 'Centimeter') {
        return length * 10000;
      } else if (to == 'Milimeter') {
        return length * 100000;
      }
    } else if (from == 'Dekameter') {
      if (to == 'Meter') {
        return length * 10;
      } else if (to == 'Kilometer') {
        return length / 100;
      } else if (to == 'Hektometer') {
        return length / 10;
      } else if (to == 'Centimeter') {
        return length * 1000;
      } else if (to == 'Milimeter') {
        return length * 10000;
      }
    } else if (from == 'Centimeter') {
      if (to == 'Meter') {
        return length / 100;
      } else if (to == 'Kilometer') {
        return length / 100000;
      } else if (to == 'Hektometer') {
        return length / 10000;
      } else if (to == 'Dekameter') {
        return length / 1000;
      } else if (to == 'Milimeter') {
        return length * 10;
      }
    } else if (from == 'Milimeter') {
      if (to == 'Meter') {
        return length / 1000;
      } else if (to == 'Kilometer') {
        return length / 1000000;
      } else if (to == 'Hektometer') {
        return length / 100000;
      } else if (to == 'Dekameter') {
        return length / 10000;
      } else if (to == 'Centimeter') {
        return length / 10;
      }
    }

    return length; // Default jika unit tidak valid
  }

  void calculateConversion() {
    double inputLength = double.tryParse(inputLengthController.text) ?? 0.0;
    double result = convertLength(inputLength, selectedUnitFrom, selectedUnitTo);
    resultController.text = result.toStringAsFixed(2);
  }

  @override
  void initState() {
    super.initState();
    inputLengthController.addListener(() {
      calculateConversion();
    });
    inputLengthController.text = "0.0"; // Set default value
    calculateConversion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Konversi Satuan Panjang',
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
              Text('Masukkan angka:'),
              TextField(
                controller: inputLengthController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16.0),
              Text('Konversi dari:'),
              DropdownButton<String>(
                value: selectedUnitFrom,
                items: lengthUnits.map((String unit) {
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
              Text('Konversi ke:'),
              DropdownButton<String>(
                value: selectedUnitTo,
                items: lengthUnits.map((String unit) {
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
              Text('Hasil'),
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
