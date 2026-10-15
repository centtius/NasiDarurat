import 'package:flutter/material.dart';
import '../main.dart';
import '../core/app_theme.dart';
import '../core/demo_store.dart';
import '../core/ui.dart';
import 'chat_tracking_pages.dart';

class RequestFormPage extends StatefulWidget {
  const RequestFormPage({super.key});
  @override
  State<RequestFormPage> createState() => _RequestFormPageState();
}

class _RequestFormPageState extends State<RequestFormPage> {
  String type = 'Bahan Pokok';
  String delivery = 'Dibelikan & Diantar Ranger';
  final details = TextEditingController();
  final money = TextEditingController();
  final reason = TextEditingController();
  final location = TextEditingController(text: 'Kec. Lowokwaru, Malang');
  final address = TextEditingController(text: 'Jl. Sumbersari No. 12, RT 03/RW 05');

  @override
  void dispose() {
    details.dispose(); money.dispose(); reason.dispose(); location.dispose(); address.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DetailScaffold(showNav: false, body: PagePadding(children: [
    const SubHeader('Ajukan Bantuan'),
    const SizedBox(height: 2),
    const NDLabel('Jenis Bantuan'),
    DropdownButtonFormField<String>(
      value: type,
      decoration: const InputDecoration(isDense: true),
      items: const ['Bahan Pokok', 'Makanan Siap Saji', 'Susu Bayi', 'Lainnya']
        .map((e) => DropdownMenuItem(value: e, child: Text(e,
          style: const TextStyle(fontSize: 12)))).toList(),
      onChanged: (v) => setState(() => type = v ?? type),
    ),
    const SizedBox(height: 15),
    NDInput(label: 'Rincian Kebutuhan', hint: 'Jelaskan kebutuhan Anda secara detail...',
      maxLines: 3, controller: details),
    const SizedBox(height: 15),
    NDInput(label: 'Nominal yang Dibutuhkan', hint: 'Maksimal Rp 30.000.000',
      controller: money, keyboardType: TextInputType.number),
    const SizedBox(height: 15),
    NDInput(label: 'Alasan Singkat', hint: 'Mengapa Anda membutuhkan bantuan ini?',
      controller: reason, maxLines: 3),
    const SectionHeading('LOKASI'),
    NDInput(label: 'Lokasi Umum', controller: location),
    const SizedBox(height: 14),
    NDInput(label: 'Alamat Lengkap', controller: address, maxLines: 2),
    const SizedBox(height: 6),
    const Text('Hanya terlihat oleh admin & ranger terkait',
      style: TextStyle(color: Palette.gray, fontSize: 10)),
    const SectionHeading('METODE PENYALURAN'),
    ...['Transfer Dana', 'Dibelikan & Diantar Ranger', 'Kirim via Kurir (Biteship)', 'Ambil Sendiri'].map((option) =>
      Padding(padding: const EdgeInsets.only(bottom: 7),
        child: InkWell(onTap: () => setState(() => delivery = option),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
            decoration: BoxDecoration(color: delivery == option ? Palette.ice : Colors.white,
              borderRadius: BorderRadius.circular(11),
              border: Border.all(color: delivery == option ? Palette.blue : Palette.line)),
            child: Row(children: [
              Icon(option.contains('Ranger') ? Icons.local_shipping_outlined :
                option.contains('Transfer') ? Icons.account_balance_wallet_outlined :
                option.contains('Kurir') ? Icons.inventory_2_outlined : Icons.person_outline,
                size: 18, color: Palette.blue),
              const SizedBox(width: 8),
              Expanded(child: Text(option, style: const TextStyle(fontSize: 12,
                color: Palette.navy, fontWeight: FontWeight.w700))),
              Radio<String>(value: option, groupValue: delivery,
                activeColor: Palette.blue,
                onChanged: (v) => setState(() => delivery = v ?? delivery)),
            ]),
          )),
      )),
    const SizedBox(height: 7),
    NDButton(label: 'Kirim Permintaan', onPressed: () {
      final amount = int.tryParse(money.text.replaceAll(RegExp(r'[^0-9]'), '')) ?? 350000;
      if (amount <= 0 || amount > 30000000) {
        notice(context, 'Nominal harus antara Rp 1 dan Rp 30.000.000.');
        return;
      }
      demoStore.addRequest(type: type, description: details.text,
        nominal: amount, reason: reason.text, location: location.text,
        method: delivery);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => const SubmittedPage()));
    }),
  ]));
}

