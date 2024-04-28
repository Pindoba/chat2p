import 'package:flutter/material.dart';

final meuTema = ThemeData(
  colorScheme: const ColorScheme.dark(
    background: Color.fromARGB(255, 56, 56, 56),
    primary: Colors.amber,
      ),
  primaryColor: Color.fromARGB(255, 34, 39, 38),
  indicatorColor: Colors.amber,
  hintColor: Colors.white54, 
  splashColor: Colors.black45,
  bottomNavigationBarTheme: BottomNavigationBarThemeData(elevation: 1)
  // Outras configurações de estilo, como fontes, tamanhos, etc.
  );