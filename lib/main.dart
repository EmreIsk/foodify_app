import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodify_app/ui/cubit/anasayfa_cubit.dart';
import 'package:foodify_app/ui/cubit/detay_sayfa_cubit.dart';
import 'package:foodify_app/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:foodify_app/ui/views/anasayfa.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MultiBlocProvider ile cubitleri sisteme tanıttım
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AnasayfaCubit()),
        BlocProvider(create: (context) => DetaySayfaCubit()),
        BlocProvider(create: (context) => SepetSayfaCubit()),
      ],
      child: MaterialApp(
        title: 'Foodify',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFFF6D00),
            primary: const Color(0xFFFF6D00),
            secondary: const Color(0xFF263238),
          ),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(color: Colors.black87, fontSize: 22, fontWeight: FontWeight.bold),
            iconTheme: IconThemeData(color: Colors.black87),
          ),
        ),
        home: const Anasayfa(),
      ),
    );
  }
}