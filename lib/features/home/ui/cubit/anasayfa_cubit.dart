import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodify_app/features/home/data/entity/yemekler.dart';
import 'package:foodify_app/features/home/data/repo/product_repository.dart';
import 'package:foodify_app/core/extensions/string_extensions.dart';

class AnasayfaCubit extends Cubit<List<Yemekler>> {
  // Cubit oluşturulduğunda Repo'ya erişim sağlıyoruz
  var yrepo = ProductRepository();

  AnasayfaCubit() : super(<Yemekler>[]);

  // Uygulama açıldığında veya yenilendiğinde çalışacak
  Future<void> yemekleriYukle() async {
    var liste = await yrepo.yemekleriYukle();
    emit(liste);
  }

  Future<void> ara(String aramaKelimesi) async {
    var liste = await yrepo.yemekleriYukle();

    if (aramaKelimesi.isNotEmpty) {
      var filtrelenmisListe = liste.where((yemek) {
        return yemek.yemekAdi.turkceKucukHarf.contains(aramaKelimesi.turkceKucukHarf);
      }).toList();
      emit(filtrelenmisListe);
    } else {
      emit(liste);
    }
  }
}