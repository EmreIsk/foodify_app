import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodify_app/features/home/data/entity/yemekler.dart';
import 'package:foodify_app/features/product_detail/ui/cubit/detay_sayfa_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetaySayfa extends StatefulWidget {

  final Yemekler yemek;

  const DetaySayfa({super.key, required this.yemek});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  int adet = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ürün Detayı", style: TextStyle(fontFamily: "Poppins")),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Hero(
              tag: widget.yemek.yemekId, // Anasayfadaki ile AYNI tag olmalı
              child: CachedNetworkImage(
                imageUrl: "http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemekResimAdi}",
                height: 250,
              ),
            ),

            // 2. FİYAT BİLGİSİ
            Text(
              "${widget.yemek.yemekFiyat} ₺",
              style: const TextStyle(fontSize: 30, color: Colors.deepOrange, fontWeight: FontWeight.bold),
            ),

            // 3. YEMEK ADI
            Text(
              widget.yemek.yemekAdi,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            // 4. ADET SEÇİMİ (Sayaç)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Azaltma Butonu
                Container(
                  decoration: BoxDecoration(color: Colors.deepOrange, borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        if (adet > 1) {
                          adet--;
                        }
                      });
                    },
                    icon: const Icon(Icons.remove, color: Colors.white),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "$adet",
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.deepOrange, borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        adet++;
                      });
                    },
                    icon: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),

            // 5. SEPETE EKLE BUTONU VE TOPLAM TUTAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepOrange,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    int fiyat = int.parse(widget.yemek.yemekFiyat);
                    int toplamTutar = fiyat * adet;

                    context.read<DetaySayfaCubit>().sepeteEkle(
                      widget.yemek.yemekAdi,
                      widget.yemek.yemekResimAdi,
                      fiyat,
                      adet,
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${widget.yemek.yemekAdi} sepete eklendi!"),
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                  child: Text(
                    "Sepete Ekle • ${int.parse(widget.yemek.yemekFiyat) * adet} ₺",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}