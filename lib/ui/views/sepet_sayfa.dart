import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodify_app/data%20/entity/sepet_yemekler.dart';
import 'package:foodify_app/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SepetSayfa extends StatefulWidget {
  const SepetSayfa({super.key});

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {

  @override
  void initState() {
    super.initState();
    context.read<SepetSayfaCubit>().sepetiYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sepetim", style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<SepetSayfaCubit, List<SepetYemekler>>(
        builder: (context, sepetListesi) {
          if (sepetListesi.isNotEmpty) {
            double toplamTutar = 0;
            for (var item in sepetListesi) {
              toplamTutar += (int.parse(item.yemekFiyat) * int.parse(item.yemekSiparisAdet));
            }
            return Column(
              children: [
                // LİSTELEME ALANI
                Expanded(
                  child: ListView.builder(
                    itemCount: sepetListesi.length,
                    itemBuilder: (context, index) {
                      var sepetYemek = sepetListesi[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        elevation: 3,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            // 1. Resim
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CachedNetworkImage(
                                imageUrl: "http://kasimadalan.pe.hu/yemekler/resimler/${sepetYemek.yemekResimAdi}",
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            // 2. Bilgiler (Ad, Fiyat, Adet)
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sepetYemek.yemekAdi,
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "Fiyat: ${sepetYemek.yemekFiyat} ₺",
                                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                                  ),
                                  Text(
                                    "Adet: ${sepetYemek.yemekSiparisAdet}",
                                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            // 3. Tutar ve Sil Butonu
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${int.parse(sepetYemek.yemekFiyat) * int.parse(sepetYemek.yemekSiparisAdet)} ₺",
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // SİLME İŞLEMİ
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text("${sepetYemek.yemekAdi} silinsin mi?"),
                                          action: SnackBarAction(
                                            label: "Evet",
                                            onPressed: () {
                                              context.read<SepetSayfaCubit>().sil(int.parse(sepetYemek.sepetYemekId));
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // ALT BİLGİ VE ONAY BUTONU
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Toplam Tutar", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(
                            "${toplamTutar.toInt()} ₺",
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepOrange),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Siparişiniz alındı! (Demo)"))
                            );
                          },
                          child: const Text("SEPETİ ONAYLA", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey),
                  SizedBox(height: 20),
                  Text("Sepetiniz Boş", style: TextStyle(fontSize: 24, color: Colors.grey)),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}