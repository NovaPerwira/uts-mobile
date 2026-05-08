import 'package:flutter/material.dart';
import 'login_screen.dart';

// --- Placeholder Screen untuk Halaman Kosong ---
class KategoriKosongScreen extends StatelessWidget {
  final String title;
  const KategoriKosongScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 1,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction, size: 80, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              'Halaman donasi $title',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Sedang dalam tahap pengembangan.',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // 4 Jenis Donasi Familiar sesuai permintaan (akan didirect ke halaman kosong)
  final List<Map<String, dynamic>> _menuDonasi = [
    {'title': 'Zakat', 'icon': Icons.mosque, 'color': Colors.green},
    {'title': 'Sedekah', 'icon': Icons.volunteer_activism, 'color': Colors.blue},
    {'title': 'Bencana', 'icon': Icons.house_siding, 'color': Colors.orange},
    {'title': 'Medis', 'icon': Icons.medical_services, 'color': Colors.red},
  ];

  // 10 Item Dummy Campaign sesuai syarat praktikum
  final List<Map<String, dynamic>> _campaigns = [
    {'title': 'Bantu Korban Banjir Bandang Demak', 'category': 'Bencana', 'progress': 0.7, 'target': 'Rp 50.000.000', 'icon': Icons.flood},
    {'title': 'Bantuan Evakuasi Gempa Bumi', 'category': 'Bencana', 'progress': 0.4, 'target': 'Rp 100.000.000', 'icon': Icons.broken_image},
    {'title': 'Bantu Biaya Operasi Dek Fatih', 'category': 'Medis', 'progress': 0.8, 'target': 'Rp 20.000.000', 'icon': Icons.healing},
    {'title': 'Penyaluran Oksigen Darurat', 'category': 'Medis', 'progress': 0.9, 'target': 'Rp 15.000.000', 'icon': Icons.medical_information},
    {'title': 'Zakat Fitrah & Maal 2026', 'category': 'Zakat', 'progress': 0.5, 'target': 'Rp 200.000.000', 'icon': Icons.mosque},
    {'title': 'Sedekah Subuh Rutin', 'category': 'Sedekah', 'progress': 0.6, 'target': 'Rp 10.000.000', 'icon': Icons.wb_twilight},
    {'title': 'Pembangunan Masjid Desa', 'category': 'Sedekah', 'progress': 0.3, 'target': 'Rp 150.000.000', 'icon': Icons.account_balance},
    {'title': 'Bantuan Pangan Dhuafa', 'category': 'Sedekah', 'progress': 0.85, 'target': 'Rp 25.000.000', 'icon': Icons.fastfood},
    {'title': 'Alat Bantu Dengar Lansia', 'category': 'Medis', 'progress': 0.2, 'target': 'Rp 30.000.000', 'icon': Icons.hearing},
    {'title': 'Evakuasi Korban Gunung Meletus', 'category': 'Bencana', 'progress': 0.1, 'target': 'Rp 75.000.000', 'icon': Icons.volcano},
  ];

  late List<String> _categories;

  @override
  void initState() {
    super.initState();
    // Mengelompokkan / mengurutkan kategori dari list campaign
    _categories = _campaigns.map((e) => e['category'] as String).toSet().toList();
    _categories.sort(); // Diurutkan berdasarkan nama kategori abjad
  }

  void _logout(BuildContext context) {
    // Memenuhi syarat: Navigator.pushAndRemoveUntil
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Menerima data user yang dikirim dari form login
    final String userName = ModalRoute.of(context)?.settings.arguments as String? ?? 'Pengguna';

    return Scaffold(
      backgroundColor: Colors.grey.shade50, // Latar modern putih/abu terang
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selamat datang,',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Text(
              userName,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
          ],
        ),
        actions: [
          // Tombol Logout di ujung kanan atas
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            tooltip: 'Logout',
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. Area Saldo ---
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade700, Colors.blue.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Saldo Dompet Kebaikan',
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Rp 1.250.000',
                      style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.account_balance_wallet, size: 16, color: Colors.blue),
                          label: const Text('Top Up', style: TextStyle(color: Colors.blue)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            minimumSize: Size.zero,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            // --- 2. 4 Menu Jenis Donasi ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: _menuDonasi.map((menu) {
                  return InkWell(
                    onTap: () {
                      // Di-direct ke halaman kosong
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KategoriKosongScreen(title: menu['title']),
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: menu['color'].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(menu['icon'], color: menu['color'], size: 28),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          menu['title'],
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 24),

            // --- 3. Campaign yang sedang berjalan & Diurutkan/Dikelompokkan Berdasarkan Kategori ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Campaign Sedang Berjalan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 12),

            // Melakukan looping ke semua kategori yang ada
            ..._categories.map((category) {
              // Mem-filter list campaign berdasarkan kategorinya
              final categoryCampaigns = _campaigns.where((c) => c['category'] == category).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Label Kategori (Grup Kategori)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.blue.shade100),
                      ),
                      child: Text(
                        category, // Menampilkan nama kategori
                        style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                  ),
                  
                  // Bentuk Widget List untuk campaign yang sesuai kategori
                  ListView.builder(
                    shrinkWrap: true, // Agar ListView.builder dapat dimuat di dalam Column/ScrollView
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: categoryCampaigns.length,
                    itemBuilder: (context, index) {
                      final item = categoryCampaigns[index];
                      // Card Styling untuk tiap widget campaign
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 0, // Desain modern flat
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(color: Colors.grey.shade200), // Border halus
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(item['icon'], color: Colors.grey.shade400, size: 36),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['title'],
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text('Target Donasi:', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                        Text(
                                          item['target'],
                                          style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(4),
                                      child: LinearProgressIndicator(
                                        value: item['progress'],
                                        minHeight: 6,
                                        backgroundColor: Colors.grey.shade200,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue.shade600),
                                      ),
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
                ],
              );
            }), // Akhir loop kategori
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
