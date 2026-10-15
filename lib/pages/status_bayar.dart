import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../main.dart';
import '../core/app_theme.dart';
import '../core/demo_store.dart';
import '../core/ui.dart';

const _okGreen = Color(0xFF22C55E);
const _okGreenText = Color(0xFF16A34A);
const _warnText = Color(0xFFE8A200);
const _detailBg = Color(0xFFFFF6DE);

class StatusPembayaranPage extends StatelessWidget {
  const StatusPembayaranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagePadding(children: [
        const SubHeader('Status Pembayaran'),
        const Text('CONTOH STATUS',
            style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.3,
                color: Palette.navy)),
        const SizedBox(height: 8),

        // Berhasil
        NDCard(
          borderColor: _okGreen,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              const CircleAvatar(
                radius: 15,
                backgroundColor: Palette.mint,
                child: Icon(Icons.check, size: 16, color: _okGreen),
              ),
              const SizedBox(width: 9),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                Text('Pembayaran Berhasil!',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: _okGreenText)),
                Text('Rp 100.000',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Palette.navy)),
              ]),
            ]),
            const SizedBox(height: 10),
            const Text(
              'Dana Tersedia bertambah Rp 100.000 dan jumlah transaksi donasi bertambah 1.',
              style: TextStyle(fontSize: 10, height: 1.4, color: Palette.gray),
            ),
            const SizedBox(height: 10),
            const _DetailBox([
              'Metode: QRIS',
              'Waktu: 29 Sep 2026, 10:45',
              'ID Transaksi: #DON-2026-0452',
            ]),
            const SizedBox(height: 12),
            _SmallButton(
              label: 'Lihat Riwayat Donasi',
              onPressed: () => notice(context, 'Riwayat donasi (mode demo).'),
            ),
          ]),
        ),

        const ThinDivider(),

        // Menunggu
        NDCard(
          borderColor: Palette.yellow,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              const CircleAvatar(radius: 15, backgroundColor: Color(0xFFF8E9A9)),
              const SizedBox(width: 9),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                Text('Menunggu Pembayaran',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: _warnText)),
                Text('Rp 100.000',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Palette.navy)),
              ]),
            ]),
            const SizedBox(height: 10),
            const Text(
              'Dana Tersedia dan jumlah transaksi belum berubah hingga pembayaran dikonfirmasi.',
              style: TextStyle(fontSize: 10, height: 1.4, color: Palette.gray),
            ),
            const SizedBox(height: 10),
            const _DetailBox([
              'Metode: Transfer Bank BCA',
              'Batas waktu: 29 Sep 2026, 22:45',
              'VA: 8801234567890',
            ], boldLast: true),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(
                child: _SmallButton(
                  label: 'Salin Nomor VA',
                  outlined: true,
                  onPressed: () {
                    Clipboard.setData(const ClipboardData(text: '8801234567890'));
                    notice(context, 'Nomor VA disalin.');
                  },
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: _SmallButton(
                  label: 'Cek Status',
                  onPressed: () => notice(context, 'Pembayaran belum dikonfirmasi (mode demo).'),
                ),
              ),
            ]),
          ]),
        ),
      ]),
    );
  }
}

class _DetailBox extends StatelessWidget {
  final List<String> lines;
  final bool boldLast;
  const _DetailBox(this.lines, {this.boldLast = false});

  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: _detailBg, borderRadius: BorderRadius.circular(7)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(lines.length, (i) {
            final strong = boldLast && i == lines.length - 1;
            return Padding(
              padding: EdgeInsets.only(bottom: i == lines.length - 1 ? 0 : 4),
              child: Text(lines[i],
                  style: TextStyle(
                      fontSize: 9.5,
                      fontWeight: strong ? FontWeight.w800 : FontWeight.w500,
                      color: strong ? Palette.blue : Palette.navy)),
            );
          }),
        ),
      );
}

class _SmallButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool outlined;
  const _SmallButton(
      {required this.label, required this.onPressed, this.outlined = false});

  @override
  Widget build(BuildContext context) {
    final shape =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(7));
    final text = Text(label,
        style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800,
            color: outlined ? Palette.blue : Colors.white));
    return SizedBox(
      width: double.infinity,
      height: 32,
      child: outlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  side: const BorderSide(color: Palette.blue),
                  shape: shape),
              child: text)
          : FilledButton(
              onPressed: onPressed,
              style: FilledButton.styleFrom(
                  padding: EdgeInsets.zero,
                  backgroundColor: Palette.blue,
                  shape: shape),
              child: text),
    );
  }
}