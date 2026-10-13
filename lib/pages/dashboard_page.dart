import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/demo_store.dart';
import '../core/ui.dart';
import 'help_pages.dart';
import 'request_pages.dart';
import 'chat_tracking_pages.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: demoStore,
    builder: (context, _) => PagePadding(children: [
      const BrandHeader(),
      const SizedBox(height: 7),
      NDButton(label: 'Ajukan Bantuan Makanan', icon: Icons.add_circle_outline,
        onPressed: () => openPage(context, const RequestFormPage())),
      const SectionHeading('Permintaan Bantuan Saya'),
      ...demoStore.requests.take(2).map((request) => Padding(
        padding: const EdgeInsets.only(bottom: 9),
        child: InkWell(onTap: () => openPage(context, MyRequestDetailPage(request: request)),
          child: NDCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [Expanded(child: Text(request.title,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800))),
              StatusChip(request.status)]),
            const SizedBox(height: 7),
            Text("Diajukan pada: ${request.status == 'SELESAI' ? '10 Des 2024 · 08:15' : '12 Des 2024 · 10:30'} WIB",
              style: TextStyle(fontSize: 10, color: Palette.gray)),
          ]))),
      )),
      const SectionHeading('Pilihan Penyaluran'),
      Row(children: [
        Expanded(child: _DeliveryCard(icon: Icons.person_pin_circle_outlined,
          title: 'Ambil Sendiri', detail: 'Ambil langsung di posko terdekat',
          onTap: () => notice(context, 'Pilih metode saat mengajukan permintaan.'))),
        const SizedBox(width: 10),
        Expanded(child: _DeliveryCard(icon: Icons.local_shipping_outlined,
          title: 'Diantar Ranger', detail: 'Makanan diantar langsung ke rumah',
          onTap: () => notice(context, 'Pilih metode saat mengajukan permintaan.'))),
      ]),
      const SectionHeading('Update Pengiriman Terkini'),
      NDCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [const Expanded(child: Text('ID Pengiriman: #ND-9842',
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800))),
          TextButton(onPressed: () => openPage(context, const TrackingPage()),
            child: const Text('Detail', style: TextStyle(fontSize: 11)))]),
        const SizedBox(height: 11),
        const TrackingSteps(active: 3),
        const SizedBox(height: 18),
        NDButton(label: 'Chat Admin Posko', icon: Icons.chat_bubble_outline,
          outlined: true, background: Palette.ice, foreground: Palette.blue,
          onPressed: () => openPage(context, const SupportChatPage())),
      ])),
      const SizedBox(height: 14),
    ]),
  );
}

class _DeliveryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String detail;
  final VoidCallback onTap;
  const _DeliveryCard({required this.icon, required this.title,
    required this.detail, required this.onTap});
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap, borderRadius: BorderRadius.circular(13),
    child: NDCard(child: Column(children: [
      CircleAvatar(backgroundColor: Palette.ice, radius: 21,
        child: Icon(icon, size: 22, color: Palette.blue)),
      const SizedBox(height: 8),
      Text(title, textAlign: TextAlign.center, style: const TextStyle(
        fontSize: 12, fontWeight: FontWeight.w800)),
      const SizedBox(height: 5),
      Text(detail, textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 10, color: Palette.gray)),
    ])),
  );
}
