import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodify_app/features/cart/data/entity/sepet_yemekler.dart';
import 'package:foodify_app/features/cart/data/repo/cart_repository.dart';


class SepetSayfaCubit extends Cubit<List<SepetYemekler>> {
  var yrepo = CartRepository();

  SepetSayfaCubit() : super(<SepetYemekler>[]);

  Future<void> sepetiYukle() async {
    var liste = await yrepo.sepetiYukle();
    emit(liste);
  }

  Future<void> sil(int sepetYemekId) async {
    // Önce silme işlemini yap
    await yrepo.sepettenSil(sepetYemekId);
    // Sonra güncel listeyi tekrar çekip arayüze gönder
    await sepetiYukle();
  }
}