import 'package:flutter/material.dart';
import '../core/app_theme.dart';

/// Bottom navigation donor (Beranda, Chat, Riwayat, Laporan, Profil).
class DonorBottomNav extends StatelessWidget {
  final int selected;
  final ValueChanged<int>? onSelected;
  const DonorBottomNav({super.key, this.selected = 0, this.onSelected});

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
            children: List.generate(items.length, (i) {
              final active = i == selected;
              final c = active ? Palette.blue : Palette.navy;
              return Expanded(
                child: InkWell(
                  onTap: onSelected == null ? null : () => onSelected!(i),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Icon(items[i].$1, size: 21, color: c),
                    const SizedBox(height: 3),
                    Text(items[i].$2,
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight:
                                active ? FontWeight.w800 : FontWeight.w500,
                            color: c)),
                  ]),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}