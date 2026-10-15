import 'package:flutter/foundation.dart';

class HelpRequest {
  final String id;
  final String title;
  final String type;
  final String description;
  final String location;
  final int nominal;
  final String method;
  String status;

  HelpRequest({
    required this.id,
    required this.title,
    required this.type,
    required this.description,
    required this.location,
    required this.nominal,
    required this.method,
    required this.status,
  });
}

class ChatMessage {
  final String content;
  final bool mine;
  final String time;
  ChatMessage(this.content, this.mine, this.time);
}

class DemoStore extends ChangeNotifier {
  String fullName = 'Budi Santoso, S.T.';
  String phone = '+62 812-3456-7890';
  String email = 'budi.santoso@relawan-merapi.id';
  String address = 'Jl. Kaliurang KM 14,5, Umbulharjo, Cangkringan, Sleman, D.I. Yogyakarta';
  bool isDonor = false;

  final List<HelpRequest> requests = [
    HelpRequest(
      id: 'NBD-2026-0891',
      title: 'Bantuan Nasi Bungkus 5 Porsi',
      type: 'Bahan Pokok',
      description: 'Beras 5 kg, minyak goreng 2 L, gula 1 kg, telur 1 tray',
      location: 'Kec. Lowokwaru, Kota Malang',
      nominal: 350000,
      method: 'Dibelikan & Diantar Ranger',
      status: 'DIPROSES',
    ),
    HelpRequest(
      id: 'NBD-2026-0815',
      title: 'Bantuan Lansia Pak RT 04',
      type: 'Makanan Siap Saji',
      description: 'Paket makanan bergizi untuk lansia',
      location: 'Kec. Klojen, Malang',
      nominal: 150000,
      method: 'Ambil Sendiri',
      status: 'SELESAI',
    ),
  ];

  final List<ChatMessage> chat = [
    ChatMessage('Halo Admin, saya membutuhkan bahan makanan untuk keluarga. Saya tidak bisa keluar rumah hari ini.', true, '09:45'),
    ChatMessage('Halo Ayu, kami sudah membaca permintaanmu. Mari kami bantu menyiapkan bahan makanan dan mengatur pengantarannya.', false, '10:02'),
  ];

  HelpRequest get currentRequest => requests.first;

  void addRequest({required String type, required String description, required int nominal,
    required String reason, required String location, required String method}) {
    final id = 'NBD-2026-${9000 + requests.length}';
    requests.insert(0, HelpRequest(
      id: id,
      title: 'Permintaan bantuan $type',
      type: type,
      description: description.isEmpty ? reason : description,
      location: location,
      nominal: nominal,
      method: method,
      status: 'DALAM ANTREAN',
    ));
    notifyListeners();
  }

  void cancel(HelpRequest request) {
    request.status = 'DIBATALKAN';
    notifyListeners();
  }

  void sendMessage(String value) {
    if (value.trim().isEmpty) return;
    chat.add(ChatMessage(value.trim(), true, 'Sekarang'));
    notifyListeners();
  }

  void updateProfile(String name, String tel, String mail, String addr) {
    fullName = name;
    phone = tel;
    email = mail;
    address = addr;
    notifyListeners();
  }

  void toggleDonor() {
    isDonor = !isDonor;
    notifyListeners();
  }
}

final demoStore = DemoStore();

String rupiah(int value) {
  final digits = value.toString();
  final out = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) out.write('.');
    out.write(digits[i]);
  }
  return 'Rp ${out.toString()}';
}
