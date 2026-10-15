import 'package:flutter/material.dart';
import '../main.dart';
import '../core/app_theme.dart';
import '../core/demo_store.dart';
import '../core/ui.dart';
import 'donor_nav.dart';

class NotifikasiPage extends StatelessWidget {
  final bool showBottomNav;
  const NotifikasiPage({super.key, this.showBottomNav = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagePadding(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Expanded(child: SubHeader('Notifikasi')),
          IconButton(
            onPressed: () => notice(context, 'Belum ada notifikasi baru (mode demo).'),
            icon: const Icon(Icons.notifications_none_rounded, size: 21),
            style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Palette.line)),
          ),
        ]),
        _NotifCard(
          icon: Icons.card_giftcard_rounded,
          iconBg: Palette.mint,
          iconColor: Palette.green,
          unread: true,
          spans: const [
            TextSpan(text: 'Terima kasih! '),
            TextSpan(text: 'Rp 60.000', style: TextStyle(fontWeight: FontWeight.w800)),
            TextSpan(
                text:
                    ' dari donasi Anda telah digunakan untuk Bantuan A (Ibu Sari — Bahan Pokok).'),
          ],
          time: '2 jam lalu',
          action: 'Lihat Laporan',
          actionColor: Palette.blue,
          onAction: () => notice(context, 'Laporan (mode demo).'),
        ),
        _NotifCard(
          icon: Icons.card_giftcard_rounded,
          iconBg: Palette.mint,
          iconColor: Palette.green,
          unread: true,
          spans: const [
            TextSpan(text: 'Rp 25.000', style: TextStyle(fontWeight: FontWeight.w800)),
            TextSpan(
                text:
                    ' dari donasi Anda telah digunakan untuk Bantuan B (Pak Budi — Susu Bayi).'),
          ],
          time: '1 hari lalu',
          action: 'Lihat Laporan',
          actionColor: Palette.blue,
          onAction: () => notice(context, 'Laporan (mode demo).'),
        ),
        const _NotifCard(
          icon: Icons.check_rounded,
          iconBg: Palette.ice,
          iconColor: Palette.blue,
          spans: [TextSpan(text: 'Pembayaran donasi Rp 100.000 berhasil dikonfirmasi.')],
          time: '2 hari lalu',
        ),
        _NotifCard(
          icon: Icons.access_time_rounded,
          iconBg: const Color(0xFFFFEFC4),
          iconColor: const Color(0xFFE8A200),
          spans: const [
            TextSpan(text: 'Pembayaran donasi Rp 100.000 masih menunggu konfirmasi.')
          ],
          time: '2 hari lalu',
          action: 'Cek Status',
          actionColor: const Color(0xFFE8A200),
          onAction: () => notice(context, 'Pembayaran belum dikonfirmasi (mode demo).'),
        ),
        const _NotifCard(
          icon: Icons.info_outline_rounded,
          iconBg: Palette.ice,
          iconColor: Palette.blue,
          spans: [
            TextSpan(
                text:
                    'Dana Tersedia saat ini: Rp 12.450.000. Terima kasih atas kontribusi Anda!')
          ],
          time: '3 hari lalu',
        ),
      ]),
      bottomNavigationBar: showBottomNav ? const DonorBottomNav() : null,
    );
  }
}

class _NotifCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg, iconColor;
  final List<InlineSpan> spans;
  final String time;
  final String? action;
  final Color actionColor;
  final VoidCallback? onAction;
  final bool unread;

  const _NotifCard({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.spans,
    required this.time,
    this.action,
    this.actionColor = Palette.blue,
    this.onAction,
    this.unread = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: unread ? const Color(0xFFFFFCEF) : Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color: unread ? const Color(0xFFF0E3B0) : Palette.line),
        ),
        child: Stack(children: [
          if (unread)
            const Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 3,
              child: ColoredBox(color: Palette.yellow),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(13, 12, 13, 11),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: iconBg,
                child: Icon(icon, size: 15, color: iconColor),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text.rich(
                    TextSpan(children: spans),
                    style: const TextStyle(
                        fontSize: 11, height: 1.4, color: Palette.navy),
                  ),
                  const SizedBox(height: 8),
                  Row(children: [
                    Text(time,
                        style: const TextStyle(fontSize: 9, color: Palette.gray)),
                    const Spacer(),
                    if (action != null)
                      InkWell(
                        onTap: onAction,
                        child: Text(action!,
                            style: TextStyle(
                                fontSize: 9.5,
                                fontWeight: FontWeight.w800,
                                color: actionColor)),
                      ),
                  ]),
                ]),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}