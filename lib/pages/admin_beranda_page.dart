import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/ui.dart';
import 'admin_widgets.dart';
import 'tinjau_permintaan_admin_page.dart';
import 'detail_bantuan_publik_page.dart';

class AdminBerandaPage extends StatelessWidget {
  final bool showBottomNav;
  const AdminBerandaPage({super.key, this.showBottomNav = true});

  @override
  Widget build(BuildContext context) {
    void tinjau() => openPage(context, const TinjauPermintaanAdminPage());

    return Scaffold(
      body: PagePadding(children: [
        // Header
        Row(children: [
          const Text('Nasi Darurat',
              style: TextStyle(
                  color: Palette.blue,
                  fontSize: 22,
                  fontWeight: FontWeight.w800)),
          const SizedBox(width: 8),
          const AdminTag.info('ADMIN'),
          const Spacer(),
          Stack(clipBehavior: Clip.none, children: [
            IconButton(
              onPressed: () =>
                  notice(context, 'Belum ada notifikasi baru (mode demo).'),
              icon: const Icon(Icons.notifications_none_rounded, size: 21),
              style: IconButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Palette.line)),
            ),
            Positioned(
              right: 9,
              top: 9,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                    color: Palette.red, shape: BoxShape.circle),
              ),
            ),
          ]),
        ]),
        const SizedBox(height: 6),

        Row(children: [
          const Text('Antrean Permintaan (3)',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: Palette.navy)),
          const Spacer(),
          InkWell(
            onTap: () => openPage(context, const DetailBantuanPublikPage()),
            child: const Text('Lihat Semua',
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Palette.blue)),
          ),
        ]),
        const SizedBox(height: 10),

        _QueueCard(
          title: 'Keluarga Pak Jono (6 Jiwa)',
          address: 'Kampung Malayu, RT 02/05',
          tag: const AdminTag.danger('MENDESAK'),
          onTinjau: tinjau,
        ),
        const SizedBox(height: 10),
        _QueueCard(
          title: 'Ibu Aminah (Lansia)',
          address: 'Jatinegara Baru, No. 12',
          tag: const AdminTag.info('NORMAL'),
          onTinjau: tinjau,
        ),

        const SectionHeading('Chat Perlu Ditanggapi'),
        NDCard(
          child: Column(children: [
            _ChatRow('S', 'Slamet (Ranger)', 'Saya sudah sampai di posko utama...', 2,
                () => notice(context, 'Chat Slamet (mode demo).')),
            const ThinDivider(),
            _ChatRow('E', 'Ibu Endang', 'Apakah bantuan nasinya sudah dikirim?', 1,
                () => notice(context, 'Chat Ibu Endang (mode demo).')),
          ]),
        ),
        const SizedBox(height: 14),

        Row(children: const [
          Expanded(
              child: _StatCard('Dana Tersedia', 'Rp 12.450.000', Palette.blue)),
          SizedBox(width: 10),
          Expanded(
              child: _StatCard('Dana Tersalurkan', 'Rp 3.200.000', Palette.navy)),
        ]),
      ]),
      bottomNavigationBar:
          showBottomNav ? const AdminBottomNav(selected: 0) : null,
    );
  }
}

class _QueueCard extends StatelessWidget {
  final String title, address;
  final Widget tag;
  final VoidCallback onTinjau;
  const _QueueCard(
      {required this.title,
      required this.address,
      required this.tag,
      required this.onTinjau});

  @override
  Widget build(BuildContext context) => NDCard(
        padding: const EdgeInsets.all(13),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(
              child: Text(title,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Palette.navy)),
            ),
            tag,
          ]),
          const SizedBox(height: 4),
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Expanded(
              child: Text(address,
                  style: const TextStyle(fontSize: 10, color: Palette.gray)),
            ),
            FilledButton(
              onPressed: onTinjau,
              style: FilledButton.styleFrom(
                backgroundColor: Palette.blue,
                minimumSize: const Size(60, 28),
                padding: const EdgeInsets.symmetric(horizontal: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Tinjau',
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800)),
            ),
          ]),
        ]),
      );
}

class _ChatRow extends StatelessWidget {
  final String initial, name, preview;
  final int count;
  final VoidCallback onTap;
  const _ChatRow(this.initial, this.name, this.preview, this.count, this.onTap);

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: Row(children: [
          Stack(clipBehavior: Clip.none, children: [
            CircleAvatar(
              radius: 14,
              backgroundColor: Palette.ice,
              child: Text(initial,
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Palette.blue)),
            ),
            Positioned(
              right: -1,
              top: -1,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: Palette.blue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.2),
                ),
              ),
            ),
          ]),
          const SizedBox(width: 10),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name,
                  style: const TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: Palette.navy)),
              const SizedBox(height: 2),
              Text(preview,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 9.5, color: Palette.gray)),
            ]),
          ),
          Container(
            width: 18,
            height: 18,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: Palette.blue, shape: BoxShape.circle),
            child: Text('$count',
                style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    color: Colors.white)),
          ),
        ]),
      );
}

class _StatCard extends StatelessWidget {
  final String label, value;
  final Color color;
  const _StatCard(this.label, this.value, this.color);

  @override
  Widget build(BuildContext context) => NDCard(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: const TextStyle(fontSize: 9.5, color: Palette.gray)),
          const SizedBox(height: 6),
          Text(value,
              style: TextStyle(
                  fontSize: 13, fontWeight: FontWeight.w800, color: color)),
        ]),
      );
}