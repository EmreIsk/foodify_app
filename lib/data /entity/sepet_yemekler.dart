class SepetYemekler {
  String sepetYemekId;
  String yemekAdi;
  String yemekResimAdi;
  String yemekFiyat;
  String yemekSiparisAdet;
  String kullaniciAdi;

  SepetYemekler({
    required this.sepetYemekId,
    required this.yemekAdi,
    required this.yemekResimAdi,
    required this.yemekFiyat,
    required this.yemekSiparisAdet,
    required this.kullaniciAdi,
  });

  factory SepetYemekler.fromJson(Map<String, dynamic> json) {
    return SepetYemekler(
      sepetYemekId: json['sepet_yemek_id'] as String,
      yemekAdi: json['yemek_adi'] as String,
      yemekResimAdi: json['yemek_resim_adi'] as String,
      yemekFiyat: json['yemek_fiyat'] as String,
      yemekSiparisAdet: json['yemek_siparis_adet'] as String,
      kullaniciAdi: json['kullanici_adi'] as String,
    );
  }
}