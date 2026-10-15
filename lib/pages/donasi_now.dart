import 'package:flutter/material.dart';
import '../main.dart';
import '../core/app_theme.dart';
import '../core/demo_store.dart';
import '../core/ui.dart';
import 'status_bayar.dart';

const _bannerYellow = Color(0xFFF8E9A9);

class DonasiSekarangPage extends StatefulWidget {
  const DonasiSekarangPage({super.key});

  @override
  State<DonasiSekarangPage> createState() => _DonasiSekarangPageState();
}

class _DonasiSekarangPageState extends State<DonasiSekarangPage> {
  static const _nominals = [50000, 100000, 250000, 500000];
  static const _methods = [
    (Icons.qr_code_2_rounded, 'QRIS', 'Scan untuk bayar'),
    (Icons.credit_card_rounded, 'Transfer Bank', 'BCA, Mandiri, BNI, BRI'),
    (Icons.account_balance_wallet_outlined, 'Dompet Digital',
        'GoPay, OVO, DANA, ShopeePay'),
  ];

  int _amount = 100000;
  int _method = 0;
  final _controller = TextEditingController(text: '100.000');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _plain(int v) => rupiah(v).replaceFirst('Rp ', '');

  void _setAmount(int v) => setState(() {
        _amount = v;
        _controller.text = _plain(v);
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PagePadding(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Expanded(child: SubHeader('Donasi Sekarang')),
          IconButton(
            onPressed: () => notice(context, 'Belum ada notifikasi baru (mode demo).'),
            icon: const Icon(Icons.notifications_none_rounded, size: 21),
            style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Palette.line)),
          ),
        ]),

        // Banner info
        NDCard(
          color: _bannerYellow,
          borderColor: const Color(0xFFE7D37C),
          padding: const EdgeInsets.all(11),
          child: const Text(
            'Donasi Anda masuk ke dana bersama yang dikelola admin untuk disalurkan ke penerima yang membutuhkan.',
            style: TextStyle(
                fontSize: 10.5,
                height: 1.4,
                fontWeight: FontWeight.w600,
                color: Palette.blue),
          ),
        ),
        const SizedBox(height: 18),

        // Nominal
        const NDLabel('Nominal Donasi'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _nominals.map((n) {
            final sel = n == _amount;
            return GestureDetector(
              onTap: () => _setAmount(n),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                decoration: BoxDecoration(
                  color: sel ? Palette.blue : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: sel ? Palette.blue : Palette.line),
                ),
                child: Text(rupiah(n),
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: sel ? Colors.white : Palette.navy)),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          onChanged: (v) {
            final d = v.replaceAll(RegExp(r'[^0-9]'), '');
            setState(() => _amount = d.isEmpty ? 0 : int.parse(d));
          },
          style: const TextStyle(
              fontSize: 15, fontWeight: FontWeight.w800, color: Palette.navy),
          decoration: InputDecoration(
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 14, right: 10),
              child: Center(
                widthFactor: 1,
                child: Text('Rp',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Palette.navy)),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: Palette.blue, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(11),
              borderSide: const BorderSide(color: Palette.blue, width: 1.5),
            ),
          ),
        ),
        const SizedBox(height: 18),

        // Metode
        const NDLabel('Metode Pembayaran'),
        ...List.generate(_methods.length, (i) {
          final sel = i == _method;
          final m = _methods[i];
          return Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: GestureDetector(
              onTap: () => setState(() => _method = i),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(11),
                  border: Border.all(
                      color: sel ? Palette.blue : Palette.line,
                      width: sel ? 1.5 : 1),
                ),
                child: Row(children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                        color: Palette.ice,
                        borderRadius: BorderRadius.circular(7)),
                    child: Icon(m.$1, size: 16, color: Palette.blue),
                  ),
                  const SizedBox(width: 11),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(m.$2,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: Palette.navy)),
                          Text(m.$3,
                              style: const TextStyle(
                                  fontSize: 10, color: Palette.gray)),
                        ]),
                  ),
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: sel ? Palette.blue : Colors.transparent,
                      border: Border.all(
                          color: sel ? Palette.blue : Palette.yellow, width: 1.5),
                    ),
                    child: sel
                        ? Center(
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                  color: Colors.white, shape: BoxShape.circle),
                            ),
                          )
                        : null,
                  ),
                ]),
              ),
            ),
          );
        }),
        const SizedBox(height: 3),

        // Ringkasan
        NDCard(
          child: Column(children: [
            InfoRow('Nominal Donasi', rupiah(_amount)),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(children: const [
                Expanded(
                    child: Text('Biaya Layanan',
                        style: TextStyle(color: Palette.gray, fontSize: 11))),
                Text('Rp 0 (Gratis)',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                        color: Color(0xFF22C55E))),
              ]),
            ),
            const ThinDivider(),
            InfoRow('Total Bayar', rupiah(_amount), emphasize: true),
          ]),
        ),
      ]),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(19, 6, 19, 10),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            NDButton(
              label: 'Bayar ${rupiah(_amount)}',
              onPressed: _amount <= 0
                  ? null
                  : () => openPage(context, const StatusPembayaranPage()),
            ),
            const SizedBox(height: 10),
            const Text(
              'Donasi tidak dapat dikembalikan setelah pembayaran berhasil.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 9, color: Palette.gray),
            ),
          ]),
        ),
      ),
    );
  }
}