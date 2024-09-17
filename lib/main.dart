import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalkulilo',
      theme: AppTheme(),
      home: AppHome(),
    );
  }

  ThemeData AppTheme() {
    return ThemeData(
      primaryColor: Color(0xFF00A499),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white70),
        bodySmall: TextStyle(color: Colors.white54),
        headlineLarge: TextStyle(color: Color(0xFFEA7600)),
        headlineMedium: TextStyle(color: Color(0xFF00A499)),
        headlineSmall: TextStyle(color: Colors.white),
      ),
      colorScheme: ColorScheme(
        primary: Color(0xFF00A499),
        secondary: Color(0xFFEA7600),
        onSecondaryFixedVariant: Color(0xFF394049),
        error: Colors.red,
        surface: Color(0xFFEAAA00),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onError: Colors.white,
        onSurface: Colors.black,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }
}

class AppHome extends StatelessWidget {
  const AppHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onSecondaryFixedVariant,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(
          "Calculadora de Promedios",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      body: HomeBody(),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double containerWidth = 200;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            "Promedios",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Flexible(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: containerWidth,
                crossAxisSpacing: 15,
                mainAxisSpacing: 20,
                childAspectRatio: 5 / 6,
              ),
              itemCount: 30,
              itemBuilder: (context, index) {
                return SavedGrade();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SavedGrade extends StatefulWidget {
  const SavedGrade({
    super.key,
  });

  @override
  State<SavedGrade> createState() => _SavedGradeState();
}

class _SavedGradeState extends State<SavedGrade> {
  bool _isHover = false;
  @override
  Widget build(BuildContext context) {
    BoxDecoration widgetDecoration(bool isHover) {
      return BoxDecoration(
        color: isHover ? Colors.grey.withAlpha(100) : Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black87,
            spreadRadius: 3,
            blurRadius: 10,
          ),
        ],
        border: Border.all(width: isHover ? 2 : 0),
      );
    }

    return MouseRegion(
      onEnter: (event) => setState(
        () {
          _isHover = true;
        },
      ),
      onExit: (event) => setState(
        () {
          _isHover = false;
        },
      ),
      child: Container(
        decoration: widgetDecoration(_isHover),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: Center(
                child: Container(
                  child: Text(
                    "6.8",
                    style: TextStyle(
                      color: Colors.indigo,
                      fontSize: 50,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Text(
                  "Class",
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
