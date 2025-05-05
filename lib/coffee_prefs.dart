import 'package:flutter/material.dart';

class CoffeePrefs extends StatefulWidget {
  const CoffeePrefs({super.key});

  @override
  State<CoffeePrefs> createState() => _CoffeePrefsState();
}

class _CoffeePrefsState extends State<CoffeePrefs> {
  int strength = 1;
  int sugars = 1;
  void increaseSugar() {
    setState(() {
      sugars = sugars < 5 ? sugars += 1 : 0;
    });
  }

  void increaseStrength() {
    setState(() {
      strength = strength < 5 ? strength += 1 : 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text('Strength: '),
            for (int i = 0; i < strength; i++)
              Image.asset('img/coffee_bean.png', width: 25),
            const Expanded(child: SizedBox()),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.brown,
              ),
              onPressed: increaseStrength,
              child: const Text('+'),
            ),
          ],
        ),
        Row(
          children: [
            const Text('Sucre: '),
            Text('  '),
            if (sugars == 0) Text('Sans sucre'),
            for (int i = 0; i < sugars; i++)
              Image.asset('img/sugar_cube.png', width: 25),
            const Expanded(child: SizedBox()),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.brown,
              ),
              onPressed: increaseSugar,
              child: const Text('+'),
            ),
          ],
        ),
      ],
    );
  }
}
