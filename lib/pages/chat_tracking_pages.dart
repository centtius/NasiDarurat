import 'package:flutter/material.dart';
import '../main.dart';
import '../core/app_theme.dart';
import '../core/demo_store.dart';
import '../core/ui.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});
  @override
  Widget build(BuildContext context) => PagePadding(children: [
    const BrandHeader(),
    const SectionHeading('Percakapan Saya'),
    InkWell(
        onTap: () => openPage(context, const SupportChatPage()),
        borderRadius: BorderRadius.circular(14),
        child: const NDCard(
          child: Row(children: [
            CircleAvatar(
                backgroundColor: Palette.ice,
                child: Icon(Icons.support_agent, color: Palette.blue)),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Chat Admin Nasi Darurat',
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
                  SizedBox(height: 5),
                  Text('Halo Ayu, kami sudah membaca permintaanmu...',
                      style: TextStyle(fontSize: 11, color: Palette.gray),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Palette.blue),
          ]),
        )),
  ]);
}

class SupportChatPage extends StatefulWidget {
  const SupportChatPage({super.key});
  @override
  State<SupportChatPage> createState() => _SupportChatPageState();
}

class _SupportChatPageState extends State<SupportChatPage> {
  final controller = TextEditingController();
  final scroll = ScrollController();
  @override
  void dispose() {
    controller.dispose();
    scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DetailScaffold(
      navTab: 3,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 17, 18, 0),
            child: Column(children: [
              const SubHeader('Chat Admin',
                  subtitle: 'Status: sedang diskusi untuk aktivitas Anda'),
              NDCard(
                  color: Palette.ice,
                  borderColor: Colors.transparent,
                  child: Row(children: [
                    const Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text('Permintaan ND-2026-0891',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: Palette.blue)),
                          SizedBox(height: 5),
                          Text('Bantuan makanan · Rp350.000',
                              style: TextStyle(fontSize: 11)),
                        ])),
                    StatusChip(demoStore.currentRequest.status),
                  ])),
              const SizedBox(height: 14),
            ]),
          ),
          Expanded(
              child: AnimatedBuilder(
                  animation: demoStore,
                  builder: (context, _) => ListView(
                        controller: scroll,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 12),
                        children: [
                          const Center(
                              child: Text('Hari ini',
                                  style: TextStyle(
                                      fontSize: 10, color: Palette.gray))),
                          const SizedBox(height: 22),
                          ...demoStore.chat.map((message) => Align(
                                alignment: message.mine
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 275),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 12),
                                    child: NDCard(
                                      color: message.mine
                                          ? Palette.ice
                                          : Colors.white,
                                      borderColor: Colors.transparent,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            if (!message.mine)
                                              const Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                      'Admin Nasi Darurat',
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: Palette.blue,
                                                          fontWeight:
                                                              FontWeight
                                                                  .w800))),
                                            Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                child: Text(message.content,
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        height: 1.55,
                                                        color: Palette.navy))),
                                            Text(message.time,
                                                style: const TextStyle(
                                                    fontSize: 9,
                                                    color: Palette.gray)),
                                          ]),
                                    ),
                                  ),
                                ),
                              )),
                          const SizedBox(height: 8),
                          const NDCard(
                              color: Palette.mint,
                              borderColor: Colors.transparent,
                              child: Text(
                                  'Status berubah menjadi Diproses. Setelah admin mengonfirmasi bantuan, ranger akan menyiapkannya.',
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Palette.green,
                                      height: 1.5))),
                        ],
                      ))),
          Container(
              padding: const EdgeInsets.fromLTRB(13, 9, 13, 10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Palette.line))),
              child: Row(children: [
                Expanded(
                    child: TextField(
                        controller: controller,
                        decoration: const InputDecoration(
                            hintText: 'Tulis pesan ke admin...',
                            isDense: true))),
                const SizedBox(width: 9),
                FilledButton(
                    onPressed: () {
                      if (controller.text.trim().isEmpty) {
                        return;
                      }
                      demoStore.sendMessage(controller.text);
                      controller.clear();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (scroll.hasClients) {
                          scroll.animateTo(
                              scroll.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOut);
                        }
                      });
                    },
                    style: FilledButton.styleFrom(
                        backgroundColor: Palette.blue),
                    child: const Text('Kirim',
                        style: TextStyle(fontSize: 12))),
              ])),
        ]),
      ));
}

