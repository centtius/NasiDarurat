import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/ui.dart';
import 'admin_widgets.dart';
import 'report_widgets.dart';

class TinjauPermintaanAdminPage extends StatelessWidget {
  final bool showBottomNav;
  const TinjauPermintaanAdminPage({super.key, this.showBottomNav = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagePadding(children: [
        const SubHeader('Tinjau Permintaan', subtitle: 'Permintaan ND-2026-0081'),
        const Align(
            alignment: Alignment.centerLeft,
            child: AdminTag.warn('DALAM ANTREAN')),
        const SizedBox(height: 12),

        NDCard(
          padding: const EdgeInsets.all(15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Text('Ayu Pratama • 3 anggota keluarga',
                style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: Palette.navy)),
            SizedBox(height: 7),
            Text('Dana yang diminta Rp350.000',
                style: TextStyle(fontSize: 10, color: Palette.gray)),
            SizedBox(height: 3),
            Text('Alasan: tidak dapat keluar rumah hari ini.',
                style: TextStyle(fontSize: 10, color: Palette.gray)),
            SizedBox(height: 14),
            Text('Alamat lengkap hanya untuk proses internal.',
                style: TextStyle(fontSize: 8.5, color: Palette.gray)),
          ]),
        ),
        const SizedBox(height: 12),

        InfoBox(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Text('Pemeriksaan admin',
                style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: Palette.deepBlue)),
            SizedBox(height: 7),
            Text('• Identitas penerima sesuai akun',
                style: TextStyle(fontSize: 9.5, color: Palette.navy)),
            SizedBox(height: 3),
            Text('• Lokasi dan kebutuhan terisi',
                style: TextStyle(fontSize: 9.5, color: Palette.navy)),
            SizedBox(height: 3),
            Text('• Hubungi penerima untuk memastikan kebutuhan',
                style: TextStyle(fontSize: 9.5, color: Palette.navy)),
          ]),
        ),
        const SizedBox(height: 12),

        NoteBox(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Text('Kapan status berubah?',
                style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: Palette.navy)),
            SizedBox(height: 6),
            Text(
              'Tetap Dalam Antrean sampai admin mengirim pesan pertama. Setelah itu status menjadi Diproses.',
              style: TextStyle(fontSize: 9.5, height: 1.45, color: Palette.navy),
            ),
          ]),
        ),
        const SizedBox(height: 22),

        NDButton(
          label: 'Mulai Chat dengan Ayu',
          background: Palette.blue,
          foreground: Colors.white,
          onPressed: () => notice(context, 'Chat dengan Ayu (mode demo).'),
        ),
        const SizedBox(height: 10),
        NDButton(
          label: 'Tolak dengan Alasan',
          background: const Color(0xFFFBE3E4),
          foreground: Palette.red,
          onPressed: () => notice(context, 'Tolak permintaan (mode demo).'),
        ),
        const SizedBox(height: 12),
        const Text('Keputusan tercatat di riwayat permintaan.',
            style: TextStyle(fontSize: 8.5, color: Palette.gray)),
      ]),
      bottomNavigationBar:
          showBottomNav ? const AdminBottomNav(selected: 1) : null,
    );
  }
}