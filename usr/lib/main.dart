import 'package:flutter/material.dart';

void main() {
  runApp(const NutritionApp());
}

class NutritionApp extends StatelessWidget {
  const NutritionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'โภชนาการเด็กวัยเรียน (6-11 ปี)',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('โภชนาการเด็กวัย 6-11 ปี', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildEnergyCard(context),
                const SizedBox(height: 24),
                Text(
                  'หมวดหมู่อาหารที่จำเป็น (ต่อวัน)',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildFoodGroupsGrid(context),
                const SizedBox(height: 24),
                _buildTipsCard(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEnergyCard(BuildContext context) {
    return Card(
      elevation: 2,
      color: Theme.of(context).colorScheme.secondaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Icon(Icons.flash_on, size: 48, color: Colors.orange),
            const SizedBox(height: 8),
            Text(
              'พลังงานที่ต้องการ',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '1,400 - 1,500 กิโลแคลอรี / วัน',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.deepOrange, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'เด็กวัยเรียนมีการเจริญเติบโตอย่างรวดเร็วและใช้พลังงานในการเรียนรู้และทำกิจกรรมต่างๆ จึงควรได้รับสารอาหารที่ครบถ้วนทั้ง 5 หมู่',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFoodGroupsGrid(BuildContext context) {
    final foodGroups = [
      {
        'title': 'ข้าว-แป้ง',
        'amount': '8 ทัพพี',
        'desc': 'ให้พลังงานหลัก ควรเลือกข้าวกล้องหรือธัญพืชขัดสีน้อย',
        'icon': Icons.rice_bowl,
        'color': Colors.amber,
      },
      {
        'title': 'เนื้อสัตว์',
        'amount': '4 ช้อนกินข้าว',
        'desc': 'เสริมสร้างกล้ามเนื้อ ควรเน้นปลา ไข่ เนื้อสัตว์ไม่ติดมัน',
        'icon': Icons.set_meal,
        'color': Colors.redAccent,
      },
      {
        'title': 'ผักต่างๆ',
        'amount': '4 ทัพพี',
        'desc': 'ให้วิตามินและใยอาหาร ควรทานให้หลากสี',
        'icon': Icons.eco,
        'color': Colors.green,
      },
      {
        'title': 'ผลไม้',
        'amount': '3 ส่วน',
        'desc': 'ให้วิตามินซีและแร่ธาตุ ควรเป็นผลไม้ตามฤดูกาล',
        'icon': Icons.apple,
        'color': Colors.orangeAccent,
      },
      {
        'title': 'นมสด',
        'amount': '2 แก้ว',
        'desc': 'เสริมสร้างกระดูกและฟันให้แข็งแรง',
        'icon': Icons.local_drink,
        'color': Colors.lightBlue,
      },
      {
        'title': 'น้ำมัน/น้ำตาล',
        'amount': 'แต่น้อย',
        'desc': 'ใช้น้ำมันพืชปรุงอาหาร และไม่ทานหวานจัด',
        'icon': Icons.water_drop,
        'color': Colors.deepPurpleAccent,
      },
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.85,
          ),
          itemCount: foodGroups.length,
          itemBuilder: (context, index) {
            final group = foodGroups[index];
            return Card(
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(data: group),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(group['icon'] as IconData, size: 40, color: group['color'] as Color),
                      const SizedBox(height: 12),
                      Text(
                        group['title'] as String,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        group['amount'] as String,
                        style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTipsCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb, color: Colors.yellow.shade800),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ข้อแนะนำเพิ่มเติม',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 8),
                Text('• เด็กควรดื่มน้ำสะอาดอย่างน้อย 6-8 แก้วต่อวัน\n• ควรออกกำลังกายอย่างน้อยวันละ 60 นาที\n• นอนหลับพักผ่อนให้เพียงพอ 9-11 ชั่วโมง'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> data;

  const DetailScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(data['title'] as String),
        backgroundColor: (data['color'] as Color).withOpacity(0.2),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (data['color'] as Color).withOpacity(0.1),
                ),
                child: Icon(data['icon'] as IconData, size: 80, color: data['color'] as Color),
              ),
              const SizedBox(height: 32),
              Text(
                'ปริมาณที่แนะนำต่อวัน',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 8),
              Text(
                data['amount'] as String,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 24),
              Text(
                data['desc'] as String,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
