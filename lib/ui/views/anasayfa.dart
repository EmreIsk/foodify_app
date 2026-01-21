import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodify_app/data%20/entity/yemekler.dart';
import 'package:foodify_app/ui/cubit/anasayfa_cubit.dart';
import 'package:foodify_app/ui/views/sepet_sayfa.dart';
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Ne yemek istersin?",
                prefixIcon: const Icon(Icons.search, color: Colors.deepOrange),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (aramaSonucu) {
                // Her harfe basıldığında Cubit'teki 'ara' fonksiyonunu tetikle
                context.read<AnasayfaCubit>().ara(aramaSonucu);
              },
            ),
          ),

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
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.search_off, size: 80, color: Colors.grey),
                        const SizedBox(height: 10),
                        Text(
                          "Aradığınız yemek bulunamadı ",
                          style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}