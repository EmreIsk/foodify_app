import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodify_app/features/home/data/entity/yemekler.dart';
import 'package:foodify_app/features/home/ui/cubit/anasayfa_cubit.dart';
import 'package:foodify_app/features/cart/ui/views/sepet_sayfa.dart';
import 'package:foodify_app/features/home/ui/widgets/home_empty_state.dart';
import 'package:foodify_app/features/home/ui/widgets/home_search_bar.dart';
import 'package:foodify_app/ui/widgets/yemek_karti.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {


  @override
  void initState() {
    super.initState();
    context.read<AnasayfaCubit>().yemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. ÜST BAR (APPBAR)
      appBar: AppBar(
        title: const Text(
            "Foodify",
            style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SepetSayfa()));
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),

      // 2. GÖVDE TASARIMI (COLUMN)
      body: Column(
        children: [
          // ARAMA ALANI
          const HomeSearchBar(),

          // LİSTELEME ALANI
          Expanded(
            child: BlocBuilder<AnasayfaCubit, List<Yemekler>>(
              builder: (context, yemeklerListesi) {
                // EĞER LİSTE DOLUYSA
                if (yemeklerListesi.isNotEmpty) {
                  return GridView.builder(
                    itemCount: yemeklerListesi.length,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.5,
                    ),
                    itemBuilder: (context, index) {
                      var yemek = yemeklerListesi[index];
                      return YemekKarti(yemek: yemek);
                    },
                  );
                }
                // Arama sonucu boşsa
                else {
                  return const HomeEmptyState();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}