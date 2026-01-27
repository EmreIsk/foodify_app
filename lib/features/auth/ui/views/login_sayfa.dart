import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodify_app/features/auth/ui/cubit/auth_cubit.dart';
import 'package:foodify_app/features/home/ui/views/anasayfa.dart';
import 'package:foodify_app/features/auth/ui/views/kayit_sayfa.dart';
import 'package:foodify_app/ui/widgets/custom_button.dart';
import 'package:foodify_app/ui/widgets/custom_text_field.dart';

class LoginSayfa extends StatefulWidget {
  const LoginSayfa({super.key});

  @override
  State<LoginSayfa> createState() => _LoginSayfaState();
}

class _LoginSayfaState extends State<LoginSayfa> {
  var tfEmail = TextEditingController();
  var tfPassword = TextEditingController();

  // 1. FORM ANAHTARI OLUŞTURUYORUZ
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ARKA PLAN
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=2070'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(color: Colors.black.withValues(alpha: 0.6)),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form( // 2. BÜTÜN INPUTLARI FORM İLE SARMALIYORUZ
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(color: Colors.deepOrange, borderRadius: BorderRadius.circular(20)),
                        child: const Icon(Icons.restaurant, color: Colors.white, size: 50),
                      ),
                      const SizedBox(height: 16),
                      const Text('Foodify', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
                      const SizedBox(height: 40),

                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Tekrar Hoşgeldin', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                      ),

                      const SizedBox(height: 32),

                      // 3. VALIDATOR (KURAL) EKLEYEREK INPUTLARI ÇAĞIRIYORUZ
                      CustomTextField(
                          controller: tfEmail,
                          label: 'Email',
                          hint: 'ad@ornek.com',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Email boş bırakılamaz';
                            if (!value.contains('@') || !value.contains('.')) return 'Geçerli bir email giriniz';
                            return null;
                          }
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                          controller: tfPassword,
                          label: 'Şifre',
                          hint: '••••••••',
                          isPassword: true,
                          icon: Icons.lock_outline,
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Şifre boş bırakılamaz';
                            if (value.length < 6) return 'Şifre en az 6 karakter olmalı';
                            return null;
                          }
                      ),

                      const SizedBox(height: 24),

                      CustomButton(
                        text: 'Giriş Yap',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              // Giriş yapmayı dene
                              await context.read<AuthCubit>().girisYap(tfEmail.text, tfPassword.text);

                              if (!context.mounted) return;

                              // Başarılıysa yönlendir
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => const Anasayfa())
                              );

                            } catch (hata) {
                              if (!context.mounted) return;

                              // HATA MESAJI VE BUTON
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(hata.toString()),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 6),
                                  behavior: SnackBarBehavior.floating,

                                  //Doğrulama mailini tekrar gönder
                                  action: SnackBarAction(
                                    label: 'TEKRAR GÖNDER',
                                    textColor: Colors.white, // Buton rengi
                                    onPressed: () {
                                      // Butona basınca bu kod çalışır
                                      context.read<AuthCubit>()
                                          .tekrarDogrulamaGonder(tfEmail.text, tfPassword.text)
                                          .then((_) {
                                        if(!context.mounted) return;
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text("Doğrulama maili tekrar gönderildi!"), backgroundColor: Colors.green)
                                        );
                                      })
                                          .catchError((hata) {
                                        if(!context.mounted) return;
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(content: Text("Hata: $hata"), backgroundColor: Colors.orange)
                                        );
                                      });
                                    },
                                  ),
                                ),
                              );
                            }
                          }
                        },
                      ),

                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Hesabın yok mu? ", style: TextStyle(color: Colors.white70)),
                          GestureDetector(
                            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const KayitSayfa())),
                            child: const Text("Kayıt Ol", style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
