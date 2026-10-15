import 'dart:async';

import 'package:flutter/material.dart';
import '../main.dart';
import '../core/app_theme.dart';
import '../core/local_auth.dart';
import '../core/demo_store.dart';
import '../core/ui.dart';

/// Kotak ND sesuai logo sementara dalam screenshot Figma.
class LogoMark extends StatelessWidget {
  final double size;
  const LogoMark({super.key, this.size = 52});

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Palette.blue,
          borderRadius: BorderRadius.circular(size * .24),
        ),
        alignment: Alignment.center,
        child: Text(
          'ND',
          style: TextStyle(
            color: Palette.yellow,
            fontSize: size * .36,
            fontWeight: FontWeight.w900,
          ),
        ),
      );
}

class _OnboardingSlide {
  final String image;
  final String tag;
  final String title;
  final String description;

  const _OnboardingSlide({
    required this.image,
    required this.tag,
    required this.title,
    required this.description,
  });
}

const _slides = <_OnboardingSlide>[
  _OnboardingSlide(
    image: 'assets/images/relief_hero.png',
    tag: '⚡ 24/7 Rapid Community Relief',
    title: "Help doesn't wait for\noffice hours.",
    description:
        'When natural disasters or sudden hunger emergencies strike, '
        'verified local kitchens deploy hot meals in under 4 hours. '
        'You’re never alone.',
  ),
  _OnboardingSlide(
    image: 'assets/images/community_care.png',
    tag: '🤝 Bersama Saling Membantu',
    title: 'Bantuan hadir saat\ndibutuhkan.',
    description:
        'Ajukan kebutuhanmu dengan mudah. Komunitas, donatur, '
        'dan relawan siap bekerja sama agar bantuan menjangkau '
        'orang yang membutuhkan.',
  ),
  _OnboardingSlide(
    image: 'assets/images/delivery_fast.png',
    tag: '🚚 Penyaluran Transparan',
    title: 'Pantau bantuan,\ntenang sampai tujuan.',
    description:
        'Pilih ambil sendiri atau diantar Ranger. Lihat status '
        'permintaan, pantau pengiriman, dan hubungi admin '
        'langsung dari aplikasi.',
  ),
];