class SubmittedPage extends StatelessWidget {
  const SubmittedPage({super.key});
  @override
  Widget build(BuildContext context) => DetailScaffold(showNav: false, body: SafeArea(
    child: Padding(padding: const EdgeInsets.all(25), child: Column(children: [
      Align(alignment: Alignment.centerLeft, child: IconButton(
        onPressed: () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const RootShell()), (route) => false),
        icon: const Icon(Icons.arrow_back_ios, size: 18, color: Palette.blue))),
      const Spacer(),
      const CircleAvatar(radius: 45, backgroundColor: Palette.mint,
        child: Icon(Icons.check_rounded, color: Palette.green, size: 52)),
      const SizedBox(height: 27),
      const Text('Permintaan Terkirim!', textAlign: TextAlign.center,
        style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900)),
      const SizedBox(height: 14),
      const Text('Permintaan bantuan Anda telah berhasil dikirim dan langsung tampil di halaman Bantuan dengan status Dalam Antrean.\n\nAdmin akan menghubungi Anda melalui chat untuk memproses permintaan ini. Pantau status di halaman Permintaan Saya.',
        textAlign: TextAlign.center, style: TextStyle(color: Palette.gray, fontSize: 12, height: 1.6)),
      const SizedBox(height: 24),
      NDCard(color: const Color(0xFFFFF1C7), child: Column(children: [
        const InfoRow('Status saat ini', 'DALAM ANTREAN'),
        InfoRow('Nomor permintaan', '#${demoStore.currentRequest.id}', emphasize: true),
      ])),
      const Spacer(),
      NDButton(label: 'Lihat Permintaan Saya', background: Palette.blue, foreground: Colors.white,
        onPressed: () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const RootShell(initialTab: 2)), (route) => false)),
      const SizedBox(height: 9),
      NDButton(label: 'Kembali ke Beranda', outlined: true,
        foreground: Palette.blue,
        onPressed: () => Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const RootShell()), (route) => false)),
    ])),
  ));
}

class MyRequestsPage extends StatelessWidget {
  const MyRequestsPage({super.key});
  @override
  Widget build(BuildContext context) => AnimatedBuilder(animation: demoStore,
    builder: (context, _) => PagePadding(children: [
      const BrandHeader(),
      const SectionHeading('Permintaan Bantuan Saya'),
      ...demoStore.requests.map((r) => Padding(padding: const EdgeInsets.only(bottom: 11),
        child: InkWell(onTap: () => openPage(context, MyRequestDetailPage(request: r)),
          child: NDCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [Expanded(child: Text(r.title, style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w800))), StatusChip(r.status)]),
            const SizedBox(height: 9),
            InfoRow('Jenis bantuan', r.type),
            InfoRow('Nominal', rupiah(r.nominal), emphasize: true),
            const ThinDivider(),
            const Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Text('Lihat Detail', style: TextStyle(color: Palette.blue,
                fontSize: 12, fontWeight: FontWeight.w700)),
              Icon(Icons.chevron_right, color: Palette.blue),
            ]),
          ]))),
      )),
      const SizedBox(height: 15),
      NDButton(label: 'Ajukan Bantuan Baru', icon: Icons.add,
        onPressed: () => openPage(context, const RequestFormPage())),
    ]),
  );
}

class MyRequestDetailPage extends StatelessWidget {
  final HelpRequest request;
  const MyRequestDetailPage({super.key, required this.request});
  @override
  Widget build(BuildContext context) => DetailScaffold(navTab: 2, body: AnimatedBuilder(
    animation: demoStore, builder: (context, _) => PagePadding(children: [
      const SubHeader('Permintaan Saya'),
      NDCard(color: Palette.blue, borderColor: Palette.blue,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [Expanded(child: Text('Nomor #${request.id}',
            style: const TextStyle(fontSize: 12, color: Colors.white))),
            StatusChip(request.status)]),
          const SizedBox(height: 9),
          const Text('Diajukan pada: 28 Sep 2026, 09:15 WIB',
            style: TextStyle(color: Colors.white70, fontSize: 11)),
        ])),
      const SectionHeading('DETAIL KEBUTUHAN'),
      NDCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        InfoRow('Jenis Bantuan', request.type),
        const ThinDivider(),
        const Text('Rincian', style: TextStyle(color: Palette.gray, fontSize: 11)),
        const SizedBox(height: 6),
        Text(request.description, style: const TextStyle(fontSize: 12)),
        const ThinDivider(),
        InfoRow('Nominal', rupiah(request.nominal), emphasize: true),
        InfoRow('Metode', request.method),
      ])),
      const SectionHeading('PEMBARUAN'),
      const NDCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('• Admin Rina memulai chat dengan Anda · 09:30',
          style: TextStyle(fontSize: 11)),
        SizedBox(height: 9),
        Text('• Permintaan dikirim · 08:15', style: TextStyle(fontSize: 11)),
      ])),
      const SectionHeading('TAHAP PENGIRIMAN'),
      const NDCard(child: Column(children: [
        TrackingSteps(active: 2),
        SizedBox(height: 10),
        Text('Tahap pengiriman diperbarui oleh ranger',
          style: TextStyle(fontSize: 11, color: Palette.gray)),
      ])),
      const SizedBox(height: 18),
      NDButton(label: 'Chat Admin', background: Palette.blue, foreground: Colors.white,
        icon: Icons.chat_bubble_outline, onPressed: () => openPage(context, const SupportChatPage())),
      const SizedBox(height: 9),
      NDButton(label: 'Lacak Pesanan', outlined: true, foreground: Palette.navy,
        icon: Icons.local_shipping_outlined,
        onPressed: () => openPage(context, const TrackingPage())),
      if (request.status != 'DIBATALKAN' && request.status != 'SELESAI') ...[
        const SizedBox(height: 9),
        NDButton(label: 'Batalkan Permintaan', outlined: true, foreground: Palette.red,
          icon: Icons.warning_amber_rounded,
          onPressed: () => openPage(context, CancelRequestPage(request: request))),
      ],
    ]),
  ));
}

