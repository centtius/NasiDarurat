import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/ui.dart';
import 'donor_nav.dart';

class RiwayatDonasiPage extends StatelessWidget {
  final bool showBottomNav;
  const RiwayatDonasiPage({super.key, this.showBottomNav = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagePadding(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Expanded(child: SubHeader('Riwayat Donasi Saya')),
          IconButton(
            onPressed: () =>
                notice(context, 'Belum ada notifikasi baru (mode demo).'),
            icon: const Icon(Icons.notifications_none_rounded, size: 21),
            style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Palette.line)),
          ),
        ]),

        // Ringkasan
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Palette.blue, Color(0xFF4A90E2)],
            ),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Total Donasi Saya',
                    style:
                        TextStyle(fontSize: 11, color: Colors.white70)),
                const SizedBox(height: 4),
                const Text('Rp 750.000',
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w800,
                        color: Colors.white)),
                const SizedBox(height: 10),
                const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Dana Terpakai: Rp 510.000',
                          style: TextStyle(
                              fontSize: 10, color: Colors.white)),
                      Text('68%',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              color: Colors.white)),
                    ]),
                const SizedBox(height: 5),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: const LinearProgressIndicator(
                    value: 0.68,
                    minHeight: 5,
                    backgroundColor: Color(0x40FFFFFF),
                    valueColor: AlwaysStoppedAnimation(Palette.yellow),
                  ),
                ),
              ]),
        ),
        const SizedBox(height: 12),

        const _HistoryItem(
            'Rp 250.000', '15 Sep 2026', 'Rp 250.000 terpakai', true),
        const _HistoryItem(
            'Rp 100.000', '29 Sep 2026', 'Rp 85.000 terpakai', true),
        const _HistoryItem(
            'Rp 200.000', '10 Sep 2026', 'Rp 175.000 terpakai', true),
        const _HistoryItem('Rp 100.000', '29 Sep 2026', '—', false),
        const _HistoryItem(
            'Rp 100.000', '5 Sep 2026', 'Rp 0 terpakai', true),

        const SizedBox(height: 8),
        const Text(
            'Donasi berstatus Menunggu belum masuk ke Dana Tersedia.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9, color: Palette.gray)),
      ]),
      bottomNavigationBar: showBottomNav ? const DonorBottomNav() : null,
    );
  }
}

class _HistoryItem extends StatelessWidget {
  final String amount, date, used;
  final bool success;
  const _HistoryItem(this.amount, this.date, this.used, this.success);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: () => notice(context, 'Detail donasi (mode demo).'),
        child: NDCard(
          padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
          child: Row(children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Text(amount,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Palette.navy)),
                      const Spacer(),
                      _Badge(success),
                    ]),
                    const SizedBox(height: 3),
                    Text(date,
                        style: const TextStyle(
                            fontSize: 10, color: Palette.gray)),
                    const SizedBox(height: 3),
                    Text(used,
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Palette.blue)),
                  ]),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.chevron_right,
                size: 20, color: Palette.blue),
          ]),
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final bool success;
  const _Badge(this.success);

  @override
  Widget build(BuildContext context) => Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
        decoration: BoxDecoration(
          color: success ? Palette.mint : const Color(0xFFFFEFC4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(success ? 'BERHASIL' : 'MENUNGGU',
            style: TextStyle(
                fontSize: 8.5,
                fontWeight: FontWeight.w800,
                color:
                    success ? Palette.green : const Color(0xFFAB6A00))),
      );
}