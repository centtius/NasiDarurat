import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'demo_store.dart';

class NDButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color background;
  final Color foreground;
  final IconData? icon;
  final bool outlined;
  const NDButton({super.key, required this.label, required this.onPressed,
    this.background = Palette.yellow, this.foreground = Palette.navy,
    this.icon, this.outlined = false});

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity, height: 47,
    child: outlined
        ? OutlinedButton.icon(
            onPressed: onPressed,
            icon: icon == null ? const SizedBox.shrink() : Icon(icon, size: 17),
            label: Text(label, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: foreground)),
            style: OutlinedButton.styleFrom(side: BorderSide(color: foreground),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11))),
          )
        : FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(backgroundColor: background, foregroundColor: foreground,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11))),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (icon != null) ...[Icon(icon, size: 16), const SizedBox(width: 7)],
              Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
            ]),
          ),
  );
}

class NDCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color color;
  final Color borderColor;
  const NDCard({super.key, required this.child,
    this.padding = const EdgeInsets.all(14), this.color = Colors.white,
    this.borderColor = Palette.line});
  @override
  Widget build(BuildContext context) => Container(
    padding: padding,
    decoration: BoxDecoration(
      color: color, borderRadius: BorderRadius.circular(14),
      border: Border.all(color: borderColor),
    ), child: child,
  );
}

class NDLabel extends StatelessWidget {
  final String value;
  const NDLabel(this.value, {super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 7),
    child: Text(value, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 11,
      color: Palette.navy)),
  );
}

class NDInput extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final int maxLines;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  const NDInput({super.key, required this.label, this.hint = '', this.controller,
    this.maxLines = 1, this.keyboardType, this.obscureText = false, this.enabled = true});
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      NDLabel(label),
      TextField(controller: controller, maxLines: obscureText ? 1 : maxLines,
        keyboardType: keyboardType, obscureText: obscureText, enabled: enabled,
        style: const TextStyle(fontSize: 13, color: Palette.navy),
        decoration: InputDecoration(hintText: hint)),
    ],
  );
}

class BrandHeader extends StatelessWidget {
  final bool notification;
  const BrandHeader({super.key, this.notification = true});
  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      const Text('Nasi Darurat', style: TextStyle(color: Palette.blue,
        fontSize: 22, fontWeight: FontWeight.w800)),
      if (notification) IconButton(
        onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Belum ada notifikasi baru (mode demo).'))),
        icon: const Icon(Icons.notifications_none_rounded, size: 21),
        style: IconButton.styleFrom(backgroundColor: Colors.white,
          side: const BorderSide(color: Palette.line)),
      ),
    ],
  );
}

class SubHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  const SubHeader(this.title, {super.key, this.subtitle});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 18),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      InkWell(onTap: () => Navigator.of(context).maybePop(),
        borderRadius: BorderRadius.circular(20),
        child: const Padding(padding: EdgeInsets.fromLTRB(0, 3, 13, 6),
          child: Icon(Icons.arrow_back_ios_new, size: 17, color: Palette.blue))),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 18, color: Palette.blue,
          fontWeight: FontWeight.w800)),
        if (subtitle != null) Padding(padding: const EdgeInsets.only(top: 3),
          child: Text(subtitle!, style: const TextStyle(fontSize: 11, color: Palette.gray))),
      ])),
    ]),
  );
}

class SectionHeading extends StatelessWidget {
  final String title;
  const SectionHeading(this.title, {super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(0, 15, 0, 8),
    child: Text(title, style: const TextStyle(color: Palette.navy,
      fontSize: 14, fontWeight: FontWeight.w800)),
  );
}

class StatusChip extends StatelessWidget {
  final String status;
  const StatusChip(this.status, {super.key});
  @override
  Widget build(BuildContext context) {
    Color bg = const Color(0xFFFFE9B6);
    Color fg = const Color(0xFFAB6A00);
    if (status == 'DIPROSES') {bg = Palette.ice; fg = Palette.blue;}
    if (status == 'SELESAI') {bg = Palette.mint; fg = Palette.green;}
    if (status == 'DIBATALKAN' || status == 'MENDESAK') {bg = const Color(0xFFFFE3E4); fg = Palette.red;}
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(16)),
      child: Text(status, style: TextStyle(color: fg, fontWeight: FontWeight.w800, fontSize: 9)),
    );
  }
}

class ThinDivider extends StatelessWidget {
  const ThinDivider({super.key});
  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(vertical: 11),
    child: Divider(height: 1, color: Palette.line),
  );
}

class InfoRow extends StatelessWidget {
  final String left;
  final String right;
  final bool emphasize;
  const InfoRow(this.left, this.right, {super.key, this.emphasize = false});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(flex: 4, child: Text(left, style: const TextStyle(color: Palette.gray, fontSize: 11))),
      Expanded(flex: 6, child: Text(right, textAlign: TextAlign.end,
        style: TextStyle(fontWeight: FontWeight.w700,
          fontSize: emphasize ? 15 : 11,
          color: emphasize ? Palette.blue : Palette.navy))),
    ]),
  );
}

class TrackingSteps extends StatelessWidget {
  final int active;
  final bool vertical;
  const TrackingSteps({super.key, this.active = 2, this.vertical = false});
  @override
  Widget build(BuildContext context) {
    const labels = ['Dikonfirmasi', 'Diproses', 'Dalam Pengiriman', 'Selesai'];
    if (vertical) {
      return Column(children: List.generate(labels.length, (i) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Row(children: [
          Icon(i < active ? Icons.check_circle : Icons.circle_outlined,
            size: 18, color: i < active ? Palette.blue : const Color(0xFFCFD5D9)),
          const SizedBox(width: 10),
          Expanded(child: Text(labels[i], style: TextStyle(fontSize: 12,
            fontWeight: i == active - 1 ? FontWeight.w700 : FontWeight.w400,
            color: i < active ? Palette.navy : Palette.gray))),
        ]),
      )));
    }
    return Row(children: List.generate(labels.length, (i) => Expanded(
      child: Column(children: [
        Row(children: [
          if (i > 0) Expanded(child: Container(height: 2, color: i < active ? Palette.blue : Palette.line)),
          Icon(i < active ? Icons.check_circle : Icons.circle,
            color: i < active ? Palette.blue : const Color(0xFFD9DDE4), size: 19),
          if (i < labels.length - 1) Expanded(child: Container(height: 2,
            color: i < active - 1 ? Palette.blue : Palette.line)),
        ]),
        const SizedBox(height: 7),
        Text(labels[i], textAlign: TextAlign.center, style: TextStyle(fontSize: 9,
          color: i < active ? Palette.navy : Palette.gray,
          fontWeight: i < active ? FontWeight.w700 : FontWeight.w400)),
      ]),
    )));
  }
}

class PagePadding extends StatelessWidget {
  final List<Widget> children;
  const PagePadding({super.key, required this.children});
  @override
  Widget build(BuildContext context) => SafeArea(
    child: ListView(padding: const EdgeInsets.fromLTRB(19, 18, 19, 24), children: children),
  );
}

void notice(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

void openPage(BuildContext context, Widget page) {
  Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
}
