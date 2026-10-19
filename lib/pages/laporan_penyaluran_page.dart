import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/ui.dart';
import 'donor_nav.dart';
import 'report_widgets.dart';
import 'chat_admin_page.dart';

class LaporanPenyaluranPage extends StatelessWidget {
  final bool showBottomNav;
  const LaporanPenyaluranPage({super.key, this.showBottomNav = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagePadding(children: [
        const SubHeader('Laporan Penyaluran',
            subtitle: 'Donasi DNR-2026-0042'),

        const InfoBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Donasi Anda: Rp100.000',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: Palette.deepBlue)),
              SizedBox(height: 8),
              Text('Rp60.000 → bahan pokok Ayu P.',
                  style: TextStyle(fontSize: 10, color: Palette.navy)),
              SizedBox(height: 4),
              Text('Rp40.000 → makan siap saji Budi S.',
                  style: TextStyle(fontSize: 10, color: Palette.navy)),
            ],
          ),
        ),
        const SizedBox(height: 12),

        const NDCard(
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bahan pokok • selesai',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Palette.navy)),
              SizedBox(height: 7),
              Text('Barang: beras, minyak, telur',
                  style: TextStyle(fontSize: 10, color: Palette.gray)),
              SizedBox(height: 3),
              Text('Pengeluaran Rp150.000 dari dana bersama',
                  style: TextStyle(fontSize: 10, color: Palette.gray)),
              SizedBox(height: 3),
              Text('Bagian donasi Anda Rp60.000',
                  style: TextStyle(fontSize: 10, color: Palette.gray)),
              SizedBox(height: 9),
              ReportBadge.success('BUKTI DIVERIFIKASI'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const NDCard(
          padding: EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Makan siap saji • diproses',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Palette.navy)),
              SizedBox(height: 7),
              Text('Bagian donasi Anda Rp40.000',
                  style: TextStyle(fontSize: 10, color: Palette.gray)),
              SizedBox(height: 3),
              Text('Menunggu bukti penyaluran admin.',
                  style: TextStyle(fontSize: 10, color: Palette.gray)),
            ],
          ),
        ),
        const SizedBox(height: 12),

        const NoteBox(
          child: Text(
            'Laporan menampilkan nominal, barang, waktu, dan status verifikasi. Alamat serta foto pribadi penerima disembunyikan.',
            style: TextStyle(
                fontSize: 9.5, height: 1.45, color: Palette.navy),
          ),
        ),
        const SizedBox(height: 22),

        NDButton(
          label: 'Chat Admin',
          background: Palette.blue,
          foreground: Colors.white,
          onPressed: () => openPage(context, const ChatAdminPage()),
        ),
      ]),
      bottomNavigationBar: showBottomNav ? const DonorBottomNav() : null,
    );
  }
}