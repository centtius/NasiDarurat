import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/ui.dart';
import 'admin_widgets.dart';
import 'report_widgets.dart';
import 'catat_pengeluaran_admin_page.dart';

class RencanaPenyaluranAdminPage extends StatefulWidget {
  final bool showBottomNav;
  const RencanaPenyaluranAdminPage({super.key, this.showBottomNav = true});

  @override
  State<RencanaPenyaluranAdminPage> createState() =>
      _RencanaPenyaluranAdminPageState();
}

class _RencanaPenyaluranAdminPageState
    extends State<RencanaPenyaluranAdminPage> {
  static const _options = [
    ('Ranger sendiri', 'Belanja lalu antarkan makanan'),
    ('Kurir / Bikeship', 'Jika ranger tidak tersedia'),
    ('Transfer dana', 'Jika penerima dapat membeli sendiri'),
    ('Ambil sendiri', 'Jika penerima memilih mengambil'),
  ];
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagePadding(children: [
        const SubHeader('Rencana Penyaluran',
            subtitle: 'Permintaan ND-2026-0081 • Bantuan'),

        InfoBox(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Text('Dana tersedia bersama',
                style: TextStyle(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                    color: Palette.deepBlue)),
            SizedBox(height: 4),
            Text('Rp12.450.000',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Palette.deepBlue)),
            SizedBox(height: 4),
            Text('Kebutuhan Ayu Rp350.000',
                style: TextStyle(fontSize: 9.5, color: Palette.gray)),
          ]),
        ),

        const SectionHeading('Pilih cara penyaluran'),
        ...List.generate(_options.length, (i) {
          final sel = i == _selected;
          return Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: GestureDetector(
              onTap: () => setState(() => _selected = i),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: sel ? const Color(0xFFFFF1C2) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: sel ? Palette.yellow : Palette.line,
                      width: sel ? 1.5 : 1),
                ),
                child: Row(children: [
                  Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: sel ? Palette.yellow : Palette.line, width: 1.5),
                    ),
                    child: sel
                        ? Center(
                            child: Container(
                              width: 7,
                              height: 7,
                              decoration: const BoxDecoration(
                                  color: Palette.yellow,
                                  shape: BoxShape.circle),
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(_options[i].$1,
                          style: const TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w800,
                              color: Palette.navy)),
                      const SizedBox(height: 2),
                      Text(_options[i].$2,
                          style: const TextStyle(
                              fontSize: 9.5, color: Palette.gray)),
                    ]),
                  ),
                ]),
              ),
            ),
          );
        }),
        const SizedBox(height: 4),

        const InfoBox(
          child: Text(
            'Pilihan akhir mengikuti kebutuhan penerima dan ketersediaan petugas. Admin mencatat pengeluaran dan bukti.',
            style: TextStyle(fontSize: 9, height: 1.45, color: Palette.navy),
          ),
        ),
        const SizedBox(height: 16),

        NDButton(
          label: 'Lanjut ke Pengeluaran',
          background: Palette.blue,
          foreground: Colors.white,
          onPressed: () => openPage(context, const CatatPengeluaranAdminPage()),
        ),
        const SizedBox(height: 6),
        TextButton(
          onPressed: () => notice(context, 'Cari petugas lain (mode demo).'),
          child: const Text('Ranger Tidak Tersedia',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Palette.blue)),
        ),
      ]),
      bottomNavigationBar:
          widget.showBottomNav ? const AdminBottomNav(selected: 2) : null,
    );
  }
}