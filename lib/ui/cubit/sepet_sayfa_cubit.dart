import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodify_app/data%20/entity/sepet_yemekler.dart';
import 'package:foodify_app/data%20/repo/yemekler_dao_repostiory.dart';


class SepetSayfaCubit extends Cubit<List<SepetYemekler>> {
  var yrepo = YemeklerDaoRepository();

  SepetSayfaCubit() : super(<SepetYemekler>[]);

  Future<void> sepetiYukle() async {
    var liste = await yrepo.sepetiYukle();
    emit(liste);
  }

  Future<void> sil(int sepet_yemek_id) async {
    // Önce silme işlemini yap
    await yrepo.sepettenSil(sepet_yemek_id);
    // Sonra güncel listeyi tekrar çekip arayüze gönder
    await sepetiYukle();
  }
}