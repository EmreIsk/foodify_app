import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodify_app/features/cart/data/entity/sepet_yemekler.dart';
import 'package:foodify_app/features/cart/ui/cubit/sepet_sayfa_cubit.dart';

class SepetYemekRow extends StatelessWidget {
  final SepetYemekler sepetYemek;

  const SepetYemekRow({super.key, required this.sepetYemek});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(
              imageUrl: "http://kasimadalan.pe.hu/yemekler/resimler/${sepetYemek.yemekResimAdi}",
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
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
                    _silmeOnayi(context, sepetYemek);
                  },
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _silmeOnayi(BuildContext context, SepetYemekler sepetYemek) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Silme İşlemi"),
        content: Text("${sepetYemek.yemekAdi} sepetten silinsin mi?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("İptal"),
          ),
          TextButton(
            onPressed: () {
              context.read<SepetSayfaCubit>().sil(int.parse(sepetYemek.sepetYemekId));
              Navigator.pop(context);
            },
            child: const Text("Evet", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
