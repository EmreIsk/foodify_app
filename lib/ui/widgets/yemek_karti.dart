import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodify_app/data%20/entity/yemekler.dart';
import 'package:foodify_app/ui/views/detay_sayfa.dart';

class YemekKarti extends StatelessWidget {
  final Yemekler yemek;

  const YemekKarti({super.key, required this.yemek});

  @override
  Widget build(BuildContext context) {
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
            BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 5, offset: const Offset(0, 3)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Hero(
              tag: yemek.yemekId,
              child: CachedNetworkImage(
                imageUrl: "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemekResimAdi}",
                height: 110,
                fit: BoxFit.contain,
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                yemek.yemekAdi,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ),
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
  }
}