import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodify_app/data%20/entity/yemekler.dart';
import 'package:foodify_app/ui/cubit/anasayfa_cubit.dart';
import 'package:foodify_app/ui/views/detay_sayfa.dart';
import 'package:foodify_app/ui/views/sepet_sayfa.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
      appBar: AppBar(
        title: const Text("Foodify", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              // Sepet sayfasına geçiş
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SepetSayfa()));
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: BlocBuilder<AnasayfaCubit, List<Yemekler>>(
        builder: (context, yemeklerListesi) {
          if (yemeklerListesi.isNotEmpty) {
            return GridView.builder(
              itemCount: yemeklerListesi.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1.5,
              ),
              itemBuilder: (context, index) {
                var yemek = yemeklerListesi[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetaySayfa(yemek: yemek)));
                  },
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // 1. Resim
                        Hero(
                          tag: yemek.yemekId,
                          child: CachedNetworkImage(
                            imageUrl: "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemekResimAdi}",
                            height: 110,
                            fit: BoxFit.contain,
                          ),
                        ),
                        // 2. Yemek Adı
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            yemek.yemekAdi,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        // 3. Fiyat ve Ekleme İkonu Satırı
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${yemek.yemekFiyat} ₺",
                                style: const TextStyle(fontSize: 16, color: Color(0xFFFF6D00), fontWeight: FontWeight.w700),
                              ),
                              const Icon(Icons.add_shopping_cart_rounded, color: Color(0xFFFF6D00)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}