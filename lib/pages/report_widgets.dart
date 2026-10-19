import 'package:flutter/material.dart';
import '../main.dart';
import '../core/app_theme.dart';
import '../core/demo_store.dart';
import '../core/ui.dart';

/// Tombol bel di pojok kanan atas header.
class NotifBell extends StatelessWidget {
  const NotifBell({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () => notice(context, 'Belum ada notifikasi baru (mode demo).'),
        icon: const Icon(Icons.notifications_none_rounded, size: 21),
        style: IconButton.styleFrom(
            backgroundColor: Colors.white,
            side: const BorderSide(color: Palette.line)),
      );
}

/// Kotak biru muda (ringkasan donasi).
class InfoBox extends StatelessWidget {
  final Widget child;
  const InfoBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) => NDCard(
        color: Palette.ice,
        borderColor: const Color(0xFFD6E6FA),
        padding: const EdgeInsets.all(14),
        child: SizedBox(width: double.infinity, child: child),
      );
}

/// Kotak kuning (catatan / informasi).
class NoteBox extends StatelessWidget {
  final Widget child;
  const NoteBox({super.key, required this.child});

  @override
  Widget build(BuildContext context) => NDCard(
        color: const Color(0xFFFFF1C2),
        borderColor: const Color(0xFFF0DC8A),
        padding: const EdgeInsets.all(13),
        child: SizedBox(width: double.infinity, child: child),
      );
}

/// Badge status kecil (TERSALURKAN, SELESAI, DIPROSES, ...).
class ReportBadge extends StatelessWidget {
  final String label;
  final Color bg, fg;
  const ReportBadge.success(this.label, {super.key})
      : bg = Palette.mint,
        fg = Palette.green;
  const ReportBadge.info(this.label, {super.key})
      : bg = Palette.ice,
        fg = Palette.blue;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
        decoration:
            BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
        child: Text(label,
            style: TextStyle(
                fontSize: 8.5, fontWeight: FontWeight.w800, color: fg)),
      );
}