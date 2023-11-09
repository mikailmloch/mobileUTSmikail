import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MaterialApp(
  home: calculatorScreen(),
));

class calculatorScreen extends StatefulWidget {
  @override
  _calculatorScreenState createState() => _calculatorScreenState();
}

class _calculatorScreenState extends State<calculatorScreen> {
  String _input = ''; // Menyimpan input dari pengguna
  String _result = ''; // Menyimpan hasil perhitungan

  // Fungsi untuk menambahkan angka atau operator ke input
  void _addToInput(String value) {
    setState(() {
      _input += value;
    });
  }

  // Fungsi untuk menghitung hasil perhitungan
  Future<void> _calculateResult() async {
    try {
      Parser p = Parser();
      Expression exp = p.parse(_input);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      String result = eval.toString();

      // Menunggu sebentar untuk memberikan kesan bahwa perhitungan berlangsung
      await Future.delayed(Duration(milliseconds: 1));

      setState(() {
        _result = result;
      });
    } catch (e) {
      setState(() {
        _result = 'Error';
      });
    }
  }

  // Fungsi untuk menghapus semua input
  void _clearInput() {
    setState(() {
      _input = '';
      _result = '';
    });
  }

  // Fungsi untuk menghapus karakter terakhir dari input
  void _removeLastCharacter() {
    setState(() {
      if (_input.isNotEmpty) {
        _input = _input.substring(0, _input.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kalkulator',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Color.fromRGBO(80, 59, 163, 1),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            _input,
            style: TextStyle(fontSize: 24),
          ),
          Text(
            _result,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CalculatorButton('7', () => _addToInput('7')),
              CalculatorButton('8', () => _addToInput('8')),
              CalculatorButton('9', () => _addToInput('9')),
              CalculatorButton('+', () => _addToInput('+')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CalculatorButton('4', () => _addToInput('4')),
              CalculatorButton('5', () => _addToInput('5')),
              CalculatorButton('6', () => _addToInput('6')),
              CalculatorButton('-', () => _addToInput('-')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CalculatorButton('1', () => _addToInput('1')),
              CalculatorButton('2', () => _addToInput('2')),
              CalculatorButton('3', () => _addToInput('3')),
              CalculatorButton('*', () => _addToInput('*')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CalculatorButton('C', () => _clearInput()),
              CalculatorButton('0', () => _addToInput('0')),
              CalculatorButton('=', () => _calculateResult()),
              CalculatorButton('/', () => _addToInput('/')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CalculatorButton('√', () => _addToInput('sqrt(')),
              CalculatorButton('^', () => _addToInput('^')),
              CalculatorButton('log', () => _addToInput('log(')),
              CalculatorButton('exp', () => _addToInput('exp(')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CalculatorButton('sin', () => _addToInput('sin(')),
              CalculatorButton('cos', () => _addToInput('cos(')),
              CalculatorButton('tan', () => _addToInput('tan(')),
              CalculatorButton('(', () => _addToInput('(')),
              CalculatorButton(')', () => _addToInput(')')),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CalculatorButton('π', () => _addToInput('pi')),
              CalculatorButton('e', () => _addToInput('e')),
            ],
          ),
          CalculatorButton('⌫', () => _removeLastCharacter()),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  CalculatorButton(this.text, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      child: Text(
        text,
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
