import 'package:flutter/material.dart';
import '../main.dart';
import '../core/app_theme.dart';
import '../core/demo_store.dart';
import '../core/ui.dart';
import 'donor_nav.dart';

class StatusGagalPage extends StatelessWidget {
  final bool showBottomNav;
  const StatusGagalPage({super.key, this.showBottomNav = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagePadding(children: [
        const SubHeader('Status Pembayaran', subtitle: 'Donasi Rp100.000'),

        // Kartu gagal
        NDCard(
          color: const Color(0xFFFBE8E8),
          borderColor: const Color(0xFFF1CACC),
          padding: const EdgeInsets.all(15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            _RedPill('PEMBAYARAN GAGAL'),
            SizedBox(height: 12),
            Text('Donasi belum tercatat',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Palette.deepBlue)),
            SizedBox(height: 8),
            Text(
              'Dana tidak ditambahkan ke saldo program dan jumlah transaksi belum bertambah.',
              style: TextStyle(fontSize: 10.5, height: 1.4, color: Palette.blue),
            ),
          ]),
        ),
        const SizedBox(height: 14),

        // Yang bisa dilakukan
        NDCard(
          padding: const EdgeInsets.all(15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Text('Yang bisa kamu lakukan',
                style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w800,
                    color: Palette.deepBlue)),
            SizedBox(height: 9),
            Text(
              'Periksa metode pembayaran atau coba lagi. Jika saldo sudah terpotong, hubungi admin dan sertakan nomor transaksi.',
              style: TextStyle(fontSize: 10.5, height: 1.45, color: Palette.blue),
            ),
            SizedBox(height: 10),
            Text('Nomor transaksi: DNR-2026-0042',
                style: TextStyle(fontSize: 9, color: Palette.gray)),
          ]),
        ),
        const SizedBox(height: 30),

        NDButton(
          label: 'Coba Bayar Lagi',
          background: Palette.blue,
          foreground: Colors.white,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        const SizedBox(height: 11),
        NDButton(
          label: 'Ganti Metode Pembayaran',
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        const SizedBox(height: 11),
        NDButton(
          label: 'Chat Admin',
          background: const Color(0xFFF2F1EE),
          foreground: Palette.blue,
          onPressed: () => notice(context, 'Chat admin (mode demo).'),
        ),
      ]),
      bottomNavigationBar: showBottomNav ? const DonorBottomNav() : null,
    );
  }
}

class _RedPill extends StatelessWidget {
  final String label;
  const _RedPill(this.label);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
        decoration: BoxDecoration(
            color: Palette.red, borderRadius: BorderRadius.circular(7)),
        child: Text(label,
            style: const TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
                color: Colors.white)),
      );
}