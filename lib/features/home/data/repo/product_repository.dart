import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:foodify_app/features/home/data/entity/yemekler.dart';

class ProductRepository {
  var dio = Dio();

  // 1. Tüm Yemekleri Getir
  Future<List<Yemekler>> yemekleriYukle() async {
    String url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";

    try {
      var cevap = await dio.get(url);
      var jsonNesnesi = json.decode(cevap.data.toString());
      var yemeklerListesi = jsonNesnesi["yemekler"] as List;

      List<Yemekler> yemekListesiNesneleri = yemeklerListesi.map((json) => Yemekler.fromJson(json)).toList();
      return yemekListesiNesneleri;

    } catch (e) {
      debugPrint("Yemekleri Yükle Hata: $e");
      return [];
    }
  }
}
