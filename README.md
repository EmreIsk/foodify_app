# Foodify - Yemek Sipariş Uygulaması 

Foodify, Flutter kullanılarak geliştirilmiş, modern yazılım mimarisi (MVVM) ve temiz kod prensiplerine uygun bir yemek sipariş uygulamasıdır. Kullanıcıların ürünleri listelemesine, detaylarını incelemesine ve sepete ekleyip yönetmesine olanak tanır.

##  Özellikler

- Dinamik Ürün Listeleme: REST API üzerinden anlık veri çekme ve listeleme.
- Detaylı Ürün Sayfası: Hero animasyonları ile geçiş, dinamik fiyat hesaplama ve adet seçimi.
- Gelişmiş Sepet Yönetimi: Sepete ürün ekleme, anlık toplam tutar hesaplama ve kaydırarak silme (swipe-to-delete)** özelliği.
- MVVM Mimarisi: Cubit kullanılarak UI (Arayüz) ve Logic (Mantık) katmanlarının ayrılması.
- Modern Tasarım: Kullanıcı dostu arayüz, gölgelendirmeler ve akıcı animasyonlar.

## Kullanılan Teknolojiler ve Paketler

- Framework:Flutter (Dart)
- State Management:** Flutter_Bloc (Cubit)
- Network (İnternet):** Dio (HTTP istekleri için)
- Mimari: MVVM / Repository Pattern
- UI/UX: CachedNetworkImage, Hero Animations, Google Fonts