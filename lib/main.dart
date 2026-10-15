import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/app_theme.dart';
import 'pages/auth_pages.dart';
import 'pages/dashboard_page.dart';
import 'pages/help_pages.dart';
import 'pages/request_pages.dart';
import 'pages/chat_tracking_pages.dart';
import 'pages/profile_page.dart';
import 'pages/daftar_donatur.dart';
import 'pages/donasi_now.dart';
import 'pages/donor_page.dart';
import 'pages/status_bayar.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const NasiDaruratApp());
}

class NasiDaruratApp extends StatelessWidget {
  const NasiDaruratApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Nasi Darurat',
    theme: buildTheme(),
    debugShowCheckedModeBanner: false,
    home: const LandingPage()
  );
}

class RootShell extends StatefulWidget {
  final int initialTab;
  const RootShell({super.key, this.initialTab = 0});
  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  late int tab = widget.initialTab;
  @override
  Widget build(BuildContext context) => Scaffold(
    body: IndexedStack(index: tab, children: const [
      DashboardPage(), HelpListPage(), MyRequestsPage(), ChatPage(), ProfilePage(),
    ]),
    bottomNavigationBar: NDBottomNav(selected: tab, onSelected: (value) => setState(() => tab = value)),
  );
}

class NDBottomNav extends StatelessWidget {
  final int selected;
  final ValueChanged<int>? onSelected;
  const NDBottomNav({super.key, required this.selected, this.onSelected});

  @override
  Widget build(BuildContext context) {
    const icons = [Icons.home_outlined, Icons.volunteer_activism_outlined,
      Icons.format_list_bulleted, Icons.chat_bubble_outline_rounded, Icons.person_outline_rounded];
    const labels = ['Beranda', 'Bantuan', 'Permintaan', 'Chat', 'Profil'];
    return Container(
      decoration: const BoxDecoration(color: Colors.white,
        border: Border(top: BorderSide(color: Palette.line))),
      child: SafeArea(top: false, child: SizedBox(height: 62,
        child: Row(children: List.generate(5, (i) => Expanded(child: InkWell(
          onTap: () {
            if (onSelected != null) {
              onSelected!(i);
            } else {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => RootShell(initialTab: i)), (route) => false);
            }
          },
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(icons[i], size: 22, color: i == selected ? Palette.blue : Palette.gray),
            const SizedBox(height: 4),
            Text(labels[i], style: TextStyle(fontSize: 10,
              color: i == selected ? Palette.blue : Palette.gray,
              fontWeight: i == selected ? FontWeight.w700 : FontWeight.w400)),
          ]),
        )))),
      )),
    );
  }
}

class DetailScaffold extends StatelessWidget {
  final Widget body;
  final int navTab;
  final bool showNav;
  const DetailScaffold({super.key, required this.body, this.navTab = 2, this.showNav = true});
  @override
  Widget build(BuildContext context) => Scaffold(
    body: body,
    bottomNavigationBar: showNav ? NDBottomNav(selected: navTab) : null,
  );
}
