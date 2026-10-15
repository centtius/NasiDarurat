import 'package:flutter/material.dart';
import '../main.dart';
import '../core/app_theme.dart';
import '../core/demo_store.dart';
import '../core/ui.dart';

class DaftarDonaturPage extends StatefulWidget {
  const DaftarDonaturPage({super.key});

  @override
  State<DaftarDonaturPage> createState() => _DaftarDonaturPageState();
}

class _DaftarDonaturPageState extends State<DaftarDonaturPage> {
  static const _types = [
    'Individu / Perorangan',
    'Perusahaan / Instansi',
    'Komunitas / Organisasi',
  ];

  String _type = _types.first;
  bool _agree = false;
  final _reason = TextEditingController();

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  void _submit() {
    if (_reason.text.trim().isEmpty) {
      notice(context, 'Alasan menjadi donatur wajib diisi.');
      return;
    }
    if (!_agree) {
      notice(context, 'Setujui syarat & ketentuan donatur terlebih dahulu.');
      return;
    }
    if (!demoStore.isDonor) demoStore.toggleDonor();
    notice(context, 'Pengajuan terkirim. Admin akan meninjau pendaftaranmu.');
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagePadding(children: [
        const SubHeader('Daftar Donatur'),

        // Judul
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
              Text('PENGAJUAN DONATUR',
                  style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                      color: Palette.blue)),
              SizedBox(height: 5),
              Text('Mari berbagi kebaikan',
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      color: Palette.navy)),
              SizedBox(height: 4),
              Text('Lengkapi formulir untuk proses verifikasi admin.',
                  style: TextStyle(fontSize: 10.5, color: Palette.gray)),
            ]),
          ),
          const SizedBox(width: 10),
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: const Color(0xFFFCEBB2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.favorite_rounded,
                size: 26, color: Palette.yellow),
          ),
        ]),
        const SizedBox(height: 16),

        // Info akun tersimpan
        NDCard(
          color: Palette.ice,
          borderColor: const Color(0xFFD6E6FA),
          padding: const EdgeInsets.all(13),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
            Row(children: [
              Icon(Icons.check, size: 13, color: Palette.blue),
              SizedBox(width: 5),
              Text('Informasi akun sudah tersimpan',
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Palette.blue)),
            ]),
            SizedBox(height: 6),
            Text(
              'Nama, nomor telepon, email dan KTP diambil dari profil. Tidak perlu mengisi ulang.',
              style: TextStyle(fontSize: 10, height: 1.4, color: Palette.gray),
            ),
          ]),
        ),
        const SizedBox(height: 14),

        // Form
        NDCard(
          padding: const EdgeInsets.all(15),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const _StepTitle('01', 'Informasi Donatur'),
            const SizedBox(height: 14),
            const NDLabel('Jenis donatur *'),
            DropdownButtonFormField<String>(
              value: _type,
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  size: 20, color: Palette.blue),
              style: const TextStyle(fontSize: 12, color: Palette.navy),
              decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 14, vertical: 14)),
              items: _types
                  .map((t) => DropdownMenuItem(value: t, child: Text(t)))
                  .toList(),
              onChanged: (v) => setState(() => _type = v ?? _type),
            ),
            const SizedBox(height: 22),
            const _StepTitle('02', 'Motivasi & Komitmen'),
            const SizedBox(height: 14),
            const NDLabel('Alasan menjadi donatur *'),
            TextField(
              controller: _reason,
              maxLines: 5,
              style: const TextStyle(fontSize: 12, color: Palette.navy),
              decoration: const InputDecoration(
                  hintText: 'Ceritakan alasan Anda ingin membantu...'),
            ),
            const SizedBox(height: 28),
          ]),
        ),
        const SizedBox(height: 12),

        // Syarat & ketentuan
        NDCard(
          color: const Color(0xFFFFFDF4),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: InkWell(
            onTap: () => setState(() => _agree = !_agree),
            child: Row(children: [
              Checkbox(
                value: _agree,
                onChanged: (v) => setState(() => _agree = v ?? false),
                activeColor: Palette.blue,
                visualDensity: VisualDensity.compact,
                side: const BorderSide(color: Palette.line, width: 1.5),
              ),
              const Expanded(
                child: Text('Saya menyetujui syarat & ketentuan donatur.',
                    style: TextStyle(fontSize: 10.5, color: Palette.navy)),
              ),
            ]),
          ),
        ),
        const SizedBox(height: 26),

        NDButton(label: 'Daftar', onPressed: _submit),
        const SizedBox(height: 10),
        const Text('Proses pengajuan akan ditinjau oleh admin.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 9, color: Palette.gray)),
      ]),
    );
  }
}

class _StepTitle extends StatelessWidget {
  final String number, title;
  const _StepTitle(this.number, this.title);

  @override
  Widget build(BuildContext context) => Row(children: [
        Text(number,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Palette.navy)),
        const SizedBox(width: 8),
        Text(title,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: Palette.navy)),
      ]);
}