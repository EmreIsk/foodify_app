class Yemekler {
  String yemekId;
  String yemekAdi;
  String yemekResimAdi;
  String yemekFiyat;

  Yemekler({
    required this.yemekId,
    required this.yemekAdi,
    required this.yemekResimAdi,
    required this.yemekFiyat,
  });

  factory Yemekler.fromJson(Map<String, dynamic> json) {
    return Yemekler(
      yemekId: json['yemek_id'] as String,
      yemekAdi: json['yemek_adi'] as String,
      yemekResimAdi: json['yemek_resim_adi'] as String,
      yemekFiyat: json['yemek_fiyat'] as String,
    );
  }
}