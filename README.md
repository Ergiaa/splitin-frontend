---
# SplitIn: Aplikasi Pembagi Tagihan Cerdas

## Deskripsi Proyek
SplitIn adalah aplikasi mobile inovatif yang dirancang untuk menyederhanakan dan mengelola pembagian biaya dalam berbagai aktivitas kelompok, seperti makan bersama atau liburan. Aplikasi ini hadir sebagai solusi atas kerumitan dan potensi konflik dalam pembagian biaya manual. Dengan fitur-fitur seperti pembuatan grup, pencatatan pengeluaran (termasuk "Scan Struk"), pembagian tagihan otomatis, dan rekapitulasi hutang/piutang, SplitIn bertujuan untuk pengalaman pembagian biaya yang adil dan efisien.

## Tujuan Proyek
Tujuan utama pengembangan SplitIn adalah:
* Menyederhanakan dan mengotomatisasi pembagian biaya untuk mengurangi kerumitan perhitungan manual.
* Meningkatkan transparansi keuangan kelompok dengan akses real-time terhadap detail pengeluaran.
* Memfasilitasi manajemen hutang/piutang yang jelas dan pelunasan yang mudah.
* Mengurangi konflik sosial terkait penagihan biaya.
* Meningkatkan efisiensi waktu dan tenaga pengguna.

## Fitur Utama Aplikasi
Aplikasi SplitIn dilengkapi dengan fitur-fitur penting:
* **Pembuatan Grup dan Acara**: Membuat grup dan menambahkan anggota secara manual atau via undangan.

* **Pembagian Tagihan Fleksibel**: Pembagian rata, per item, persentase, atau kustom.
* **Rekapitulasi Hutang & Piutang**: Ringkasan pengeluaran dan status hutang/piutang real-time.
* **Fitur Pelunasan**: Menandai transaksi lunas, otomatis memperbarui status keuangan grup.
* **Riwayat Transaksi & Notifikasi**: Catatan aktivitas keuangan dan informasi terbaru.
* **Aksesibilitas Data**: Data tersimpan cloud-based dengan keamanan Firebase Authentication.
* **Antarmuka Intuitif**: UI modern dan mudah digunakan.

## Teknologi yang Digunakan
* **Flutter**: Framework UI Google untuk aplikasi mobile cross-platform (Android & iOS).
* **Firebase**: Backend as a Service (BaaS) dari Google untuk autentikasi, database (Firestore), penyimpanan (Storage), dan fungsi serverless (Cloud Functions).
* **Flask**: Micro-framework Python untuk API backend spesifik (misalnya, pemrosesan OCR lanjutan).
* **GitHub**: Platform kolaborasi dan version control untuk pengelolaan kode.
* **Figma**: Alat desain UI/UX berbasis cloud untuk wireframe dan prototyping.

## Alur Kerja Singkat
1.  **Registrasi & Login**: Pengguna mendaftar atau masuk ke akun.
2.  **Pengelolaan Grup**: Membuat grup baru dan menambahkan anggota.
3.  **Pencatatan Pengeluaran**: Menambah biaya secara manual atau melalui fitur "Scan Struk".
4.  **Pembagian Tagihan**: Mengatur cara pembagian biaya antar anggota.
5.  **Rekap & Pelunasan**: Melihat ringkasan hutang/piutang dan menandai pembayaran lunas.

## Anggota Kelompok
* **Putri Salsabilla Insani** - 5026221062
* **Viera Tito Virgiawan** - 5026221096
* **Ahmad Fadhino Tegar Permana** - 5026221109
* **Muhammad Rafi Novyansyah** - 5026221171
* **Ishaq Yudha Alnafi Syahputra** - 5026221214

## Kontribusi Anggota

| Nama | Kontribusi Ringkas |
|---|---|
| Putri Salsabilla Insani | Implementasi UI Figma, backend Groups. |
| Viera Tito Virgiawan | Brainstorming database & UI, backend Auth & User. |
| Ahmad Fadhino Tegar Permana | Brainstorming database & UI, backend Bills. |
| Muhammad Rafi Novyansyah | Brainstorming UI & profile screen, backend Ledgers. |
| Ishaq Yudha Alnafi Syahputra | Brainstorming UI & home/history screen, backend Auth & User. |

*Untuk detail kontribusi per tanggal, silakan lihat [laporan](https://docs.google.com/document/d/10MTIsh64DMBO2QuUqIGsZ1C1gj36EH_XNkQUUZirAag/edit?hl=ID&tab=t.0#heading=h.hnkrl0utjpex) lengkap.*

## Panduan Instalasi Aplikasi SplitIn

### Prasyarat
Pastikan Anda telah menginstal:
* [Flutter SDK](https://flutter.dev/docs/get-started/install)
* [Android Studio](https://developer.android.com/studio) / [VS Code](https://code.visualstudio.com/)
* [Python 3.x](https://www.python.org/downloads/) (untuk backend Flask)
* [Git](https://git-scm.com/downloads)

### Langkah Instalasi
1.  **Kloning Repositori**:
    ```bash
    git clone url_repo
    cd url_repo
    ```
2.  **Konfigurasi Flutter**:
    ```bash
    cd frontend # Jika ada sub-direktori
    flutter pub get
    flutter doctor # Periksa dan perbaiki masalah
    ```
3.  **Konfigurasi Firebase**:
    * Buat proyek di [Firebase Console](https://console.firebase.google.com/).
    * Tambahkan aplikasi Android/iOS, ikuti petunjuk untuk `google-services.json` dan `GoogleService-Info.plist`.
    * Aktifkan Firebase Authentication (Email/Password, Google Sign-In), Cloud Firestore, dan Cloud Storage. Atur Security Rules.
4.  **Menjalankan Backend Flask (Opsional)**:
    ```bash
    cd backend # Sesuaikan path
    python -m venv venv
    source venv/bin/activate # atau .\venv\Scripts\activate di Windows
    pip install -r requirements.txt
    python app.py # Atau nama file entry point Anda
    ```
5.  **Menjalankan Aplikasi Flutter**:
    ```bash
    cd frontend # Kembali ke root proyek Flutter
    flutter run
    ```
---
