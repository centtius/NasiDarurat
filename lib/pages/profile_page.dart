import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/demo_store.dart';
import '../core/ui.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final name = TextEditingController(text: demoStore.fullName);
  late final tel = TextEditingController(text: demoStore.phone);
  late final email = TextEditingController(text: demoStore.email);
  late final address = TextEditingController(text: demoStore.address);
  @override
  void dispose() {name.dispose(); tel.dispose(); email.dispose(); address.dispose(); super.dispose();}
  @override
  Widget build(BuildContext context) => AnimatedBuilder(animation: demoStore,
    builder: (context, _) => PagePadding(children: [
      const SubHeader('Edit Profile'),
      Center(child: Stack(clipBehavior: Clip.none, children: [
        const CircleAvatar(radius: 53, backgroundColor: Colors.white,
          child: Icon(Icons.person, size: 62, color: Color(0xFFC2C5C7))),
        Positioned(right: -2, bottom: 2, child: InkWell(
          onTap: () => notice(context, 'Unggah foto profil akan ditambahkan saat integrasi.'),
          child: const CircleAvatar(radius: 19, backgroundColor: Colors.black87,
            child: Icon(Icons.camera_alt_outlined, size: 17, color: Colors.white)))),
      ])),
      const SizedBox(height: 19),
      NDInput(label: 'Nama Lengkap Sesuai KTP *', controller: name),
      const SizedBox(height: 17),
      NDInput(label: 'Nomor WhatsApp / Telepon *', controller: tel,
        keyboardType: TextInputType.phone),
      Align(alignment: Alignment.centerRight, child: TextButton.icon(
        onPressed: () => notice(context, 'Verifikasi OTP membutuhkan koneksi backend.'),
        icon: const Icon(Icons.verified_outlined, color: Palette.green, size: 15),
        label: const Text('Terverifikasi OTP', style: TextStyle(fontSize: 11,
          color: Palette.green)))),
      const SizedBox(height: 5),
      NDInput(label: 'Alamat Email Dinas Relawan *', controller: email,
        keyboardType: TextInputType.emailAddress),
      const SizedBox(height: 17),
      NDInput(label: 'Alamat Domisili / Basis Posko *', controller: address, maxLines: 3),
      const SizedBox(height: 13),
      const SectionHeading('Upload Foto KTP'),
      InkWell(onTap: () => notice(context, 'Unggah KTP membutuhkan fitur pemilih berkas.'),
        child: NDCard(child: Row(children: [
          Container(width: 103, height: 102,
            decoration: BoxDecoration(color: const Color(0xFFF0F3F7),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Palette.line)),
            child: const Icon(Icons.add, color: Palette.blue, size: 32)),
          const SizedBox(width: 12),
          const Expanded(child: Text('Unggah foto KTP Anda untuk proses verifikasi identitas. Data KTP hanya dapat digunakan untuk memverifikasi penerima bantuan.',
            style: TextStyle(fontSize: 11, color: Palette.gray, height: 1.5))),
        ]))),
      const SizedBox(height: 17),
      NDButton(label: 'Simpan Perubahan', icon: Icons.save_outlined,
        background: Palette.blue, foreground: Colors.white,
        onPressed: () {
          demoStore.updateProfile(name.text, tel.text, email.text, address.text);
          notice(context, 'Perubahan profil tersimpan di memori demo.');
        }),
      const SizedBox(height: 25),
      NDCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Row(children: [Icon(Icons.favorite, color: Color(0xFFF25D6D), size: 26),
          SizedBox(width: 10), Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Ingin membantu?', style: TextStyle(fontSize: 15,
                fontWeight: FontWeight.w800)),
              Text('Daftar sebagai Donatur untuk membantu sesama',
                style: TextStyle(fontSize: 11, color: Palette.gray)),
            ]))]),
        const SizedBox(height: 13),
        NDButton(label: demoStore.isDonor ? 'Sudah Terdaftar sebagai Donatur' : 'Jadi Donatur',
          icon: Icons.favorite_border,
          outlined: true, foreground: Palette.red,
          onPressed: demoStore.isDonor ? null : () {
            demoStore.toggleDonor();
            notice(context, 'Mode demo: permintaan menjadi donatur tercatat secara lokal.');
          }),
      ])),
    ]),
  );
}
