import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/ui.dart';
import 'admin_widgets.dart';
import 'report_widgets.dart';

class VerifikasiAkhirAdminPage extends StatelessWidget {
  final bool showBottomNav;
  const VerifikasiAkhirAdminPage({super.key, this.showBottomNav = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagePadding(children: [
        const SubHeader('Verifikasi Akhir',
            subtitle: 'Permintaan ND-2026-0081'),

        const InfoBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bantuan makanan • Ayu Pratama',
                  style: TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w800,
                      color: Palette.deepBlue)),
              SizedBox(height: 7),
              Text('Dana dialokasikan: Rp150.000',
                  style: TextStyle(fontSize: 10, color: Palette.navy)),
            ],
          ),
        ),

        const SectionHeading('Bukti penyaluran'),
        const _ProofCard(
          role: AdminTag.info('RANGER'),
          title: 'Foto barang + struk',
          time: 'Dikirim 12:02',
        ),
        const SizedBox(height: 10),
        const _ProofCard(
          role: AdminTag.warn('PENERIMA'),
          title: 'Foto bantuan diterima',
          time: 'Dikirim 12:34',
        ),
        const SizedBox(height: 12),

        const NoteBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Periksa sebelum menyelesaikan',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Palette.navy)),
              SizedBox(height: 7),
              Text('✓ Kesesuaian barang dan struk',
                  style: TextStyle(fontSize: 9.5, color: Palette.navy)),
              SizedBox(height: 3),
              Text('✓ Bukti ranger dan penerima',
                  style: TextStyle(fontSize: 9.5, color: Palette.navy)),
              SizedBox(height: 3),
              Text('✓ Laporan alokasi dana',
                  style: TextStyle(fontSize: 9.5, color: Palette.navy)),
            ],
          ),
        ),
        const SizedBox(height: 18),

        NDButton(
          label: 'Verifikasi & Selesaikan',
          background: Palette.blue,
          foreground: Colors.white,
          onPressed: () {
            notice(context,
                'Permintaan diverifikasi dan diselesaikan (mode demo).');
            Navigator.of(context).maybePop();
          },
        ),
        const SizedBox(height: 8),
        const Text('Setelah diverifikasi, status permintaan menjadi Selesai.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 8.5, color: Palette.gray)),
      ]),
      bottomNavigationBar:
          showBottomNav ? const AdminBottomNav(selected: 1) : null,
    );
  }
}

class _ProofCard extends StatelessWidget {
  final Widget role;
  final String title, time;
  const _ProofCard(
      {required this.role, required this.title, required this.time});

  @override
  Widget build(BuildContext context) => NDCard(
        padding: const EdgeInsets.all(12),
        child: Column(children: [
          Row(children: [
            role,
            const Spacer(),
            const AdminTag.success('TERKIRIM'),
          ]),
          const SizedBox(height: 10),
          Row(children: [
            Container(
              width: 42,
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFFF1EFE8),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Palette.line),
              ),
              child: const Icon(Icons.image_outlined,
                  size: 18, color: Palette.gray),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Palette.navy)),
                    const SizedBox(height: 3),
                    Text(time,
                        style: const TextStyle(
                            fontSize: 9, color: Palette.gray)),
                  ]),
            ),
          ]),
        ]),
      );
}