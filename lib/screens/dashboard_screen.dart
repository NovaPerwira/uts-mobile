import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../models/campaign_model.dart';
import '../widgets/campaign_card.dart';
import '../utils/currency_format.dart';

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
  // State Dinamis Saldo
  double _saldo = 1250000;

  // 4 Jenis Donasi Familiar sesuai permintaan (akan didirect ke halaman kosong)
  final List<Map<String, dynamic>> _menuDonasi = [
    {'title': 'Zakat', 'icon': Icons.mosque, 'color': Colors.green},
    {'title': 'Sedekah', 'icon': Icons.volunteer_activism, 'color': Colors.blue},
    {'title': 'Bencana', 'icon': Icons.house_siding, 'color': Colors.orange},
    {'title': 'Medis', 'icon': Icons.medical_services, 'color': Colors.red},
  ];

  // 10 Item Dummy Campaign dipisahkan ke dalam Model
  late final List<CampaignModel> _campaigns;
  late final List<String> _categories;

  @override
  void initState() {
    super.initState();
    // Menggunakan Model (CampaignModel) sesuai best practice struktur
    _campaigns = [
      CampaignModel(title: 'Bantu Korban Banjir Bandang Demak', category: 'Bencana', progress: 0.7, target: 'Rp 50.000.000', icon: Icons.flood),
      CampaignModel(title: 'Bantuan Evakuasi Gempa Bumi', category: 'Bencana', progress: 0.4, target: 'Rp 100.000.000', icon: Icons.broken_image),
      CampaignModel(title: 'Bantu Biaya Operasi Dek Fatih', category: 'Medis', progress: 0.8, target: 'Rp 20.000.000', icon: Icons.healing),
      CampaignModel(title: 'Penyaluran Oksigen Darurat', category: 'Medis', progress: 0.9, target: 'Rp 15.000.000', icon: Icons.medical_information),
      CampaignModel(title: 'Zakat Fitrah & Maal 2026', category: 'Zakat', progress: 0.5, target: 'Rp 200.000.000', icon: Icons.mosque),
      CampaignModel(title: 'Sedekah Subuh Rutin', category: 'Sedekah', progress: 0.6, target: 'Rp 10.000.000', icon: Icons.wb_twilight),
      CampaignModel(title: 'Pembangunan Masjid Desa', category: 'Sedekah', progress: 0.3, target: 'Rp 150.000.000', icon: Icons.account_balance),
      CampaignModel(title: 'Bantuan Pangan Dhuafa', category: 'Sedekah', progress: 0.85, target: 'Rp 25.000.000', icon: Icons.fastfood),
      CampaignModel(title: 'Alat Bantu Dengar Lansia', category: 'Medis', progress: 0.2, target: 'Rp 30.000.000', icon: Icons.hearing),
      CampaignModel(title: 'Evakuasi Korban Gunung Meletus', category: 'Bencana', progress: 0.1, target: 'Rp 75.000.000', icon: Icons.volcano),
    ];

    // Mengelompokkan / mengurutkan kategori dari list campaign
    _categories = _campaigns.map((e) => e.category).toSet().toList();
    _categories.sort(); // Diurutkan berdasarkan nama kategori abjad
  }

  void _logout(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  // Menampilkan Modal Dialog Donasi
  void _showDonasiDialog(BuildContext context, CampaignModel campaign) {
    final TextEditingController nominalController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Donasi untuk\n${campaign.title}', style: const TextStyle(fontSize: 16)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Masukkan nominal donasi:'),
              const SizedBox(height: 12),
              TextField(
                controller: nominalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixText: 'Rp ',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text('Saldo Anda: Rp ${CurrencyFormat.formatToRupiah(_saldo)}', style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Batal', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                final String input = nominalController.text;
                if (input.isNotEmpty) {
                  final double nominal = double.tryParse(input) ?? 0;
                  Navigator.pop(context);
                  _prosesDonasi(nominal, campaign);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Donasi Sekarang'),
            ),
          ],
        );
      },
    );
  }

  // Fungsi memproses data saat donasi dilakukan
  void _prosesDonasi(double nominal, CampaignModel campaign) {
    if (nominal <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nominal tidak valid!'), backgroundColor: Colors.red),
      );
      return;
    }

    if (_saldo >= nominal) {
      setState(() {
        _saldo -= nominal; // Mengurangi saldo dinamis
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terima kasih! Donasi Rp ${CurrencyFormat.formatToRupiah(nominal)} berhasil.'),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Maaf, saldo Anda tidak mencukupi untuk nominal tersebut.'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final String userName = ModalRoute.of(context)?.settings.arguments as String? ?? 'Pengguna';

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
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
                    // Menggunakan utility fungsi formatRupiah
                    Text(
                      'Rp ${CurrencyFormat.formatToRupiah(_saldo)}',
                      style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _saldo += 100000;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Top Up Rp 100.000 berhasil!'),
                                backgroundColor: Colors.green,
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                          icon: const Icon(Icons.add, size: 16, color: Colors.blue),
                          label: const Text('Top Up 100rb', style: TextStyle(color: Colors.blue)),
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

            // --- 3. Campaign Berjalan ---
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Campaign Sedang Berjalan',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
            ),
            const SizedBox(height: 12),

            // Looping per Kategori
            ..._categories.map((category) {
              final categoryCampaigns = _campaigns.where((c) => c.category == category).toList();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        category,
                        style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                  ),
                  
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: categoryCampaigns.length,
                    itemBuilder: (context, index) {
                      // Menggunakan Widget Eksternal: CampaignCard
                      return CampaignCard(
                        campaign: categoryCampaigns[index],
                        onDonasiTap: () => _showDonasiDialog(context, categoryCampaigns[index]),
                      );
                    },
                  ),
                ],
              );
            }),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
