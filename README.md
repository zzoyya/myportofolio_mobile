# myportofolio_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

---

### pertanyaan reflektif tugas individu 7

1. Widget tree adalah susunan widget yang membentuk tampilan aplikasi Flutter. Setiap widget bisa memiliki widget lain sebagai anaknya. Contohnya, pada proyek ini Scaffold menjadi induk yang memiliki AppBar dan body. Di dalam body terdapat Padding, Column, dan widget lainnya. Hubungan ini membuat tampilan aplikasi tersusun secara terstruktur.

2. Widget yang digunakan antara lain MaterialApp untuk mengatur aplikasi, Scaffold sebagai struktur halaman, AppBar untuk bagian judul, Text untuk menampilkan tulisan, Padding untuk mengatur jarak, Column dan Row untuk menyusun widget secara vertikal dan horizontal, serta Center untuk meletakkan widget di tengah. Selain itu, ada SizedBox untuk memberikan jarak, Card dan Container untuk membuat kartu informasi, GridView.count untuk menyusun tombol dalam bentuk grid, Icon untuk menampilkan ikon, Material dan InkWell untuk membuat tombol yang bisa ditekan, serta SnackBar untuk menampilkan pesan setelah tombol ditekan. Saya juga membuat widget sendiri, yaitu InfoCard untuk menampilkan NPM, nama, dan kelas, serta ItemCard untuk menampilkan tombol menu portofolio.

3. MaterialApp berfungsi untuk mengatur tampilan dan konfigurasi utama aplikasi Flutter, seperti tema, warna, judul, dan halaman awal. Widget ini biasanya digunakan sebagai root widget karena menjadi dasar bagi widget lainnya agar bisa menggunakan desain Material Design dan fitur bawaan Flutter dengan lebih mudah.

4. StatelessWidget adalah widget yang tampilannya tidak memiliki state yang berubah selama widget digunakan. Sementara itu, StatefulWidget adalah widget yang memiliki state dan bisa memperbarui tampilannya ketika datanya berubah. StatelessWidget cocok digunakan untuk tampilan yang sifatnya tetap, seperti halaman utama pada proyek ini. Sedangkan StatefulWidget lebih cocok digunakan untuk fitur yang membutuhkan perubahan data, seperti form input, tombol penghitung, atau fitur yang memperbarui tampilan secara langsung.

5. BuildContext adalah informasi mengenai posisi sebuah widget di dalam widget tree. Context penting karena memungkinkan widget mengakses informasi dari widget induknya, seperti tema dan ukuran layar. Pada proyek ini, BuildContext digunakan untuk mengambil warna tema melalui Theme.of(context) dan menampilkan SnackBar menggunakan ScaffoldMessenger.of(context) di dalam metode build maupun aksi tombol.

6. Hot reload adalah fitur Flutter yang memungkinkan perubahan kode langsung terlihat tanpa harus menjalankan ulang aplikasi dari awal. Biasanya fitur ini tidak menghilangkan state yang sedang berjalan. Sementara itu, hot restart akan menjalankan ulang aplikasi dari awal sehingga state sebelumnya direset. Hot reload cocok untuk perubahan tampilan atau teks, sedangkan hot restart diperlukan ketika ada perubahan yang memengaruhi inisialisasi aplikasi atau state awal. Full restart biasanya diperlukan ketika perubahan tidak bisa diterapkan melalui hot reload maupun hot restart, misalnya perubahan konfigurasi native atau plugin tertentu.

Dalam pengerjaan tugas ini, saya menggunakan AI sebagai alat bantu untuk memahami konsep Flutter, membantu menyusun dan menyesuaikan kode program, memberikan referensi dan saran penyesuaian kode pada main.dart dan menu.dart. Seluruh hasil implementasi tetap saya periksa dan jalankan secara mandiri untuk memastikan aplikasi berfungsi sesuai dengan ketentuan tugas.

---

### pertanyaan reflektif tugas individu 8

1. Navigator.push() digunakan untuk membuka halaman baru tanpa menghapus halaman sebelumnya dari navigation stack. Navigator.pushReplacement() digunakan untuk mengganti halaman yang sedang dibuka dengan halaman baru, sedangkan Navigator.pop() digunakan untuk menutup halaman saat ini dan kembali ke halaman sebelumnya. Pada aplikasi ini, Navigator.push() digunakan untuk membuka Education Form dari kartu aksi maupun Drawer. Sementara itu, opsi Home menggunakan Navigator.pushReplacement() agar pengguna dapat kembali ke halaman utama.

2. Scaffold digunakan sebagai struktur utama halaman yang menampung AppBar, Drawer, dan body. AppBar berfungsi menampilkan judul halaman, sedangkan Drawer menyediakan navigasi ke halaman lain. Penggunaan komponen tersebut membuat tampilan setiap halaman lebih konsisten. Contohnya, warna indigo digunakan pada AppBar halaman utama, Project Form, dan Education Form sehingga tampilan aplikasi memiliki tema yang seragam.

3. Saya menggunakan Column untuk menyusun input formulir secara vertikal dan Padding untuk memberikan jarak antarinput agar tampilannya lebih rapi. SingleChildScrollView digunakan agar seluruh formulir tetap dapat diakses dengan menggulir layar, terutama ketika ukuran layar kecil atau keyboard sedang ditampilkan. Dengan begitu, pengguna tetap dapat mengakses tombol Save tanpa kesulitan.

4. GlobalKey FormState digunakan untuk mengakses dan mengelola kondisi formulir. Validator berfungsi memeriksa apakah nilai yang dimasukkan sudah sesuai dengan aturan yang ditentukan, sedangkan validate() digunakan untuk menjalankan seluruh validasi ketika tombol Save ditekan. Contohnya, nama institusi yang kosong atau hanya berisi spasi akan ditolak. Pemilihan jenis input atau keyboard saja belum cukup karena pengguna masih dapat memasukkan nilai yang tidak sesuai, sehingga tetap diperlukan validasi untuk memastikan data benar.

Dalam pengerjaan Tugas 8, saya menggunakan ChatGPT sebagai alat bantu untuk memahami implementasi Flutter, menyusun Education Form, mengatur navigasi menggunakan Navigator, serta menerapkan validasi input dan dialog ringkasan. AI juga membantu menjelaskan error dan memberikan saran perbaikan kode. Seluruh implementasi kemudian saya sesuaikan dengan struktur proyek yang sudah ada dan saya uji secara langsung menggunakan aplikasi Flutter.