import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/demo_store.dart';
import '../core/ui.dart';
import 'donasi_now.dart';

const _lightBlue = Color(0xFF6CB4F5);

/// Beranda donor. Set [showBottomNav] = false jika shell/navigasi utama

class DonorPage extends StatelessWidget {
  final bool showBottomNav;
  const DonorPage({super.key, this.showBottomNav = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagePadding(children: [
        // Header
        Row(children: [
          const Expanded(
            child: Text('Nasi Darurat',
                style: TextStyle(
                    color: Palette.blue,
                    fontSize: 22,
                    fontWeight: FontWeight.w800)),
          ),
          IconButton(
            onPressed: () =>
                notice(context, 'Belum ada notifikasi baru (mode demo).'),
            icon: const Icon(Icons.notifications_none_rounded, size: 21),
            style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Palette.line)),
          ),
          const SizedBox(width: 6),
          CircleAvatar(
            radius: 17,
            backgroundColor: Palette.blue,
            child: Text(
              demoStore.fullName.isEmpty
                  ? 'D'
                  : demoStore.fullName[0].toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 13),
            ),
          ),
        ]),
        const SizedBox(height: 14),

        // Statistik
        Row(children: [
          const Expanded(
            flex: 6,
            child: _StatCard(
                color: Palette.blue,
                label: 'Dana Tersedia',
                value: 'Rp 12.450.000',
                textColor: Colors.white,
                valueSize: 16),
          ),
          const SizedBox(width: 9),
          const Expanded(
            flex: 5,
            child: _StatCard(
                color: _lightBlue,
                label: 'Donasi Masuk',
                value: '127 transaksi',
                textColor: Palette.deepBlue,
                valueSize: 14),
          ),
        ]),
        const SizedBox(height: 13),

        NDButton(
          label: 'Donasi Sekarang',
          icon: Icons.favorite_border_rounded,
          onPressed: () => openPage(context, const DonasiSekarangPage()),
        ),

        const SectionHeading('Donasi Masuk Terbaru'),
        const NDCard(
          child: Column(children: [
            _DonationRow(
                'B', 'Budi Santoso', '5 menit yang lalu', 'Rp 500.000'),
            SizedBox(height: 12),
            _DonationRow('S', 'Siti Rahma', '1 jam yang lalu', 'Rp 150.000'),
            SizedBox(height: 12),
            _DonationRow('A', 'Anonim', '3 jam yang lalu', 'Rp 1.000.000'),
          ]),
        ),

        const SectionHeading('Ringkasan Penyaluran'),
        NDCard(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Nasi Didistribusikan',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Palette.navy)),
                  Text('8.420 Box',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: Palette.blue)),
                ]),
            const SizedBox(height: 12),
            const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Persentase Target Tercapai',
                      style:
                          TextStyle(fontSize: 10, color: Palette.gray)),
                  Text('84%',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: Palette.blue)),
                ]),
            const SizedBox(height: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: const LinearProgressIndicator(
                value: 0.84,
                minHeight: 6,
                backgroundColor: Palette.ice,
                valueColor: AlwaysStoppedAnimation(Palette.blue),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: InkWell(
                onTap: () => notice(context, 'Laporan lengkap (mode demo).'),
                child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Lihat Laporan Lengkap',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Palette.blue)),
                      SizedBox(width: 3),
                      Icon(Icons.chevron_right,
                          size: 16, color: Palette.blue),
                    ]),
              ),
            ),
          ]),
        ),
      ]),
      bottomNavigationBar: showBottomNav ? const _DonorBottomNav() : null,
    );
  }
}

class _StatCard extends StatelessWidget {
  final Color color, textColor;
  final String label, value;
  final double valueSize;
  const _StatCard(
      {required this.color,
      required this.label,
      required this.value,
      required this.textColor,
      required this.valueSize});

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(12)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: TextStyle(fontSize: 11, color: textColor)),
          const SizedBox(height: 12),
          Text(value,
              style: TextStyle(
                  fontSize: valueSize,
                  fontWeight: FontWeight.w800,
                  color: textColor)),
        ]),
      );
}

class _DonationRow extends StatelessWidget {
  final String initial, name, time, amount;
  const _DonationRow(this.initial, this.name, this.time, this.amount);

  @override
  Widget build(BuildContext context) => Row(children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: Palette.ice,
          child: Text(initial,
              style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: Palette.blue)),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Palette.navy)),
                Text(time,
                    style: const TextStyle(
                        fontSize: 10, color: Palette.gray)),
              ]),
        ),
        Text(amount,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: Palette.blue)),
      ]);
}

class _DonorBottomNav extends StatelessWidget {
  const _DonorBottomNav();

  @override
  Widget build(BuildContext context) {
    const items = [
      (Icons.home_outlined, 'Beranda'),
      (Icons.chat_bubble_outline, 'Chat'),
      (Icons.history, 'Riwayat'),
      (Icons.menu_book_outlined, 'Laporan'),
      (Icons.person_outline, 'Profil'),
    ];
    return Container(
      decoration: const BoxDecoration(
        color: Palette.cream,
        border: Border(top: BorderSide(color: Palette.line)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 9),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final active = i == 0;
              final c = active ? Palette.blue : Palette.navy;
              return Column(mainAxisSize: MainAxisSize.min, children: [
                Icon(items[i].$1, size: 21, color: c),
                const SizedBox(height: 3),
                Text(items[i].$2,
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight:
                            active ? FontWeight.w800 : FontWeight.w500,
                        color: c)),
              ]);
            }),
          ),
        ),
      ),
    );
  }
}