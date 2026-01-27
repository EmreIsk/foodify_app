import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodify_app/features/cart/data/repo/cart_repository.dart';


class DetaySayfaCubit extends Cubit<void> {
  var yrepo = CartRepository();

  DetaySayfaCubit() : super(0);

  Future<void> sepeteEkle(String yemekAdi, String yemekResimAdi, int yemekFiyat, int yemekSiparisAdet) async {
    // Repo'daki fonksiyonu tetikliyoruz
    await yrepo.sepeteEkle(yemekAdi, yemekResimAdi, yemekFiyat, yemekSiparisAdet);
  }
}