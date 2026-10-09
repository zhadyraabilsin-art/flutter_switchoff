import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MultiColorThemeModel(),
      child: const MyApp(),
    ),
  );
}

// 1. Көп түсті күй моделі (Provider)
class MultiColorThemeModel extends ChangeNotifier {
  // Түстер тізімі (Осы тізімге қалағанша түс қосуға болады)
  final List<Color> _colors = [
    Colors.deepPurpleAccent,
    Colors.lightGreenAccent,
    Colors.redAccent,
    Colors.blueAccent,
    Colors.orangeAccent,
    Colors.pinkAccent,
    Colors.cyanAccent,
  ];

  // Ағымдағы түстің индексі
  int _currentColorIndex = 0;

  // Свитчтің күйі (тек батырма ретінде қолданамыз, бірақ ауысу логикасы басқаша)
  bool _isSwitched = false;
  bool get isSwitched => _isSwitched;

  // Ағымдағы таңдалған түсті алу (Квадрат үшін де, мәтін үшін де)
  Color get currentColor => _colors[_currentColorIndex];

  // Түсті келесісіне ауыстыру функциясы
  void changeColor(bool value) {
    _isSwitched = value;

    // Индексті келесіге жылжыту
    _currentColorIndex = (_currentColorIndex + 1) % _colors.length;

    // Виджеттерді жаңарту
    notifyListeners();
  }
}

// 2. Бас виджет
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeworkProviderScreen(),
    );
  }
}

// 3. Тапсырма экраны
class HomeworkProviderScreen extends StatelessWidget {
  const HomeworkProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Түстер моделін тыңдау
    final colorModel = Provider.of<MultiColorThemeModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          'Homework Provider',
          style: TextStyle(
            // Мәтін түсі Квадрат түсімен бірдей болады
            color: colorModel.currentColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ауысып тұратын квадрат
            Container(
              width: 200,
              height: 200,
              color: colorModel.currentColor, // Квадрат түсі моделден алынады
            ),
            const SizedBox(height: 30),
            // Түсті ауыстырушы "Кнопка" (Switch)
            Switch(
              value: colorModel.isSwitched,
              onChanged: (bool newValue) {
                // Түсті ауыстыру функциясын шақыру
                colorModel.changeColor(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }
}
