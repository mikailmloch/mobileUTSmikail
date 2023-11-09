import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class nilaiScreen extends StatefulWidget {
  @override
  _nilaiScreenState createState() => _nilaiScreenState();
}

class _nilaiScreenState extends State<nilaiScreen> {
  TextEditingController utsController = TextEditingController();
  TextEditingController uasController = TextEditingController();
  TextEditingController tugas1Controller = TextEditingController();
  TextEditingController tugas2Controller = TextEditingController();
  double nilaiAkhir = 0.0;
  String indexNilai = '';

  void calculateNilaiAkhir() {
    double uts = double.parse(utsController.text);
    double uas = double.parse(uasController.text);
    double tugas1 = double.parse(tugas1Controller.text);
    double tugas2 = double.parse(tugas2Controller.text);
    double nilai = (uts * 0.3) + (uas * 0.35) + (tugas1 * 0.2) + (tugas2 * 0.3);
    setState(() {
      nilaiAkhir = nilai;
      if (nilai >= 85 && nilai <= 100) {
        indexNilai = 'A';
      } else if (nilai >= 70 && nilai < 85) {
        indexNilai = 'B';
      } else if (nilai >= 60 && nilai < 70) {
        indexNilai = 'C';
      } else if (nilai >= 30 && nilai < 50) {
        indexNilai = 'D';
      } else {
        indexNilai = 'E';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    utsController.addListener(() {
      calculateNilaiAkhir();
    });
    uasController.addListener(() {
      calculateNilaiAkhir();
    });
    tugas1Controller.addListener(() {
      calculateNilaiAkhir();
    });
    tugas2Controller.addListener(() {
      calculateNilaiAkhir();
    });
    utsController.text = "0.0"; // Set default value
    uasController.text = "0.0"; // Set default value
    tugas1Controller.text = "0.0"; // Set default value
    tugas2Controller.text = "0.0"; // Set default value
    calculateNilaiAkhir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Penghitung Nilai',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Color.fromRGBO(80, 59, 163, 1),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: utsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'UTS',
              ),
            ),
            TextField(
              controller: uasController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'UAS',
              ),
            ),
            TextField(
              controller: tugas1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Tugas 1',
              ),
            ),
            TextField(
              controller: tugas2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Tugas 2',
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Nilai Akhir: $nilaiAkhir',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Index Nilai: $indexNilai',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