class TrackingPage extends StatelessWidget {
  const TrackingPage({super.key});
  @override
  Widget build(BuildContext context) => DetailScaffold(
      navTab: 2,
      body: PagePadding(children: [
        const SubHeader('Lacak Bantuan', subtitle: 'Pengantaran ND-9842'),
        const NDCard(
            color: Palette.ice,
            borderColor: Colors.transparent,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bantuan makanan Anda sedang diantar',
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 13,
                          color: Palette.blue)),
                  SizedBox(height: 7),
                  Text('Ranger: Raka Pradya • Tim Nasi Darurat',
                      style: TextStyle(fontSize: 11)),
                ])),
        const SizedBox(height: 11),
        const _MockRouteMap(),
        const SizedBox(height: 10),
        const NDCard(
            color: Color(0xFFFFF1C7),
            borderColor: Colors.transparent,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Posisi terakhir diperbarui 10:42',
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w800)),
                  SizedBox(height: 5),
                  Text('Peta tidak menunjukkan pergerakan secara langsung.',
                      style: TextStyle(fontSize: 11, color: Palette.gray)),
                ])),
        const SectionHeading('Tahap pengiriman'),
        const NDCard(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('● Belanja selesai',
                      style: TextStyle(fontSize: 12, color: Palette.green)),
                  SizedBox(height: 9),
                  Text('● Dalam perjalanan',
                      style: TextStyle(fontSize: 12, color: Palette.green)),
                  SizedBox(height: 9),
                  Text('○ Diserahkan ke penerima',
                      style: TextStyle(fontSize: 12, color: Palette.gray)),
                ])),
        const SizedBox(height: 20),
        NDButton(
            label: 'Chat Admin',
            background: Palette.blue,
            foreground: Colors.white,
            onPressed: () => openPage(context, const SupportChatPage())),
        const SizedBox(height: 9),
        NDButton(
            label: 'Lihat Bukti Penyerahan',
            outlined: true,
            foreground: Palette.blue,
            onPressed: () => openPage(context, const ProofPage())),
      ]));
}

class _MockRouteMap extends StatelessWidget {
  const _MockRouteMap();
  @override
  Widget build(BuildContext context) => Container(
        height: 292,
        decoration: BoxDecoration(
            color: const Color(0xFFEBF2ED),
            borderRadius: BorderRadius.circular(13)),
        clipBehavior: Clip.antiAlias,
        child: CustomPaint(
          painter: _RoutePainter(),
          child: const Stack(children: [
            Positioned(
                top: 40,
                right: 35,
                child: Column(children: [
                  Icon(Icons.location_on, color: Palette.yellow, size: 27),
                  Text('Tujuan',
                      style: TextStyle(
                          fontSize: 11,
                          color: Palette.blue,
                          fontWeight: FontWeight.w700)),
                ])),
            Positioned(
                bottom: 47,
                left: 32,
                child: Column(children: [
                  Icon(Icons.circle, color: Palette.blue, size: 18),
                  SizedBox(height: 4),
                  Text('Ranger',
                      style: TextStyle(
                          fontSize: 11,
                          color: Palette.navy,
                          fontWeight: FontWeight.w700)),
                ])),
          ]),
        ),
      );
}

