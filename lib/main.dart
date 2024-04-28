import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:soccer_grid/pages/home_page.dart';
import 'package:soccer_grid/providers/home_page_refresh.dart';
import 'package:soccer_grid/providers/player_name_provider.dart';
import 'package:soccer_grid/providers/points_provider.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  runApp(
    const MyApp(),
    );
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [ChangeNotifierProvider(create: (context)=>PointsProvider()),
        ChangeNotifierProvider(create: (context)=>NameProvider()),
        ChangeNotifierProvider(create: (context)=>HomePageModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
        // home: const HomePage(),
        title: "Soccer Grid",
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.black,
            primary: Colors.blue
          ),
      
          textTheme: const TextTheme(
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),
            
            titleMedium: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15
            )
      
            
          )
        ),
      ),
    );
  }
}