import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _display = "0";
  String _currentInput = "";
  String _operator = "";
  double? _firstOperand;

  void _onButtonPressed(String value) {
    setState(() {
      if (value == "C") {
        _display = "0";
        _currentInput = "";
        _operator = "";
        _firstOperand = null;
      } else if (value == "DEL") {
        _currentInput = _currentInput.isNotEmpty
            ? _currentInput.substring(0, _currentInput.length - 1)
            : "";
        _display = _currentInput.isEmpty ? "0" : _currentInput;
      } else if ("+-*/".contains(value)) {
        if (_firstOperand == null && _currentInput.isNotEmpty) {
          _firstOperand = double.tryParse(_currentInput);
          _operator = value;
          _currentInput = "";
        }
      } else if (value == "=") {
        if (_firstOperand != null &&
            _currentInput.isNotEmpty &&
            _operator.isNotEmpty) {
          double secondOperand = double.tryParse(_currentInput) ?? 0;
          switch (_operator) {
            case "+":
              _display = (_firstOperand! + secondOperand).toString();
              break;
            case "-":
              _display = (_firstOperand! - secondOperand).toString();
              break;
            case "*":
              _display = (_firstOperand! * secondOperand).toString();
              break;
            case "/":
              _display = secondOperand != 0
                  ? (_firstOperand! / secondOperand).toStringAsFixed(2)
                  : "Error";
              break;
          }
          _firstOperand = null;
          _currentInput = "";
          _operator = "";
        }
      } else {
        _currentInput += value;
        _display = _currentInput;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora Talento-tech"),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Text(
                _display,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _buttons.length,
              itemBuilder: (context, index) {
                final button = _buttons[index];
                return ElevatedButton(
                  onPressed: () => _onButtonPressed(button),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: button == "C" || button == "DEL"
                        ? Colors.red
                        : (button == "="
                            ? Colors.green
                            : Colors.deepPurple),
                    padding: const EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    button,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  final List<String> _buttons = [
    "7", "8", "9", "/",
    "4", "5", "6", "*",
    "1", "2", "3", "-",
    "C", "0", "=", "+",
    "DEL"
  ];
}
