/// Autentikasi sementara untuk demonstrasi UI.
/// Tidak memakai database, tidak menyimpan akun secara permanen,
/// dan JANGAN digunakan sebagai keamanan aplikasi produksi.
class LocalAccount {
  final String fullName;
  final String identity;
  final String password;

  const LocalAccount({
    required this.fullName,
    required this.identity,
    required this.password,
  });
}

class LocalAuth {
  LocalAuth._();
  static final LocalAuth instance = LocalAuth._();

  final List<LocalAccount> _accounts = [
    const LocalAccount(
      fullName: 'Budi Santoso, S.T.',
      identity: 'demo@nasidarurat.id',
      password: '12345678',
    ),
  ];

  String? register({
    required String fullName,
    required String identity,
    required String password,
  }) {
    final normalized = identity.trim().toLowerCase();
    if (_accounts.any((account) => account.identity == normalized)) {
      return 'Email atau nomor ponsel sudah terdaftar.';
    }
    _accounts.add(LocalAccount(
      fullName: fullName.trim(),
      identity: normalized,
      password: password,
    ));
    return null;
  }

  LocalAccount? login({required String identity, required String password}) {
    final normalized = identity.trim().toLowerCase();
    for (final account in _accounts) {
      if (account.identity == normalized && account.password == password) {
        return account;
      }
    }
    return null;
  }
}
