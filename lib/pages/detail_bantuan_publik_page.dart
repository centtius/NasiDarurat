import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/ui.dart';
import 'admin_widgets.dart';
import 'report_widgets.dart';
import 'verifikasi_akhir_admin_page.dart';

class DetailBantuanPublikPage extends StatelessWidget {
  final bool showBottomNav;
  const DetailBantuanPublikPage({super.key, this.showBottomNav = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagePadding(children: [
        const SubHeader('Detail Bantuan', subtitle: 'Terlihat oleh semua peran'),
        const Align(
            alignment: Alignment.centerLeft,
            child: AdminTag.warn('DALAM ANTREAN')),
        const SizedBox(height: 12),

        NDCard(
          padding: const EdgeInsets.all(15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Text('Bahan pokok untuk Ayu P.',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Palette.deepBlue)),
            SizedBox(height: 5),
            Text('Tegalrejo, Yogyakarta',
                style: TextStyle(fontSize: 10, color: Palette.gray)),
            SizedBox(height: 13),
            Text('Kebutuhan',
                style: TextStyle(fontSize: 9, color: Palette.gray)),
            SizedBox(height: 3),
            Text('Beras 5 kg, minyak goreng 2 L, tepung 1 kg.',
                style: TextStyle(fontSize: 10.5, color: Palette.navy)),
            SizedBox(height: 14),
            Text('Dana yang diminta: Rp350.000',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Palette.blue)),
          ]),
        ),
        const SizedBox(height: 12),

        InfoBox(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Text('Privasi penerima',
                style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: Palette.deepBlue)),
            SizedBox(height: 6),
            Text(
              'Daftar publik hanya menampilkan ringkasan dan wilayah. Alamat lengkap hanya terlihat oleh admin dan petugas yang ditugaskan.',
              style: TextStyle(fontSize: 9.5, height: 1.45, color: Palette.navy),
            ),
          ]),
        ),
        const SizedBox(height: 12),

        NDCard(
          padding: const EdgeInsets.all(15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Text('Perkembangan bantuan',
                style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: Palette.navy)),
            SizedBox(height: 10),
            _Step('Dalam antrean', true),
            _Step('Diproses setelah admin mengirim chat', false),
            _Step('Selesai setelah bukti diverifikasi', false),
          ]),
        ),
        const SizedBox(height: 16),

        NDButton(
          label: 'Lihat Riwayat Bantuan',
          background: Palette.blue,
          foreground: Colors.white,
          onPressed: () => openPage(context, const VerifikasiAkhirAdminPage()),
        ),
        const SizedBox(height: 10),
        NDButton(
          label: 'Ajukan Bantuan',
          onPressed: () => notice(context, 'Ajukan bantuan (mode demo).'),
        ),
      ]),
      bottomNavigationBar:
          showBottomNav ? const AdminBottomNav(selected: 1) : null,
    );
  }
}

class _Step extends StatelessWidget {
  final String label;
  final bool active;
  const _Step(this.label, this.active);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(children: [
          Container(
            width: 9,
            height: 9,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: active ? Palette.yellow : const Color(0xFFE3E5EA),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(label,
                style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: active ? FontWeight.w700 : FontWeight.w400,
                    color: active ? Palette.navy : Palette.gray)),
          ),
        ]),
      );
}