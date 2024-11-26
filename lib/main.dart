import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String displayText = "0";
  double result = 0;
  String operation = "";
  double? firstOperand;

  void buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        displayText = "0";
        result = 0;
        operation = "";
        firstOperand = null;
      } else if (value == "=") {
        if (firstOperand != null && operation.isNotEmpty) {
          double secondOperand = double.tryParse(displayText) ?? 0;
          if (operation == "+") result = firstOperand! + secondOperand;
          if (operation == "-") result = firstOperand! - secondOperand;
          if (operation == "*") result = firstOperand! * secondOperand;
          if (operation == "/") result = firstOperand! / secondOperand;
          if (operation == "x^2") result = pow(firstOperand!, 2).toDouble();
          if (operation == "√") result = sqrt(firstOperand!);
          if (operation == "1/x") result = 1 / firstOperand!;

          displayText = result.toString();
          firstOperand = null;
          operation = "";
        }
      } else if (["+", "-", "*", "/", "x^2", "√", "1/x"].contains(value)) {
        firstOperand = double.tryParse(displayText) ?? 0;
        operation = value;
        displayText = "0";
      } else {
        displayText = displayText == "0" ? value : displayText + value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculator PH"),
      ),
      body: Column(
        
        children: [
          Container(
            padding: EdgeInsets.all(16),
            alignment: Alignment.centerRight,
            child: Text(
              displayText,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              padding: EdgeInsets.all(8),
              children: buttons.map((button) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    onPressed: () => buttonPressed(button),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      button,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

const List<String> buttons = [
  "1", "2", "3", "4",
  "5", "6", "7", "8",
  "9", "0", "+", "-",
  "*", "/", "x^2", "√",
  "1/x", "Cos", "Sin", "Tan",
          "=", "C"
];
