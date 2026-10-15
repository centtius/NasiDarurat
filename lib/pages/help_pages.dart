import 'package:flutter/material.dart';
import '../main.dart';
import '../core/app_theme.dart';
import '../core/demo_store.dart';
import '../core/ui.dart';

class AidListing {
  final String name;
  final String title;
  final String location;
  final int value;
  final String status;
  final String age;
  final String summary;
  const AidListing(this.name, this.title, this.location,
    this.value, this.status, this.age, this.summary);
}

const listings = [
  AidListing('Ibu Sari', 'Bahan Pokok', 'Kec. Lowokwaru, Malang', 350000,
    'DALAM ANTREAN', '2 jam lalu', 'Beras 5 kg, minyak goreng 2 L, gula 1 kg, telur 1 tray'),
  AidListing('Pak Budi', 'Beras & Minyak', 'Kec. Klojen, Malang', 150000,
    'DIPROSES', '5 jam lalu', 'Beras 10 kg dan minyak goreng 2 L'),
  AidListing('Mbak Rina', 'Susu Bayi', 'Kec. Blimbing, Malang', 250000,
    'SELESAI', '1 hari lalu', 'Susu dan perlengkapan bayi'),
  AidListing('Pak Joko', 'Bahan Pokok', 'Kec. Kedungkandang, Malang', 400000,
    'MENDESAK', '2 hari lalu', 'Paket sembako untuk keluarga'),
];

class HelpListPage extends StatefulWidget {
  const HelpListPage({super.key});
  @override
  State<HelpListPage> createState() => _HelpListPageState();
}

class _HelpListPageState extends State<HelpListPage> {
  String filter = 'Semua';
  String search = '';
  @override
  Widget build(BuildContext context) {
    final data = listings.where((item) {
      final matchesFilter = filter == 'Semua' || item.status ==
        (filter == 'Antrean' ? 'DALAM ANTREAN' : filter.toUpperCase());
      final query = search.toLowerCase();
      final matchesSearch = item.title.toLowerCase().contains(query) ||
        item.name.toLowerCase().contains(query) || item.location.toLowerCase().contains(query);
      return matchesFilter && matchesSearch;
    }).toList();
    return PagePadding(children: [
      const BrandHeader(),
      const SizedBox(height: 10),
      TextField(onChanged: (text) => setState(() => search = text),
        decoration: const InputDecoration(prefixIcon: Icon(Icons.search, size: 20),
          hintText: 'Cari permintaan...', isDense: true)),
      const SizedBox(height: 11),
      SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: [
        for (final option in ['Semua', 'Antrean', 'Diproses', 'Selesai'])
          Padding(padding: const EdgeInsets.only(right: 7), child: ChoiceChip(
            label: Text(option), selected: filter == option,
            labelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w700,
              color: filter == option ? Colors.white : Palette.navy),
            selectedColor: Palette.blue, backgroundColor: Colors.white,
            showCheckmark: false,
            side: BorderSide(color: filter == option ? Palette.blue : Palette.line),
            onSelected: (_) => setState(() => filter = option),
          )),
      ])),
      const SizedBox(height: 13),
      if (data.isEmpty) const Padding(padding: EdgeInsets.all(20),
        child: Center(child: Text('Tidak ada permintaan yang cocok.'))),
      ...data.map((aid) => Padding(padding: const EdgeInsets.only(bottom: 10),
        child: InkWell(borderRadius: BorderRadius.circular(13),
          onTap: () => openPage(context, HelpDetailPage(aid: aid)),
          child: NDCard(child: Column(children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              CircleAvatar(radius: 18, backgroundColor: Palette.ice,
                child: Text(aid.name.split(' ').last.substring(0, 1),
                  style: const TextStyle(fontWeight: FontWeight.w800, color: Palette.blue))),
              const SizedBox(width: 10),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(aid.name, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
                const SizedBox(height: 2),
                Text(aid.title, style: const TextStyle(color: Palette.blue,
                  fontWeight: FontWeight.w700, fontSize: 12)),
                const SizedBox(height: 4),
                Text(aid.location, style: const TextStyle(color: Palette.gray, fontSize: 10)),
              ])),
              StatusChip(aid.status),
            ]),
            const SizedBox(height: 7),
            Row(children: [
              Text(rupiah(aid.value), style: const TextStyle(fontSize: 14,
                fontWeight: FontWeight.w900, color: Palette.navy)),
              const Spacer(),
              Text(aid.age, style: const TextStyle(fontSize: 10, color: Palette.gray)),
              const Icon(Icons.chevron_right, color: Palette.blue, size: 22),
            ]),
          ]))),
      )),
    ]);
  }
}

class HelpDetailPage extends StatelessWidget {
  final AidListing aid;
  const HelpDetailPage({super.key, required this.aid});
  @override
  Widget build(BuildContext context) => DetailScaffold(navTab: 1, body: PagePadding(children: [
    const SubHeader('Detail Bantuan'),
    NDCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('KEBUTUHAN', style: TextStyle(fontSize: 10,
        fontWeight: FontWeight.w800, color: Palette.blue)),
      const SizedBox(height: 9),
      const Text('Jenis Bantuan', style: TextStyle(fontSize: 10, color: Palette.gray)),
      Text(aid.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
      const ThinDivider(),
      const Text('Rincian', style: TextStyle(fontSize: 10, color: Palette.gray)),
      const SizedBox(height: 6),
      Text(aid.summary, style: const TextStyle(fontSize: 12)),
      const ThinDivider(),
      InfoRow('Nominal Dibutuhkan', rupiah(aid.value), emphasize: true),
    ])),
    const SizedBox(height: 10),
    NDCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('LOKASI UMUM', style: TextStyle(fontSize: 10,
        fontWeight: FontWeight.w800, color: Palette.blue)),
      const SizedBox(height: 7),
      Row(children: [const Icon(Icons.location_on_outlined, size: 17, color: Palette.blue),
        const SizedBox(width: 6), Text(aid.location, style: const TextStyle(fontSize: 12))]),
    ])),
    const SizedBox(height: 10),
    const NDCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('METODE PENYALURAN', style: TextStyle(fontSize: 10,
        fontWeight: FontWeight.w800, color: Palette.blue)),
      SizedBox(height: 7),
      Row(children: [Icon(Icons.local_shipping_outlined, size: 17, color: Palette.yellow),
        SizedBox(width: 7), Expanded(child: Text('Dibelikan & Diantar Ranger',
          style: TextStyle(fontSize: 12)))]),
    ])),
    const SizedBox(height: 10),
    NDCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('LINIMASA STATUS', style: TextStyle(fontSize: 10,
        fontWeight: FontWeight.w800, color: Palette.blue)),
      const SizedBox(height: 10),
      const TrackingSteps(vertical: true, active: 1),
      const SizedBox(height: 6),
      StatusChip(aid.status),
    ])),
    const SizedBox(height: 17),
    const Text('Anda harus dapat melihat detail permintaan ini. Untuk pertanyaan, hubungi admin melalui menu Chat.',
      style: TextStyle(color: Palette.gray, fontSize: 11), textAlign: TextAlign.center),
  ]));
}
