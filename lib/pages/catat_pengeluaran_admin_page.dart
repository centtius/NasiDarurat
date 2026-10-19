import 'package:flutter/material.dart';
import '../core/app_theme.dart';
import '../core/ui.dart';
import 'admin_widgets.dart';
import 'report_widgets.dart';

class CatatPengeluaranAdminPage extends StatefulWidget {
  final bool showBottomNav;
  const CatatPengeluaranAdminPage({super.key, this.showBottomNav = true});

  @override
  State<CatatPengeluaranAdminPage> createState() =>
      _CatatPengeluaranAdminPageState();
}

class _CatatPengeluaranAdminPageState extends State<CatatPengeluaranAdminPage> {
  final _nominal = TextEditingController();
  final _keperluan = TextEditingController();
  String? _sumber;
  bool _uploaded = false;

  @override
  void dispose() {
    _nominal.dispose();
    _keperluan.dispose();
    super.dispose();
  }

  void _confirm() {
    if (_nominal.text.trim().isEmpty || _keperluan.text.trim().isEmpty) {
      notice(context, 'Nominal dan keperluan wajib diisi.');
      return;
    }
    if (!_uploaded) {
      notice(context, 'Unggah struk atau bukti pembayaran terlebih dahulu.');
      return;
    }
    notice(context, 'Pengeluaran dikonfirmasi (mode demo).');
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagePadding(children: [
        const SubHeader('Catat Pengeluaran', subtitle: 'Permintaan ND-2026-0081'),

        InfoBox(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Text('Dana tersedia bersama: Rp12.450.000',
                style: TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                    color: Palette.deepBlue)),
            SizedBox(height: 6),
            Text('Rencana biaya: Rp150.000',
                style: TextStyle(fontSize: 10, color: Palette.navy)),
            SizedBox(height: 3),
            Text('Sumber: dana bersama donatur',
                style: TextStyle(fontSize: 9, color: Palette.gray)),
          ]),
        ),
        const SizedBox(height: 16),

        NDInput(
          label: 'Nominal terpakai',
          hint: 'Rp150.000',
          controller: _nominal,
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 14),
        NDInput(
          label: 'Keperluan',
          hint: '3 nasi bungkus, lauk, dan minum',
          controller: _keperluan,
        ),
        const SizedBox(height: 14),

        const NDLabel('Sumber dana'),
        DropdownButtonFormField<String>(
          value: _sumber,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded,
              size: 20, color: Palette.blue),
          style: const TextStyle(fontSize: 13, color: Palette.navy),
          hint: const Text('Pilih transaksi yang dikehendaki'),
          items: const ['Dana bersama donatur', 'Donasi tertentu']
              .map((s) => DropdownMenuItem(value: s, child: Text(s)))
              .toList(),
          onChanged: (v) => setState(() => _sumber = v),
        ),
        const SizedBox(height: 14),

        InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            setState(() => _uploaded = !_uploaded);
            if (_uploaded) notice(context, 'Bukti terunggah (mode demo).');
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F4F8),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Palette.line),
            ),
            child: Row(children: [
              Icon(_uploaded ? Icons.check_circle : Icons.add,
                  size: 20,
                  color: _uploaded ? Palette.green : Palette.blue),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                      _uploaded
                          ? 'Bukti pembayaran terunggah'
                          : 'Unggah struk atau bukti pembayaran',
                      style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Palette.navy)),
                  const SizedBox(height: 2),
                  const Text('Wajib sebelum pengeluaran dikonfirmasi.',
                      style: TextStyle(fontSize: 9, color: Palette.gray)),
                ]),
              ),
            ]),
          ),
        ),
        const SizedBox(height: 14),

        const NoteBox(
          child: Text(
            'Saldo dan laporan donatur berubah setelah alokasi diverifikasi. Semua perubahan dicatat.',
            style: TextStyle(fontSize: 9, height: 1.45, color: Palette.navy),
          ),
        ),
        const SizedBox(height: 22),

        NDButton(
          label: 'Konfirmasi Pengeluaran',
          background: Palette.blue,
          foreground: Colors.white,
          onPressed: _confirm,
        ),
      ]),
      bottomNavigationBar:
          widget.showBottomNav ? const AdminBottomNav(selected: 2) : null,
    );
  }
}