class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final road = Paint()
      ..color = const Color(0xFFD3DFDE)
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(25, size.height * .52),
        Offset(size.width - 25, size.height * .52), road);
    canvas.drawLine(Offset(size.width * .52, 20),
        Offset(size.width * .52, size.height - 22), road);
    final route = Paint()
      ..color = const Color(0xFF65ACF7)
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final path = Path()
      ..moveTo(39, size.height - 57)
      ..lineTo(size.width * .52, size.height - 57)
      ..lineTo(size.width * .52, size.height * .32)
      ..lineTo(size.width - 48, size.height * .32);
    canvas.drawPath(path, route);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ProofPage extends StatelessWidget {
  const ProofPage({super.key});
  @override
  Widget build(BuildContext context) => DetailScaffold(
      navTab: 2,
      body: PagePadding(children: [
        const SubHeader('Bukti Penyerahan',
            subtitle: 'Tugas ND-9842 · Ayu Pratama'),
        const NDCard(
            color: Color(0xFFFFF0C7),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bukti ranger diperlukan',
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w800)),
                  SizedBox(height: 9),
                  Text(
                      'Foto makanan/barang di lokasi penyerahan dan struk belanja.',
                      style: TextStyle(fontSize: 11, height: 1.6)),
                ])),
        const SizedBox(height: 13),
        Row(children: [
          Expanded(child: _UploadPlaceholder(label: 'Foto penyerahan')),
          const SizedBox(width: 12),
          Expanded(child: _UploadPlaceholder(label: 'Struk belanja')),
        ]),
        const SizedBox(height: 16),
        const NDInput(
            label: 'Catatan untuk admin',
            hint:
                'Contoh: tiga nasi bungkus telah diterima langsung oleh penerima.',
            maxLines: 3),
        const SectionHeading('Tahap berikutnya'),
        const NDCard(
            color: Palette.ice,
            borderColor: Colors.transparent,
            child: Text(
                'Penerima juga mengunggah bukti penerimaan. Status Selesai baru ditetapkan setelah admin memeriksa bukti fisik.',
                style: TextStyle(fontSize: 12, height: 1.6))),
        const SizedBox(height: 23),
        NDButton(
            label: 'Kirim Bukti ke Admin',
            background: Palette.blue,
            foreground: Colors.white,
            onPressed: () => openPage(context, const CompletedPage())),
        const SizedBox(height: 8),
        const Text(
            'Mode demo: unggahan hanya placeholder. Belum tersimpan ke server.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10, color: Palette.gray)),
      ]));
}

class _UploadPlaceholder extends StatelessWidget {
  final String label;
  const _UploadPlaceholder({required this.label});
  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => notice(context,
            'Fitur unggah foto akan ditambahkan saat integrasi backend.'),
        borderRadius: BorderRadius.circular(13),
        child: Container(
          height: 155,
          decoration: BoxDecoration(
              color: const Color(0xFFF0F2F5),
              borderRadius: BorderRadius.circular(13),
              border: Border.all(color: Palette.line)),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add, color: Palette.blue, size: 32),
                const SizedBox(height: 9),
                Text(label, style: const TextStyle(fontSize: 11)),
              ]),
        ),
      );
}

class CompletedPage extends StatelessWidget {
  const CompletedPage({super.key});
  @override
  Widget build(BuildContext context) => DetailScaffold(
      navTab: 2,
      body: PagePadding(children: [
        const SubHeader('Bantuan Selesai',
            subtitle: 'Riwayat lengkap & transparansi publik'),
        const NDCard(
            color: Palette.mint,
            borderColor: Colors.transparent,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StatusChip('SELESAI'),
                  SizedBox(height: 12),
                  Text('Bantuan bahan pokok untuk Ayu',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Palette.navy)),
                  SizedBox(height: 9),
                  Text('Tersalurkan, Yogyakarta · Rp350.000 diterima',
                      style: TextStyle(fontSize: 11)),
                ])),
        const SectionHeading('Riwayat status'),
        const NDCard(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('● Dalam Antrean · 10:00',
                      style:
                          TextStyle(fontSize: 12, color: Palette.green)),
                  SizedBox(height: 8),
                  Text('● Diproses · admin chat 10:02',
                      style:
                          TextStyle(fontSize: 12, color: Palette.green)),
                  SizedBox(height: 8),
                  Text('● Bukti diterima · 12:08',
                      style:
                          TextStyle(fontSize: 12, color: Palette.green)),
                  SizedBox(height: 8),
                  Text('● Selesai · diverifikasi admin 12:20',
                      style:
                          TextStyle(fontSize: 12, color: Palette.green)),
                ])),
        const SectionHeading('Laporan penyaluran'),
        const NDCard(
            child: Text(
                'Bahan makanan telah diserahkan. Bukti akhir diperiksa admin. Detail foto dan alamat disimpan untuk pihak terkait.',
                style: TextStyle(fontSize: 12, height: 1.6))),
        const SizedBox(height: 14),
        const NDCard(
            color: Color(0xFFFFF0C8),
            borderColor: Colors.transparent,
            child: Text(
                'Tidak lagi di antrean aktif\nTetap ada pada filter Selesai dan laporan agar riwayat bantuan dapat ditelusuri.',
                style: TextStyle(fontSize: 12, height: 1.65))),
      ]));
}