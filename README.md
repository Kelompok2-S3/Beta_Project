# Beta Project

Beta Project adalah aplikasi showcase otomotif berbasis Flutter yang dikembangkan oleh tim Kelompok2-S3. Aplikasi ini menampilkan katalog kendaraan dari berbagai brand, presentasi visual sinematik (video background), fitur pencarian, carousel model, dan halaman detail model yang lengkap.

README ini berisi ringkasan fitur, arsitektur singkat (file kode yang relevan), petunjuk menjalankan aplikasi secara lokal pada lingkungan pengembangan, serta tabel tim untuk dicantumkan.

---

## Fitur Utama

- Cinematic Hero Section (video background, parallax, mute/unmute)
- Splash screen dan routing dengan deep-link (`/splash`, `/car/:name`)
- Carousel model interaktif
- Pencarian real-time dengan thumbnail (SearchDelegate)
- Halaman detail mobil lengkap (spesifikasi, harga terformat, sticky header)
- Section tematik: Featured, Promo, Discover, Video Promo
- State management menggunakan BLoC / Cubits (MenuCubit, ScrollCubit, VideoMuteCubit)
- Tema gelap dan tipografi menggunakan `GoogleFonts`
- Manajemen aset terstruktur (`assets/images/` dan `assets/videos/`)

---

## Struktur Kode (File penting dan peranannya)

- `lib/main.dart` — Entrypoint aplikasi, menginisialisasi `MaterialApp.router`.
- `lib/router.dart` — Definisi route (`/splash`, `/`, `/car/:name`).
- `lib/screens/home_screen.dart` — Tampilan utama yang menyusun hero + sections.
- `lib/widgets/cinematic_hero_section.dart` — Implementasi video background dan efek parallax.
- `lib/widgets/video_promo_section.dart` — Section promo yang dapat memutar video atau menampilkan gambar fallback.
- `lib/widgets/car_search_delegate.dart` — Logika pencarian real-time.
- `lib/screens/car_detail_screen.dart` — Halaman detail model dengan spec dan sticky header.
- `lib/data/car_repository.dart` — `CarRepositoryImpl` (singleton) yang menyimpan data model dan brand.
- `lib/widgets/*` — Berbagai widget section: `featured_section.dart`, `promo_section.dart`, `models_section.dart`, dll.
- `lib/cubits/*` — Cubits untuk mengatur menu, scroll, dan mute state.

---

## Catatan Dependensi

Beberapa paket tercantum di `pubspec.yaml`. Paket-paket yang *tersedia dan digunakan* di kode saat ini termasuk:

- `video_player` — pemutaran video (digunakan di `cinematic_hero_section` dan `video_promo_section`).
- `flutter_bloc` — state management (Cubit/BLoC).
- `go_router` — routing modern dan deep-link.
- `google_fonts` — tipografi.
- `intl` — format harga.

Paket-paket yang tercantum di `pubspec.yaml` tetapi saat ini **belum** dipakai di folder `lib/`:

- `chewie` — ada di dependensi, namun kode menggunakan `video_player` langsung. Pertimbangkan integrasi `chewie` jika membutuhkan kontrol player siap-pakai (progress bar, fullscreen, controls).
- `dio` — tercantum tapi tidak ditemukan penggunaan `Dio` dalam kode saat ini; cocok bila Anda menambahkan backend/REST API.
- `sizer` — tercantum namun tidak terpakai; layout responsif saat ini menggunakan `MediaQuery` dan sizing manual.

---

## Prasyarat (Prerequisites)

- Flutter SDK (direkomendasikan versi sesuai `environment` di `pubspec.yaml`, minimal Dart SDK 3.9+)
- Git (opsional, untuk clone repo)
- Untuk Windows: PowerShell (instruksi di bawah menggunakan PowerShell)

---

## Cara Menjalankan Aplikasi (Windows / PowerShell)

1. Buka PowerShell dan masuk ke folder proyek:

```powershell
cd D:\Beta_Project
```

2. Ambil dependency:

```powershell
flutter pub get
```

3. Jalankan aplikasi pada device/emulator yang terhubung (contoh: Android emulator atau device):

```powershell
flutter run
```

4. Untuk menjalankan versi web (mis. debug di browser):

```powershell
flutter config --enable-web
flutter run -d chrome
```

5. Jika ingin build release (contoh Android APK):

```powershell
flutter build apk --release
```

Catatan: Jika mengalami error terkait dependensi atau versi SDK, jalankan `flutter doctor` untuk diagnosis.

---

## Verifikasi Fungsional Singkat

- Setelah `flutter run`, Anda seharusnya melihat `SplashScreen` lalu `HomeScreen`.
- Pada `HomeScreen`, hero video (assets/videos/Forza4.mp4) akan diputar jika tersedia; tombol suara ada di hero untuk mute/unmute.
- Coba scroll untuk melihat parallax dan sticky header pada detail screen.
- Gunakan ikon pencarian untuk membuka fitur search (hasil menampilkan thumbnail mobil).

---

## Kontribusi

Jika Anda ingin menambahkan fitur (mis. mengintegrasikan `dio` untuk API remote, atau `chewie` untuk player UI):

1. Fork repository
2. Buat branch fitur (`git checkout -b feature/nama-fitur`)
3. Tambahkan perubahan dan buat pull request

---

## Tabel Tim

Silakan isi tabel di bawah dengan data anggota tim Anda. Saya menempatkan baris contoh yang bisa Anda ganti.

| Nama | NIM | Role |
|------|-----|------|


Ubah baris sesuai data tim Anda.

---

## Kontak

- Repo: `https://github.com/Kelompok2-S3/Beta_Project` (ganti jika berbeda)
- Untuk pertanyaan teknis, hubungi tim pengembang melalui issue di GitHub atau email internal tim.

---

Terima kasih telah menggunakan Beta Project — beri tahu saya jika Anda ingin README ini dibuatkan versi singkat untuk press release, atau tambahan diagram arsitektur/diagram alur pengguna.
