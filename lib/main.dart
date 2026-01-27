import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foodify_app/features/product_detail/ui/cubit/detay_sayfa_cubit.dart';
import 'package:foodify_app/features/cart/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:foodify_app/features/auth/ui/views/login_sayfa.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodify_app/features/home/ui/cubit/anasayfa_cubit.dart';
import 'package:foodify_app/features/auth/ui/cubit/auth_cubit.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Cubitleri sisteme tanıttık
        BlocProvider(create: (context) => AnasayfaCubit()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => DetaySayfaCubit()),
        BlocProvider(create: (context) => SepetSayfaCubit()),
      ],
      child: MaterialApp(
        title: 'Foodify',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          useMaterial3: true,
        ),
        home: const LoginSayfa(),
      ),
    );
  }
}