/// Homepage: geser kiri/kanan, tap indikator, atau tunggu 5 detik.
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();
  Timer? _autoSlide;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlide?.cancel();
    _autoSlide = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!_pageController.hasClients) return;
      _goTo((_currentPage + 1) % _slides.length);
    });
  }

  void _goTo(int page) {
    if (!_pageController.hasClients) return;
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  void dispose() {
    _autoSlide?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 16, 22, 26),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LogoMark(size: 50),
                const SizedBox(height: 18),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _slides.length,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                      _startAutoSlide();
                    },
                    itemBuilder: (context, index) => _SlideContent(
                      slide: _slides[index],
                      activeIndex: _currentPage,
                      onDotTap: _goTo,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: NDButton(
                    label: 'Sign In',
                    onPressed: () => openPage(context, const LoginPage()),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

class _SlideContent extends StatelessWidget {
  final _OnboardingSlide slide;
  final int activeIndex;
  final ValueChanged<int> onDotTap;

  const _SlideContent({
    required this.slide,
    required this.activeIndex,
    required this.onDotTap,
  });

  @override
  Widget build(BuildContext context) {
    // Menjaga tampilan tetap bisa di-scroll pada HP berlayar kecil.
    final screenHeight = MediaQuery.sizeOf(context).height;
    final double imageHeight = (screenHeight * .275).clamp(152.0, 235.0).toDouble();

    return SingleChildScrollView(
      child: NDCard(
        borderColor: Colors.transparent,
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(13),
              child: Image.asset(
                slide.image,
                width: double.infinity,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 13),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF0CE),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                slide.tag,
                style: const TextStyle(
                  color: Color(0xFFDC7500),
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              slide.title,
              style: const TextStyle(
                color: Palette.navy,
                fontSize: 24,
                fontWeight: FontWeight.w900,
                height: 1.11,
              ),
            ),
            const SizedBox(height: 11),
            Text(
              slide.description,
              style: const TextStyle(
                color: Palette.navy,
                fontSize: 12,
                height: 1.56,
              ),
            ),
            const SizedBox(height: 21),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _slides.length,
                (index) => GestureDetector(
                  onTap: () => onDotTap(index),
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      width: activeIndex == index ? 22 : 7,
                      height: 6,
                      decoration: BoxDecoration(
                        color: activeIndex == index
                            ? Palette.blue
                            : const Color(0xFFD7D7D7),
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthInput extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool password;
  final TextInputType? keyboardType;
  final String? Function(String?) validator;

  const _AuthInput({
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
    this.password = false,
    this.keyboardType,
  });

  @override
  State<_AuthInput> createState() => _AuthInputState();
}

class _AuthInputState extends State<_AuthInput> {
  bool _hidden = true;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              color: Palette.navy,
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 7),
          TextFormField(
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            obscureText: widget.password && _hidden,
            autocorrect: false,
            enableSuggestions: !widget.password,
            textInputAction: widget.password ? TextInputAction.done : TextInputAction.next,
            validator: widget.validator,
            style: const TextStyle(fontSize: 12, color: Palette.navy),
            decoration: InputDecoration(
              hintText: widget.hint,
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              suffixIcon: widget.password
                  ? IconButton(
                      tooltip: _hidden ? 'Tampilkan sandi' : 'Sembunyikan sandi',
                      onPressed: () => setState(() => _hidden = !_hidden),
                      icon: Icon(
                        _hidden ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        size: 18,
                        color: Palette.gray,
                      ),
                    )
                  : null,
            ),
          ),
        ],
      );
}

String? _requiredIdentity(String? text) {
  final value = (text ?? '').trim();
  if (value.isEmpty) return 'Email atau nomor ponsel wajib diisi.';
  if (value.contains('@')) {
    if (!RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$').hasMatch(value)) {
      return 'Masukkan alamat email yang valid.';
    }
  } else if (value.replaceAll(RegExp(r'\D'), '').length < 10) {
    return 'Nomor ponsel minimal 10 digit.';
  }
  return null;
}

String? _requiredPassword(String? value) {
  if (value == null || value.isEmpty) return 'Kata sandi wajib diisi.';
  if (value.length < 6) return 'Kata sandi minimal 6 karakter.';
  return null;
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _identity = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _identity.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _openRegister() async {
    final identity = await Navigator.of(context).push<String>(
      MaterialPageRoute(builder: (_) => const RegisterPage()),
    );
    if (!mounted) return;
    if (identity != null) {
      _identity.text = identity;
      _password.clear();
      notice(context, 'Pendaftaran berhasil. Silakan masuk dengan akun baru.');
    }
  }

  void _signIn() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final account = LocalAuth.instance.login(
      identity: _identity.text,
      password: _password.text,
    );
    if (account == null) {
      notice(context, 'Akun tidak ditemukan atau kata sandi salah.');
      return;
    }

    // Sinkronisasi nama sederhana ke halaman profil demo.
    demoStore.updateProfile(
      account.fullName,
      demoStore.phone,
      account.identity.contains('@') ? account.identity : demoStore.email,
      demoStore.address,
    );

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const RootShell()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: PagePadding(children: [
          const SubHeader('Masuk', subtitle: 'Selamat datang kembali di Nasi Darurat'),
          const SizedBox(height: 6),
          const LogoMark(size: 55),
          const SizedBox(height: 24),
          const Text(
            'Bantuan hadir saat\ndibutuhkan.',
            style: TextStyle(
              fontSize: 23,
              height: 1.16,
              color: Palette.blue,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 9),
          const Text(
            'Masuk untuk melihat bantuan, berdonasi, atau mengelola penyaluran.',
            style: TextStyle(fontSize: 12, color: Palette.gray, height: 1.5),
          ),
          const SizedBox(height: 23),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _AuthInput(
                  label: 'Email atau nomor ponsel',
                  hint: 'nama@email.com',
                  controller: _identity,
                  keyboardType: TextInputType.emailAddress,
                  validator: _requiredIdentity,
                ),
                const SizedBox(height: 16),
                _AuthInput(
                  label: 'Kata sandi',
                  hint: '••••••••',
                  controller: _password,
                  password: true,
                  validator: _requiredPassword,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => notice(context, 'Lupa kata sandi akan diaktifkan saat backend terhubung.'),
              child: const Text('Lupa kata sandi?', style: TextStyle(fontSize: 11)),
            ),
          ),
          const SizedBox(height: 10),
          NDButton(label: 'Masuk', onPressed: _signIn),
          const SizedBox(height: 9),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Belum punya akun?', style: TextStyle(fontSize: 11, color: Palette.gray)),
              TextButton(
                onPressed: _openRegister,
                child: const Text(
                  'Daftar di sini',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 27),
          const NDCard(
            color: Color(0xFFFFEFC2),
            child: Text(
              'Akun admin dan ranger dibuat oleh pengelola. '
              'Pendaftaran umum tersedia untuk donatur dan penerima.',
              style: TextStyle(fontSize: 11, height: 1.45),
            ),
          ),
          const SizedBox(height: 11),
          const Text(
            'Coba akun demo: demo@nasidarurat.id / 12345678',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10, color: Palette.gray),
          ),
        ]),
      );
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullName = TextEditingController();
  final _identity = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    _fullName.dispose();
    _identity.dispose();
    _password.dispose();
    super.dispose();
  }

  void _signUp() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final error = LocalAuth.instance.register(
      fullName: _fullName.text,
      identity: _identity.text,
      password: _password.text,
    );
    if (error != null) {
      notice(context, error);
      return;
    }
    Navigator.of(context).pop(_identity.text.trim().toLowerCase());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: PagePadding(children: [
          const SubHeader('Buat Akun', subtitle: 'Pilih cara Anda berpartisipasi'),
          const SizedBox(height: 12),
          const SizedBox(
            height: 155,
            child: Center(
              child: Text(
                'LOGO',
                style: TextStyle(fontSize: 43, fontWeight: FontWeight.w300, color: Colors.black),
              ),
            ),
          ),
          NDCard(
            borderColor: Colors.transparent,
            padding: const EdgeInsets.fromLTRB(15, 18, 15, 17),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(children: [
                    Icon(Icons.badge_outlined, size: 16, color: Palette.blue),
                    SizedBox(width: 6),
                    Text('Personal Information',
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800)),
                  ]),
                  const SizedBox(height: 17),
                  _AuthInput(
                    label: 'Nama lengkap',
                    hint: 'Nama sesuai identitas',
                    controller: _fullName,
                    validator: (value) {
                      if ((value ?? '').trim().length < 3) {
                        return 'Nama lengkap minimal 3 karakter.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  _AuthInput(
                    label: 'Email atau nomor ponsel',
                    hint: 'nama@email.com',
                    controller: _identity,
                    keyboardType: TextInputType.emailAddress,
                    validator: _requiredIdentity,
                  ),
                  const SizedBox(height: 14),
                  _AuthInput(
                    label: 'Kata sandi',
                    hint: 'Minimal 6 karakter',
                    controller: _password,
                    password: true,
                    validator: _requiredPassword,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Verifikasi akun dilakukan setelah pendaftaran.',
                    style: TextStyle(fontSize: 10, color: Palette.gray),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),
          NDButton(label: 'Daftar', onPressed: _signUp),
          const SizedBox(height: 14),
          const Text(
            'Data akun ini sementara tersimpan selama aplikasi berjalan (mode demo).',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10, color: Palette.gray),
          ),
        ]),
      );
}
