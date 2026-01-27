import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodify_app/features/auth/data/repo/auth_repository.dart';

class AuthCubit extends Cubit<void> {
  AuthCubit() : super(0);

  var arepo = AuthRepository();

  Future<void> kayitOl(String email, String password) async {
    await arepo.kayitOl(email, password);
  }

  Future<void> girisYap(String email, String password) async {
    await arepo.girisYap(email, password);
  }

  Future<void> dogrulamaMailiGonder() async {
    try {
      await arepo.dogrulamaMailiGonder();
    } catch (e) {
      debugPrint("Mail gönderme hatası: $e");
    }
  }

  Future<void> tekrarDogrulamaGonder(String email, String password) async {
    await arepo.tekrarDogrulamaGonder(email, password);
  }
}