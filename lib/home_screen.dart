import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'butttons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
// list of characters for  buttons
  final List<String> _buttonTexts = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    '00',
    '=',
  ];

  // for display fields
  String _question = '';

  String _answer = '00.0';

//
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Column(
        // this column has 2 expanded widgets
        children: [
          //  display
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                //question
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      _question,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                // Answer
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    alignment: Alignment.bottomRight,
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      _answer,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                // iam kailas
                const Text(
                  '   Created by Kailas.',
                  style: TextStyle(
                    color: Colors.white24,
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                  ),
                )
              ],
            ),
          ),
          //  buttons
          Expanded(
            flex: 2,
            child: GridView.builder(
              itemCount: _buttonTexts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              ),
              itemBuilder: (BuildContext context, int index) {
                if (_buttonTexts[index] == 'C') {
                  //clear button
                  return MyButton(
                    onTapped: () {
                      setState(() {
                        _question = '';
                        _answer = '';
                      });
                    },
                    buttonColor: Colors.green,
                    textColor: Colors.white,
                    textOfButton: _buttonTexts[index],
                  );
                } else if (_buttonTexts[index] == 'DEL') {
                  // delete button
                  return MyButton(
                    onTapped: () {
                      setState(() {
                        _question =
                            _question.substring(0, _question.length - 1);
                      });
                    },
                    buttonColor: Colors.red,
                    textColor: Colors.white,
                    textOfButton: _buttonTexts[index],
                  );
                  //
                } else if (_buttonTexts[index] == '=') {
                  // equals button
                  return MyButton(
                    onTapped: () {
                      setState(() {
                        equalButtonPressed();
                      });
                    },
                    buttonColor: Colors.blue,
                    textColor: Colors.white,
                    textOfButton: _buttonTexts[index],
                  );
                } else {
                  return MyButton(
                    onTapped: () {
                      setState(() {
                        _question += _buttonTexts[index];
                      });
                    },
                    buttonColor: isOperand(_buttonTexts[index])
                        ? const Color.fromARGB(73, 255, 255, 255)
                        : const Color.fromARGB(55, 255, 255, 255),
                    textColor: Colors.white,
                    textOfButton: _buttonTexts[index],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // changing the color of operands
  bool isOperand(String texts) {
    if (texts == '%' ||
        texts == '/' ||
        texts == 'x' ||
        texts == '-' ||
        texts == '+' ||
        texts == '=') {
      return true;
    } else {
      return false;
    }
  }
  // math expression package usage

  void equalButtonPressed() {
    String finalQuestion = _question;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    _answer = eval.toString();
  }
}
