import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora de diversidade',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShannonCalculator(),
    );
  }
}

class ShannonCalculator extends StatefulWidget {
  @override
  _ShannonCalculatorState createState() => _ShannonCalculatorState();
}

class _ShannonCalculatorState extends State<ShannonCalculator> {
  final _formKey = GlobalKey<FormState>();
  final _controllerHomo = TextEditingController();
  final _controllerHetero = TextEditingController();
  final _controllerBi = TextEditingController();
  final _controllerAssex = TextEditingController();
  final _controllerPan = TextEditingController();

  double _shannonIndex = 0.0;

  void _calculateShannonIndex() {
    if (_formKey.currentState!.validate()) {
      int homo = int.parse(_controllerHomo.text);
      int hetero = int.parse(_controllerHetero.text);
      int bi = int.parse(_controllerBi.text);
      int assex = int.parse(_controllerAssex.text);
      int pan = int.parse(_controllerPan.text);

      int total = homo + hetero + bi + assex + pan;

      if (total == 0) {
        setState(() {
          _shannonIndex = 0.0;
        });
        return;
      }

      double hIndex = 0.0;
      List<int> counts = [homo, hetero, bi, assex, pan];

      for (int count in counts) {
        if (count > 0) {
          double proportion = count / total;
          hIndex -= proportion * log(proportion);
        }
      }

      setState(() {
        _shannonIndex = hIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora Índice de Shannon'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _controllerHomo,
                decoration:
                    InputDecoration(labelText: 'Número de Homossexuais'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um valor';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controllerHetero,
                decoration:
                    InputDecoration(labelText: 'Número de Heterossexuais'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um valor';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controllerBi,
                decoration: InputDecoration(labelText: 'Número de Bissexuais'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um valor';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controllerAssex,
                decoration: InputDecoration(labelText: 'Número de Assexuais'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um valor';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _controllerPan,
                decoration: InputDecoration(labelText: 'Número de Pansexuais'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um valor';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateShannonIndex,
                child: Text('Calcular Índice de Shannon'),
              ),
              SizedBox(height: 20),
              Text(
                'Índice de Shannon: ${_shannonIndex.toStringAsFixed(4)}',
                style: TextStyle(fontSize: 24),
              ),
              Text('Ana Laura')
            ],
          ),
        ),
      ),
    );
  }
}
