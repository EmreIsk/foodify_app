import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:foodify_app/features/cart/data/entity/sepet_yemekler.dart';

class CartRepository {
  var dio = Dio();
  String kullaniciAdi = "emre_proje";

  // 2. Sepete Yemek Ekle
  Future<void> sepeteEkle(String yemekAdi, String yemekResimAdi, int yemekFiyat, int yemekSiparisAdet) async {
    String url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";

    var veri = {
      "yemek_adi": yemekAdi,
      "yemek_resim_adi": yemekResimAdi,
      "yemek_fiyat": yemekFiyat.toString(),
      "yemek_siparis_adet": yemekSiparisAdet.toString(),
      "kullanici_adi": kullaniciAdi,
    };

    try {
      await dio.post(url, data: FormData.fromMap(veri));
    } catch (e) {
      debugPrint("Sepete Ekle Hata: $e");
    }
  }

  // 3. Sepetteki Yemekleri Getir
  Future<List<SepetYemekler>> sepetiYukle() async {
    String url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi": kullaniciAdi};

    try {
      var cevap = await dio.post(url, data: FormData.fromMap(veri));
      var jsonNesnesi = json.decode(cevap.data.toString());

      if (jsonNesnesi["sepet_yemekler"] != null) {
        var sepetListesi = jsonNesnesi["sepet_yemekler"] as List;
        List<SepetYemekler> sepetNesneleri = sepetListesi.map((json) => SepetYemekler.fromJson(json)).toList();
        return sepetNesneleri;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  // 4. Sepetten Yemek Sil
  Future<void> sepettenSil(int sepetYemekId) async {
    String url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";

    var veri = {
      "sepet_yemek_id": sepetYemekId.toString(),
      "kullanici_adi": kullaniciAdi,
    };

    try {
      await dio.post(url, data: FormData.fromMap(veri));
    } catch (e) {
      debugPrint("Sepetten Sil Hata: $e");
    }
  }
}