class CancelRequestPage extends StatefulWidget {
  final HelpRequest request;
  const CancelRequestPage({super.key, required this.request});
  @override
  State<CancelRequestPage> createState() => _CancelRequestPageState();
}

class _CancelRequestPageState extends State<CancelRequestPage> {
  final reason = TextEditingController();
  @override
  void dispose() {reason.dispose(); super.dispose();}
  @override
  Widget build(BuildContext context) => DetailScaffold(navTab: 2, body: PagePadding(children: [
    SubHeader('Batalkan Permintaan', subtitle: 'Permintaan ${widget.request.id}'),
    NDCard(color: Palette.ice, borderColor: Colors.transparent,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(widget.request.title, style: const TextStyle(fontSize: 14,
          color: Palette.blue, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text('Status sekarang: ${widget.request.status}',
          style: const TextStyle(fontSize: 11, color: Palette.gray)),
      ])),
    const SizedBox(height: 11),
    const NDCard(color: Color(0xFFFFEFC4), child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Sudah tidak membutuhkan bantuan?', style: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w800)),
        SizedBox(height: 10),
        Text('Jika dibatalkan, permintaan hilang dari antrean aktif. Riwayatnya tetap ada untuk pencatatan.',
          style: TextStyle(fontSize: 12, height: 1.6)),
        SizedBox(height: 18),
        Text('Jika dana sudah dialokasikan, admin akan meninjau pengembalian alokasi.',
          style: TextStyle(fontSize: 11, color: Palette.gray)),
      ])),
    const SizedBox(height: 24),
    NDInput(label: 'Alasan pembatalan', hint: 'Contoh: bantuan sudah diperoleh dari keluarga',
      controller: reason, maxLines: 2),
    const SizedBox(height: 26),
    NDButton(label: 'Ya, Batalkan Permintaan', background: Palette.red,
      foreground: Colors.white, onPressed: () {
        demoStore.cancel(widget.request);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (_) => CancelledPage(request: widget.request)));
      }),
    const SizedBox(height: 9),
    NDButton(label: 'Kembali ke Permintaan', background: Palette.ice,
      foreground: Palette.blue, onPressed: () => Navigator.of(context).pop()),
  ]));
}

class CancelledPage extends StatelessWidget {
  final HelpRequest request;
  const CancelledPage({super.key, required this.request});
  @override
  Widget build(BuildContext context) => DetailScaffold(navTab: 2, body: PagePadding(children: [
    SubHeader('Permintaan Dibatalkan', subtitle: 'Permintaan ${request.id}'),
    const NDCard(color: Color(0xFFFFF0C8), child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('PEMBARUAN', style: TextStyle(fontSize: 10,
          fontWeight: FontWeight.w800, color: Palette.yellow)),
        SizedBox(height: 12),
        Text('Permintaan sudah dibatalkan', style: TextStyle(fontSize: 17,
          fontWeight: FontWeight.w800)),
        SizedBox(height: 10),
        Text('Tidak lagi terlihat dalam antrean aktif. Admin menerima pembaruan pembatalan.',
          style: TextStyle(fontSize: 12, height: 1.6)),
      ])),
    const SizedBox(height: 11),
    const NDCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Catatan riwayat', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
      SizedBox(height: 8),
      Text('Diajukan 10:00\nDibatalkan 10:18 · alasan tersimpan',
        style: TextStyle(fontSize: 12, height: 1.7)),
    ])),
    const SizedBox(height: 24),
    NDButton(label: 'Lihat Bantuan Lain', background: Palette.blue,
      foreground: Colors.white, onPressed: () => Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const RootShell(initialTab: 1)), (route) => false)),
    const SizedBox(height: 10),
    NDButton(label: 'Chat Admin', onPressed: () => openPage(context, const SupportChatPage())),
  ]));
}
