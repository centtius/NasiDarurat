import 'package:flutter/material.dart';
import '../core/app_theme.dart';

/// Tag kecil berwarna (ADMIN, MENDESAK, NORMAL, TERKIRIM, DALAM ANTREAN, ...).
class AdminTag extends StatelessWidget {
  final String label;
  final Color bg, fg;
  const AdminTag.danger(this.label, {super.key})
      : bg = const Color(0xFFFFE3E4),
        fg = Palette.red;
  const AdminTag.info(this.label, {super.key})
      : bg = Palette.ice,
        fg = Palette.blue;
  const AdminTag.success(this.label, {super.key})
      : bg = Palette.mint,
        fg = Palette.green;
  const AdminTag.warn(this.label, {super.key})
      : bg = const Color(0xFFFFEFC4),
        fg = const Color(0xFFAB6A00);

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

/// Bottom navigation admin: Beranda, Bantuan, Permintaan, Chat, Profil.
class AdminBottomNav extends StatelessWidget {
  final int selected;
  final ValueChanged<int>? onSelected;
  const AdminBottomNav({super.key, this.selected = 0, this.onSelected});

  @override
  Widget build(BuildContext context) {
    const items = [
      (Icons.home_outlined, 'Beranda'),
      (Icons.search_rounded, 'Bantuan'),
      (Icons.format_list_bulleted, 'Permintaan'),
      (Icons.chat_bubble_outline_rounded, 'Chat'),
      (Icons.person_outline_rounded, 'Profil'),
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