import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/ui.dart';
import 'admin_widgets.dart';
import 'report_widgets.dart';
import 'rencana_penyaluran_admin_page.dart';

class _Msg {
  final String text, time;
  final bool fromAdmin;
  const _Msg(this.text, this.fromAdmin, this.time);
}

class ChatDenganPenerimaPage extends StatefulWidget {
  final String name, roleLabel, refLabel;
  final bool showBottomNav;
  const ChatDenganPenerimaPage({
    super.key,
    this.name = 'Ayu Pratama',
    this.roleLabel = 'Penerima',
    this.refLabel = 'Permintaan ND-2026-0081',
    this.showBottomNav = true,
  });

  @override
  State<ChatDenganPenerimaPage> createState() => _ChatDenganPenerimaPageState();
}

class _ChatDenganPenerimaPageState extends State<ChatDenganPenerimaPage> {
  final _input = TextEditingController();
  final _scroll = ScrollController();
  final List<_Msg> _messages = [
    const _Msg(
        'Halo Admin, saya tidak bisa keluar. Saya ingin dibelikan bahan makanan di warteg dekat rumah.',
        false,
        '09:45'),
    const _Msg(
        'Baik, Ayu. Permintaanmu kami proses. Saya akan menyiapkan dana dan menugaskan ranger.',
        true,
        '10:02'),
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
          Padding(
            padding: const EdgeInsets.fromLTRB(19, 18, 19, 0),
            child: SubHeader(widget.name,
                subtitle: '${widget.roleLabel} • ${widget.refLabel}'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: InfoBox(
              child: Row(children: [
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                    Text('Bantuan makanan • Rp350.000',
                        style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w800,
                            color: Palette.deepBlue)),
                    SizedBox(height: 3),
                    Text('Admin sudah mengirim pesan pertama',
                        style: TextStyle(fontSize: 9, color: Palette.gray)),
                  ]),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Palette.blue,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Text('DIPROSES',
                      style: TextStyle(
                          fontSize: 8.5,
                          fontWeight: FontWeight.w800,
                          color: Colors.white)),
                ),
              ]),
            ),
          ),
          Expanded(
            child: ListView(
              controller: _scroll,
              padding: const EdgeInsets.fromLTRB(19, 14, 19, 10),
              children: [
                ..._messages.map((m) => _Bubble(m)),
                const SizedBox(height: 4),
                NDCard(
                  padding: const EdgeInsets.all(13),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Tindakan untuk permintaan ini',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Palette.navy)),
                    const SizedBox(height: 10),
                    Row(children: [
                      Expanded(
                        child: _ActionButton(
                          label: 'Alokasikan Dana',
                          bg: Palette.yellow,
                          fg: Palette.navy,
                          onPressed: () => openPage(
                              context, const RencanaPenyaluranAdminPage()),
                        ),
                      ),
                      const SizedBox(width: 9),
                      Expanded(
                        child: _ActionButton(
                          label: 'Tugaskan Ranger',
                          bg: Palette.blue,
                          fg: Colors.white,
                          onPressed: () =>
                              notice(context, 'Tugaskan ranger (mode demo).'),
                        ),
                      ),
                    ]),
                    const SizedBox(height: 8),
                    const Text(
                        'Penerima tidak melihat catatan internal admin.',
                        style: TextStyle(fontSize: 8.5, color: Palette.gray)),
                  ]),
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
                    hintText: 'Tulis pesan...',
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
      bottomNavigationBar:
          widget.showBottomNav ? const AdminBottomNav(selected: 3) : null,
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final Color bg, fg;
  final VoidCallback onPressed;
  const _ActionButton(
      {required this.label,
      required this.bg,
      required this.fg,
      required this.onPressed});

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 36,
        child: FilledButton(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: bg,
            foregroundColor: fg,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
          ),
          child: Text(label,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w800)),
        ),
      );
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
        alignment: m.fromAdmin ? Alignment.centerRight : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxW),
          child: Container(
            padding: const EdgeInsets.fromLTRB(11, 9, 11, 7),
            decoration: BoxDecoration(
              color: m.fromAdmin ? Palette.ice : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: m.fromAdmin ? const Color(0xFFD6E6FA) : Palette.line),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(m.text,
                  style: const TextStyle(
                      fontSize: 10.5, height: 1.4, color: Palette.navy)),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.centerRight,
                child: Text(m.fromAdmin ? '${m.time} ✓✓' : m.time,
                    style: const TextStyle(fontSize: 8, color: Palette.gray)),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}