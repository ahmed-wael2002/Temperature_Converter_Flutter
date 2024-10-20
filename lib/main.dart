import 'package:flutter/material.dart';

void main() {
  runApp(const TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const TemperatureConverterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TemperatureConverterPage extends StatefulWidget {
  const TemperatureConverterPage({super.key});

  @override
  _TemperatureConverterPageState createState() => _TemperatureConverterPageState();
}

class _TemperatureConverterPageState extends State<TemperatureConverterPage> {
  bool isHot = false;
  bool isCold = false;
  String fromUnit = 'Celsius';
  String toUnit = 'Kelvin';
  TextEditingController inputController = TextEditingController();
  TextEditingController outputController = TextEditingController();
  String? outputString = '';
  double? convertedValue;

  List<String> units = ['Celsius', 'Kelvin'];

  void convertTemperature() {
    double inputValue = double.tryParse(inputController.text) ?? 0;

    setState(() {
      if (fromUnit == 'Celsius' && toUnit == 'Kelvin') {
        convertedValue = inputValue + 273.0;
        isHot = (convertedValue! > (273.15 + 36));
      } else if (fromUnit == 'Kelvin' && toUnit == 'Celsius') {
        convertedValue = inputValue - 273.0;
        isHot = (convertedValue! > (36));
      } else {
        convertedValue = inputValue; // Same units, no conversion needed
      }
      outputController.text = convertedValue == null
          ? 'Output'
          : convertedValue!.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Temperature Converter', style: TextStyle(fontWeight: FontWeight.bold))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: fromUnit,
                    onChanged: (String? newValue) {
                      setState(() {
                        fromUnit = newValue!;
                      });
                    },
                    items: units.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: inputController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Enter value',
                      hintText: 'Your Value',
                      border: OutlineInputBorder(      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      )
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: DropdownButton<String>(
                    value: toUnit,
                    onChanged: (String? newValue) {
                      setState(() {
                        toUnit = newValue!;
                      });
                    },
                    items: units.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: TextField(
                    readOnly:true,
                    controller: outputController,
                    decoration: const InputDecoration(
                        labelText: 'Conversion Value',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        )
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: convertTemperature,
                child: const Text('Convert', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
              ),
            ),
            Expanded(child:Image.asset(isHot?'assets/images/hot.png':'assets/images/cold.png')),
          ],
        ),
      ),
    );
  }
}
