import 'package:flutter/material.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  // Data dummy untuk Grid menu (8 item)
  final List<Map<String, dynamic>> _menuItems = [
    {'icon': Icons.volunteer_activism, 'label': 'Donasi', 'color': Colors.blue},
    {'icon': Icons.mosque, 'label': 'Zakat', 'color': Colors.green},
    {'icon': Icons.campaign, 'label': 'Galang Dana', 'color': Colors.orange},
    {'icon': Icons.autorenew, 'label': 'Donasi Otomatis', 'color': Colors.lightBlue},
    {'icon': Icons.explore, 'label': 'Kitabisa Experience', 'color': Colors.purple},
    {'icon': Icons.handshake, 'label': 'Kolaborasi CSR', 'color': Colors.teal},
    {'icon': Icons.shield, 'label': 'Asuransi SalingJaga', 'color': Colors.redAccent},
    {'icon': Icons.pets, 'label': 'Qurban', 'color': Colors.green.shade700},
  ];

  // Data dummy untuk ListView horizontal (Minimal 10 item sesuai syarat)
  final List<Map<String, dynamic>> _jumatBerkahItems = List.generate(
    10,
    (index) => {
      'title': index == 0 
          ? 'Sedekah Daging Untuk Warga Korban Bencana' 
          : index == 1 
              ? 'Ciptakan Ruang Hidup Harmonis di Aceh' 
              : 'Program Donasi & Kebaikan Ke-${index + 1}',
      'org': index == 0 ? 'Simpul Setara' : index == 1 ? 'YAY WWF INDONESIA' : 'Yayasan Amal $index',
      'available': 'Rp${(index + 1) * 33}.132.628',
      'progress': 0.1 * ((index % 9) + 1),
      'imageColor': index == 0 ? Colors.red.shade800 : index == 1 ? Colors.green.shade800 : Colors.primaries[index % Colors.primaries.length],
    },
  );

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout(BuildContext context) {
    // Fungsi logout: kembali ke halaman login dan hapus riwayat rute
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mengambil argumen data user (email) dari halaman login
    final String userName = ModalRoute.of(context)?.settings.arguments as String? ?? 'Pengguna';

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E), // Latar belakang tema gelap (Dark Theme)
      appBar: AppBar(
        backgroundColor: const Color(0xFF0088CC), // Biru khas header pencarian
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Memenuhi syarat: Menampilkan data user
            Text('Halo, $userName', style: const TextStyle(fontSize: 14, color: Colors.white)),
            const SizedBox(height: 6),
            Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF0077B3), // Kotak pencarian biru gelap
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text('Coba cari "Tolong menolong"', style: TextStyle(color: Colors.white70, fontSize: 14)),
                  ),
                  const Icon(Icons.search, color: Colors.white, size: 20),
                ],
              ),
            ),
          ],
        ),
        actions: [
          // Memenuhi syarat: Tombol Logout menggunakan Icons.logout
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            tooltip: 'Logout',
            onPressed: () => _logout(context),
          )
        ],
        toolbarHeight: 95, // Tinggi AppBar disesuaikan agar muat
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            
            // --- Section 1: Menu Grid ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Mau berbuat baik apa hari ini?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.75, // Menyesuaikan rasio ikon dan teks
                crossAxisSpacing: 8,
                mainAxisSpacing: 16,
              ),
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                final item = _menuItems[index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          item['icon'] as IconData,
                          color: item['color'] as Color,
                          size: 26,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item['label'] as String,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white70,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                );
              },
            ),
            
            const SizedBox(height: 16),
            const Divider(color: Color(0xFF2C2C2C), thickness: 8, height: 40),
            
            // --- Section 2: Pilihan Jumat Berkah ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Pilihan Jumat Berkah',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Memenuhi syarat: ListView.builder (horizontal) dengan 10 item dummy
            SizedBox(
              height: 280, // Tinggi area list
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _jumatBerkahItems.length,
                itemBuilder: (context, index) {
                  final item = _jumatBerkahItems[index];
                  
                  // Memenuhi syarat: Card dengan styling (shadow, rounded, padding)
                  return Container(
                    width: 260, // Lebar setiap card
                    margin: const EdgeInsets.only(right: 16),
                    child: Card(
                      color: const Color(0xFF2C2C2C), // Background card gelap
                      elevation: 4, // Shadow
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Rounded corner
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Simulasi Gambar (Warna solid)
                          Container(
                            height: 120,
                            width: double.infinity,
                            color: item['imageColor'] as Color,
                            child: const Center(
                              child: Icon(Icons.image_outlined, color: Colors.white30, size: 40),
                            ),
                          ),
                          // Padding di dalam Card
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      item['org'] as String,
                                      style: const TextStyle(fontSize: 11, color: Colors.white70),
                                    ),
                                    const SizedBox(width: 4),
                                    const Icon(Icons.verified, color: Colors.blue, size: 14),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 40,
                                  child: Text(
                                    item['title'] as String,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    const Text('Tersedia ', style: TextStyle(fontSize: 12, color: Colors.white70)),
                                    Text(
                                      item['available'] as String,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                LinearProgressIndicator(
                                  value: item['progress'] as double,
                                  backgroundColor: Colors.grey.shade800,
                                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            const Divider(color: Color(0xFF2C2C2C), thickness: 8, height: 40),
            
            // --- Section 3: Banner "Yang Baru" ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Yang Baru di Kitabisa',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  color: Colors.orange.shade800, // Warna simulasi banner
                  child: Stack(
                    children: [
                      Positioned(
                        top: 20,
                        left: 20,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'GALANG DANA PILIHAN',
                            style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 10),
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 60,
                        left: 20,
                        child: Text(
                          'Hadirkan Senyum\nLewat Hidangan Daging',
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      // Memenuhi syarat: Bottom Navigation Bar
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xFF1A1A1A), // Warna background bottom nav
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white54,
          selectedFontSize: 11,
          unselectedFontSize: 11,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Donasi'),
            BottomNavigationBarItem(icon: Icon(Icons.add_box), label: 'Galang Dana'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Donasi Saya'),
            BottomNavigationBarItem(icon: Icon(Icons.mail), label: 'Inbox'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun'),
          ],
        ),
      ),
    );
  }
}
