import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodify_app/features/auth/ui/cubit/auth_cubit.dart';
import 'package:foodify_app/ui/widgets/custom_button.dart';
import 'package:foodify_app/ui/widgets/custom_text_field.dart';

class KayitSayfa extends StatefulWidget {
  const KayitSayfa({super.key});

  @override
  State<KayitSayfa> createState() => _KayitSayfaState();
}

class _KayitSayfaState extends State<KayitSayfa> {
  var tfEmail = TextEditingController();
  var tfPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=2070'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(color: Colors.black.withValues(alpha: 0.7)),
          ),

          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 20),

                      const Text('Aramıza Katıl', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 40),

                      CustomTextField(
                          controller: tfEmail,
                          label: 'Email',
                          hint: 'ad@ornek.com',
                          icon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Email boş bırakılamaz';
                            if (!value.contains('@')) return 'Geçerli bir email giriniz';
                            return null;
                          }
                      ),
                      const SizedBox(height: 20),
                      const SizedBox(height: 20),
                      CustomTextField(
                          controller: tfPassword,
                          label: 'Şifre Belirle',
                          hint: 'En az 6 karakter',
                          isPassword: true,
                          icon: Icons.lock_outline,
                          validator: (value) {
                            if (value == null || value.isEmpty) return 'Şifre boş bırakılamaz';
                            if (value.length < 6) return 'Şifre en az 6 karakter olmalı';
                            return null;
                          }
                      ),
                      const SizedBox(height: 40),
                      CustomButton(
                        text: 'Hesap Oluştur',
                        onPressed: () async { // 1. Buraya 'async' ekliyoruz
                            if (_formKey.currentState!.validate()) {
                              try {
                                // 2. İşlemin bitmesini bekle (await)
                                await context.read<AuthCubit>().kayitOl(tfEmail.text, tfPassword.text);

                                // 3. KRİTİK KONTROL: İşlem bittiğinde bu sayfa hala ekranda mı?
                                if (!context.mounted) return;

                                // 4. Ekranda ise Diyaloğu göster
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => AlertDialog(
                                    title: const Text("Kayıt Başarılı!"),
                                    content: const Text("Hesabınız oluşturuldu. Lütfen e-posta adresinize gelen doğrulama linkine tıklayıp giriş yapınız. Spam kutunuzu da kontrol ediniz!"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context); // Dialogu kapat
                                          Navigator.pop(context); // Giriş ekranına dön
                                        },
                                        child: const Text("Tamam"),
                                      )
                                    ],
                                  ),
                                );
                              } catch (hata) {
                                // 5. Hata durumunda da context kontrolü şart
                                if (!context.mounted) return;

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(hata.toString()), backgroundColor: Colors.red),
                                );
                              }
                            }
                          },
                      ),
                      // --------------------------------
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