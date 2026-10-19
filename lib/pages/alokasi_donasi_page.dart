import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/ui.dart';
import 'donor_nav.dart';
import 'report_widgets.dart';
import 'laporan_penyaluran_page.dart';

class AlokasiDonasiPage extends StatelessWidget {
  final bool showBottomNav;
  const AlokasiDonasiPage({super.key, this.showBottomNav = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagePadding(children: [
        const SubHeader('Alokasi Donasi Saya'),

        const InfoBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Donasi berhasil • Rp100.000',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: Palette.deepBlue)),
              SizedBox(height: 7),
              Text('Masuk ke dana bersama pada 29 Sep, 10:30.',
                  style: TextStyle(fontSize: 10, color: Palette.navy)),
              SizedBox(height: 4),
              Text('Admin mengalokasikan dana sesuai kebutuhan.',
                  style: TextStyle(fontSize: 9, color: Palette.gray)),
            ],
          ),
        ),

        const SectionHeading('Riwayat penggunaan'),
        const _UsageCard(
          title: 'Bahan pokok • Ayu P.',
          detail: 'Dialokasikan Rp60.000 • Tegalrejo',
          badge: ReportBadge.success('SELESAI'),
        ),
        const SizedBox(height: 10),
        const _UsageCard(
          title: 'Makan siap saji • Budi S.',
          detail: 'Dialokasikan Rp40.000 • Jetis',
          badge: ReportBadge.info('DIPROSES'),
        ),
        const SizedBox(height: 12),

        const NoteBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Laporan penggunaan',
                  style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: Palette.navy)),
              SizedBox(height: 6),
              Text(
                'Lihat barang, nominal, waktu, dan bukti yang diunggah admin. Foto pribadi penerima tidak ditampilkan publik.',
                style: TextStyle(fontSize: 9.5, height: 1.45, color: Palette.navy),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),

        NDButton(
          label: 'Lihat Laporan Penyaluran',
          background: Palette.blue,
          foreground: Colors.white,
          onPressed: () => openPage(context, const LaporanPenyaluranPage()),
        ),
      ]),
      bottomNavigationBar: showBottomNav ? const DonorBottomNav() : null,
    );
  }
}

class _UsageCard extends StatelessWidget {
  final String title, detail;
  final Widget badge;
  const _UsageCard(
      {required this.title, required this.detail, required this.badge});

  @override
  Widget build(BuildContext context) => NDCard(
        padding: const EdgeInsets.all(14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Palette.navy)),
          const SizedBox(height: 6),
          Text(detail,
              style: const TextStyle(fontSize: 10, color: Palette.gray)),
          const SizedBox(height: 9),
          badge,
        ]),
      );
}