import 'package:flutter/material.dart';
import '../main.dart';
import '../core/app_theme.dart';
import '../core/demo_store.dart';
import '../core/ui.dart';
import 'donor_nav.dart';
import 'report_widgets.dart';

class _Msg {
  final String text, time;
  final bool mine;
  const _Msg(this.text, this.mine, this.time);
}

class ChatAdminPage extends StatefulWidget {
  final bool showBottomNav;
  const ChatAdminPage({super.key, this.showBottomNav = true});

  @override
  State<ChatAdminPage> createState() => _ChatAdminPageState();
}

class _ChatAdminPageState extends State<ChatAdminPage> {
  final _input = TextEditingController();
  final _scroll = ScrollController();
  final List<_Msg> _messages = [
    const _Msg(
        'Halo Admin, pembayaran saya gagal tetapi saldo rekening sudah terpotong. Bisa dibantu cek?',
        true,
        '10:15'),
    const _Msg(
        'Terima. Kirim nomor transaksi dan bukti pembayaran di sini. Kami akan periksa sebelum donasi dicatat.',
        false,
        '10:24'),
  ];

  @override
  void dispose() {
    _input.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _send() {
    final text = _input.text.trim();
    if (text.isEmpty) return;
    final t = TimeOfDay.now();
    final time =
        '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
    setState(() => _messages.add(_Msg(text, true, time)));
    _input.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(_scroll.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(19, 18, 19, 0),
            child: SubHeader('Chat Admin',
                subtitle: 'Satu ruang chat untuk akun Anda'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: InfoBox(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                Text('Donasi DNR-2026-0042',
                    style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        color: Palette.deepBlue)),
                SizedBox(height: 3),
                Text('Rp100.000 • laporan alokasi tersedia',
                    style: TextStyle(fontSize: 9.5, color: Palette.gray)),
              ]),
            ),
          ),
          Expanded(
            child: ListView(
              controller: _scroll,
              padding: const EdgeInsets.fromLTRB(19, 14, 19, 10),
              children: [
                Center(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Palette.line)),
                    child: const Text('Hari ini',
                        style: TextStyle(fontSize: 8.5, color: Palette.gray)),
                  ),
                ),
                const SizedBox(height: 12),
                ..._messages.map((m) => _Bubble(m)),
                const SizedBox(height: 6),
                const NoteBox(
                  child: Text(
                    'Obrolan ini hanya antara donatur dan admin. Donatur tidak dapat menghubungi penerima atau ranger secara langsung.',
                    style: TextStyle(
                        fontSize: 9, height: 1.45, color: Palette.navy),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(19, 8, 19, 10),
            decoration: const BoxDecoration(
              color: Palette.cream,
              border: Border(top: BorderSide(color: Palette.line)),
            ),
            child: Row(children: [
              Expanded(
                child: TextField(
                  controller: _input,
                  onSubmitted: (_) => _send(),
                  style: const TextStyle(fontSize: 11, color: Palette.navy),
                  decoration: const InputDecoration(
                    hintText: 'Tulis pesan ke admin...',
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              FilledButton(
                onPressed: _send,
                style: FilledButton.styleFrom(
                  backgroundColor: Palette.blue,
                  minimumSize: const Size(58, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9)),
                ),
                child: const Text('Kirim',
                    style:
                        TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
              ),
            ]),
          ),
        ]),
      ),
      bottomNavigationBar: widget.showBottomNav ? const DonorBottomNav() : null,
    );
  }
}

class _Bubble extends StatelessWidget {
  final _Msg m;
  const _Bubble(this.m);

  @override
  Widget build(BuildContext context) {
    final maxW = MediaQuery.of(context).size.width * 0.72;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Align(
        alignment: m.mine ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxW),
          child: Container(
            padding: const EdgeInsets.fromLTRB(11, 9, 11, 7),
            decoration: BoxDecoration(
              color: m.mine ? Palette.ice : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: m.mine ? const Color(0xFFD6E6FA) : Palette.line),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (!m.mine) ...[
                const Text('Admin Nasi Darurat',
                    style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: Palette.blue)),
                const SizedBox(height: 4),
              ],
              Text(m.text,
                  style: const TextStyle(
                      fontSize: 10.5, height: 1.4, color: Palette.navy)),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerRight,
                child: Text(m.time,
                    style: const TextStyle(fontSize: 8, color: Palette.gray)),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}