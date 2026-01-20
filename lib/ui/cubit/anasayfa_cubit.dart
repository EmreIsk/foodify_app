import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodify_app/data%20/entity/yemekler.dart';
import 'package:foodify_app/data%20/repo/yemekler_dao_repostiory.dart';


class AnasayfaCubit extends Cubit<List<Yemekler>> {
  // Cubit oluşturulduğunda Repo'ya erişim sağlıyoruz
  var yrepo = YemeklerDaoRepository();

  AnasayfaCubit() : super(<Yemekler>[]);

  // Uygulama açıldığında veya yenilendiğinde çalışacak
  Future<void> yemekleriYukle() async {
    var liste = await yrepo.yemekleriYukle();
    emit(liste); // Arayüze "Yeni liste bu, kendini güncelle" diyoruz.
  }
}