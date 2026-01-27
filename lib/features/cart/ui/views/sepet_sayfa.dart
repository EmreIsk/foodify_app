import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodify_app/features/cart/data/entity/sepet_yemekler.dart';
import 'package:foodify_app/features/cart/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:foodify_app/features/cart/ui/widgets/sepet_yemek_row.dart';

class SepetSayfa extends StatefulWidget {
  const SepetSayfa({super.key});

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {
  @override
  void initState() {
    super.initState();
    // Kullanıcı adını Cubit'e uygun şekilde gönderdiğinden emin ol
    context.read<SepetSayfaCubit>().sepetiYukle();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sepetim",
            style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<SepetSayfaCubit, List<SepetYemekler>>(
        builder: (context, sepetListesi) {
          if (sepetListesi.isNotEmpty) {
            double toplamTutar = 0;
            for (var item in sepetListesi) {
              toplamTutar += (int.parse(item.yemekFiyat) *
                  int.parse(item.yemekSiparisAdet));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: sepetListesi.length,
                    itemBuilder: (context, index) {
                      var sepetYemek = sepetListesi[index];
                      return SepetYemekRow(sepetYemek: sepetYemek);
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, -5))
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Toplam Tutar",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          Text(
                            "${toplamTutar.toInt()} ₺",
                            style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepOrange),
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Siparişiniz alındı!")));
                          },
                          child: const Text("SEPETİ ONAYLA",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
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
                  Icon(Icons.shopping_cart_outlined,
                      size: 100, color: Colors.grey),
                  SizedBox(height: 20),
                  Text("Sepetiniz Boş",
                      style: TextStyle(fontSize: 24, color: Colors.grey)),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}