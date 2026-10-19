import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/ui.dart';
import 'admin_widgets.dart';
import 'report_widgets.dart';
import 'chat_dengan_penerima_page.dart';

class _Thread {
  final String name, role, ref, preview;
  final int unread;
  const _Thread(this.name, this.role, this.ref, this.preview, this.unread);
}

class KotakMasukAdminPage extends StatefulWidget {
  final bool showBottomNav;
  const KotakMasukAdminPage({super.key, this.showBottomNav = true});

  @override
  State<KotakMasukAdminPage> createState() => _KotakMasukAdminPageState();
}

class _KotakMasukAdminPageState extends State<KotakMasukAdminPage> {
  static const _filters = ['Semua', 'Penerima', 'Donatur', 'Ranger'];
  static const _threads = [
    _Thread('Ayu Pratama', 'Penerima', 'Permintaan ND-2026-0081',
        'Saya tidak bisa keluar rumah.', 2),
    _Thread('Budi Santoso', 'Donatur', 'Donasi Rp100.000',
        'Terima kasih, saya lihat laporan.', 1),
    _Thread('Rizki Hidayat', 'Ranger', 'Tugas ND-0422',
        'Saya sudah sampai di warteg.', 0),
    _Thread('Siti Aminah', 'Penerima', 'Permintaan ND-2026-0082',
        'Baik, saya tunggu kabarnya.', 0),
  ];

  String _filter = 'Semua';
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final list = _threads.where((t) {
      final okRole = _filter == 'Semua' || t.role == _filter;
      final q = _query.trim().toLowerCase();
      final okQuery = q.isEmpty ||
          t.name.toLowerCase().contains(q) ||
          t.ref.toLowerCase().contains(q);
      return okRole && okQuery;
    }).toList();

    return Scaffold(
      body: PagePadding(children: [
        const SubHeader('Kotak Masuk',
            subtitle: 'Admin dapat menghubungi semua role'),

        TextField(
          onChanged: (v) => setState(() => _query = v),
          style: const TextStyle(fontSize: 11, color: Palette.navy),
          decoration: const InputDecoration(
            hintText: 'Cari nama atau nomor permintaan...',
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          ),
        ),
        const SizedBox(height: 10),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _filters.map((f) {
              final sel = f == _filter;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => setState(() => _filter = f),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                    decoration: BoxDecoration(
                      color: sel ? Palette.blue : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border:
                          Border.all(color: sel ? Palette.blue : Palette.line),
                    ),
                    child: Text(f,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: sel ? Colors.white : Palette.navy)),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 12),

        if (list.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Center(
              child: Text('Tidak ada percakapan.',
                  style: TextStyle(fontSize: 11, color: Palette.gray)),
            ),
          ),
        ...list.map((t) => Padding(
              padding: const EdgeInsets.only(bottom: 9),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () => openPage(
                  context,
                  ChatDenganPenerimaPage(
                    name: t.name,
                    roleLabel: t.role,
                    refLabel: t.ref,
                  ),
                ),
                child: _ThreadCard(t),
              ),
            )),
        const SizedBox(height: 6),

        const NoteBox(
          child: Text(
            'Pengguna non-admin hanya dapat mengobrol dengan admin. Satu ruang obrolan per akun.',
            style: TextStyle(fontSize: 9, height: 1.45, color: Palette.navy),
          ),
        ),
      ]),
      bottomNavigationBar:
          widget.showBottomNav ? const AdminBottomNav(selected: 3) : null,
    );
  }
}

class _ThreadCard extends StatelessWidget {
  final _Thread t;
  const _ThreadCard(this.t);

  @override
  Widget build(BuildContext context) => NDCard(
        padding: const EdgeInsets.all(12),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CircleAvatar(
            radius: 15,
            backgroundColor: Palette.ice,
            child: Text(t.name[0],
                style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: Palette.blue)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Expanded(
                  child: Text(t.name,
                      style: const TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.w800,
                          color: Palette.navy)),
                ),
                AdminTag.warn(t.role.toUpperCase()),
              ]),
              const SizedBox(height: 2),
              Text(t.ref,
                  style: const TextStyle(fontSize: 9, color: Palette.gray)),
              const SizedBox(height: 5),
              Row(children: [
                Expanded(
                  child: Text(t.preview,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 10, color: Palette.navy)),
                ),
                if (t.unread > 0)
                  Container(
                    width: 18,
                    height: 18,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        color: Palette.blue, shape: BoxShape.circle),
                    child: Text('${t.unread}',
                        style: const TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: Colors.white)),
                  ),
              ]),
            ]),
          ),
        ]),
      );
}