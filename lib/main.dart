import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_venturo/state/menus_state.dart';
import 'package:test_venturo/view/menu/menu_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MenuState(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/menu': (_) => const MenuPage(),
        },
        home: const MenuPage(),
      ),
    );
  }
}
