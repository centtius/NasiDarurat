import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/ui.dart';
import 'donor_nav.dart';
import 'report_widgets.dart';
import 'alokasi_donasi_page.dart';

class LaporanDonasiPage extends StatelessWidget {
  final bool showBottomNav;
  const LaporanDonasiPage({super.key, this.showBottomNav = true});

  @override
  Widget build(BuildContext context) {
    void openBukti() => openPage(context, const AlokasiDonasiPage());

    return Scaffold(
      body: PagePadding(children: [
        const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(child: SubHeader('Laporan Donasi')),
          NotifBell(),
        ]),

        const InfoBox(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Donasi #DON-2026-0312',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w800,
                    color: Palette.deepBlue)),
            SizedBox(height: 7),
            Row(children: [
              Text('Tanggal: 15 Sep 2026',
                  style: TextStyle(fontSize: 10, color: Palette.gray)),
              Spacer(),
              Text('Total: ',
                  style: TextStyle(fontSize: 10, color: Palette.gray)),
              Text('Rp 100.000',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Palette.navy)),
            ]),
          ]),
        ),

        const SectionHeading('Alokasi Dana'),
        _AllocCard(
          title: 'Bantuan A — Ibu Sari',
          type: 'Jenis: Bahan Pokok',
          date: '15 Sep 2026',
          amount: 'Rp 60.000',
          onTap: openBukti,
        ),
        const SizedBox(height: 10),
        _AllocCard(
          title: 'Bantuan B — Pak Budi',
          type: 'Jenis: Makan Siap Saji',
          date: '19 Sep 2026',
          amount: 'Rp 25.000',
          onTap: openBukti,
        ),
        const SizedBox(height: 12),

        const NoteBox(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Total Tersalur',
                  style: TextStyle(fontSize: 10.5, color: Palette.navy)),
              Text('Rp 85.000',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Palette.navy)),
            ]),
            SizedBox(height: 6),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Sisa Belum Digunakan',
                  style: TextStyle(fontSize: 10.5, color: Palette.navy)),
              Text('Rp 15.000',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Palette.navy)),
            ]),
            SizedBox(height: 7),
            Text(
              '* Sisa dana tetap tersedia di Dana Tersedia untuk disalurkan ke permintaan lain.',
              style: TextStyle(fontSize: 8.5, height: 1.4, color: Palette.gray),
            ),
            SizedBox(height: 9),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              child: SizedBox(
                height: 6,
                child: Row(children: [
                  Expanded(flex: 85, child: ColoredBox(color: Palette.blue)),
                  Expanded(flex: 15, child: ColoredBox(color: Color(0xFF8DBBF0))),
                ]),
              ),
            ),
          ]),
        ),
      ]),
      bottomNavigationBar: showBottomNav ? const DonorBottomNav() : null,
    );
  }
}

class _AllocCard extends StatelessWidget {
  final String title, type, date, amount;
  final VoidCallback onTap;
  const _AllocCard(
      {required this.title,
      required this.type,
      required this.date,
      required this.amount,
      required this.onTap});

  @override
  Widget build(BuildContext context) => NDCard(
        padding: const EdgeInsets.all(13),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Palette.navy)),
            ),
            const ReportBadge.success('TERSALURKAN'),
          ]),
          const SizedBox(height: 4),
          Text(type, style: const TextStyle(fontSize: 10, color: Palette.gray)),
          const SizedBox(height: 7),
          Row(children: [
            Text(date, style: const TextStyle(fontSize: 9.5, color: Palette.gray)),
            const Spacer(),
            Text(amount,
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Palette.blue)),
          ]),
          const SizedBox(height: 10),
          InkWell(
            onTap: onTap,
            child: const Text('Lihat Bukti Penyaluran →',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Palette.blue)),
          ),
        ]),
      );
}