// import 'package:flutter/material.dart';
// import 'main.dart'; // import main.dart (which has LoginPage)
// import 'chatbot.dart'; // <<< เพิ่ม import ChatbotScreen ที่นี่

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('หน้าหลัก'),
//         centerTitle: true,
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'ยินดีต้อนรับสู่หน้าหลัก!',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),

//             // *** แก้ไข onPressed ของปุ่มใหม่ตรงนี้ ***
//             ElevatedButton(
//               onPressed: () {
//                 // นำทางไปที่ ChatbotScreen
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const ChatbotScreen()),
//                 );
//               },
//               child: const Text('ไปหน้า Chatbot'), // เปลี่ยนข้อความปุ่มให้ชัดเจนขึ้น
//             ),
//             const SizedBox(height: 10), // เพิ่มระยะห่างระหว่างปุ่ม

//             // ปุ่มออกจากระบบ (ที่มีอยู่เดิม)
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => const LoginPage()), // สร้าง LoginPage ใหม่
//                   (Route<dynamic> route) => false, // ล้างทุก Route ใน Stack
//                 );
//               },
//               child: const Text('ออกจากระบบ'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }








// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart'; // <<< ต้องมี import นี้
// import 'main.dart'; // import main.dart (which has LoginPage)
// import 'chatbot.dart'; // import ChatbotScreen

// class HomeScreen extends StatefulWidget { // <<< ต้องเป็น StatefulWidget
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _totalMessagesSent = 0;
//   List<String> _latestChatSummaries = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadChatStatistics(); // โหลดข้อมูลครั้งแรกเมื่อหน้าจอถูกสร้าง
//   }

//   // ฟังก์ชันสำหรับโหลดข้อมูลจาก SharedPreferences
//   Future<void> _loadChatStatistics() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() { // <<< สำคัญ! ต้องใช้ setState เพื่ออัปเดต UI
//       _totalMessagesSent = prefs.getInt('messageCount') ?? 0;
//       _latestChatSummaries = prefs.getStringList('chatSummaries') ?? [];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('หน้าหลัก'),
//         centerTitle: true,
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'ยินดีต้อนรับสู่หน้าหลัก!',
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 20),

//             // แสดงจำนวนข้อความที่ส่ง
//             Text(
//               'จำนวนข้อความที่ส่งใน Chatbot: $_totalMessagesSent ข้อความ',
//               style: const TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 10),

//             // แสดงสรุปการสนทนาล่าสุด
//             const Text(
//               'สรุปการสนทนาล่าสุด:',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             if (_latestChatSummaries.isEmpty)
//               const Text(
//                 'ยังไม่มีการสนทนาล่าสุด',
//                 style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
//               )
//             else
//               ..._latestChatSummaries.map((summary) => Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 4.0),
//                     child: Text(
//                       summary,
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(fontSize: 16),
//                     ),
//                   )).toList(),
//             const SizedBox(height: 20),

//             // ปุ่มไปหน้า Chatbot
//             ElevatedButton(
//               onPressed: () async { // <<< ต้องเป็น async เพื่อรอผลลัพธ์จาก push
//                 // นำทางไปที่ ChatbotScreen
//                 await Navigator.push( // <<< ใช้ await เพื่อรอให้ ChatbotScreen ปิด
//                   context,
//                   MaterialPageRoute(builder: (context) => const ChatbotScreen()),
//                 );
//                 // เมื่อกลับมาจาก ChatbotScreen ให้โหลดข้อมูลใหม่
//                 _loadChatStatistics(); // <<< เรียกโหลดข้อมูลใหม่ตรงนี้ เพื่ออัปเดต UI
//               },
//               child: const Text('ไปหน้า Chatbot'),
//             ),
//             const SizedBox(height: 10),

//             // ปุ่มออกจากระบบ (ที่มีอยู่เดิม)
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => const LoginPage()),
//                   (Route<dynamic> route) => false,
//                 );
//               },
//               child: const Text('ออกจากระบบ'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

















// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'main.dart'; // Ensure LoginPage is accessible
// import 'chatbot.dart'; // Ensure ChatbotScreen is accessible

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _totalMessagesSent = 0;
//   List<String> _latestChatSummaries = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadChatStatistics();
//   }

//   Future<void> _loadChatStatistics() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _totalMessagesSent = prefs.getInt('messageCount') ?? 0;
//       _latestChatSummaries = prefs.getStringList('chatSummaries') ?? [];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurple, // สี AppBar ที่แตกต่าง
//         elevation: 0, // ไม่มีเงา
//       ),
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient( // เพิ่ม Gradient Background
//             colors: [Colors.deepPurple, Colors.purpleAccent],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: SingleChildScrollView( // ใช้ SingleChildScrollView เพื่อป้องกัน Overflow
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch, // ขยาย widget ให้เต็มความกว้าง
//             children: [
//               // ส่วนต้อนรับ
//               const Text(
//                 'welcome!',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   shadows: [
//                     Shadow(
//                       blurRadius: 4.0,
//                       color: Colors.black38,
//                       offset: Offset(2.0, 2.0),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 30),

//               // Card สำหรับสถิติ Chatbot
//               _buildStatisticCard(
//                 icon: Icons.message_rounded,
//                 title: 'Total messages sent',
//                 value: '$_totalMessagesSent messages',
//                 color: Colors.orange.shade300,
//                 iconColor: Colors.orange.shade800,
//               ),
//               const SizedBox(height: 20),

//               // Card สำหรับสรุปการสนทนาล่าสุด
//               _buildSummaryCard(
//                 title: 'Summary of recent conversations',
//                 summaries: _latestChatSummaries,
//                 color: Colors.green.shade300,
//               ),
//               const SizedBox(height: 30),

//               // ปุ่มหลัก
//               _buildActionButton(
//                 context,
//                 text: 'Chatbot',
//                 icon: Icons.chat_bubble_outline,
//                 color: Colors.blueAccent,
//                 onPressed: () async {
//                   await Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const ChatbotScreen()),
//                   );
//                   _loadChatStatistics(); // Reload data after returning
//                 },
//               ),
//               const SizedBox(height: 15),
//               _buildActionButton(
//                 context,
//                 text: 'logout',
//                 icon: Icons.logout,
//                 color: Colors.redAccent,
//                 onPressed: () {
//                   Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (context) => const LoginPage()),
//                     (Route<dynamic> route) => false,
//                   );
//                 },
//               ),
//               const SizedBox(height: 20), // เพิ่มระยะห่างด้านล่าง
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Widget ช่วยสร้าง Card แสดงสถิติ
//   Widget _buildStatisticCard({
//     required IconData icon,
//     required String title,
//     required String value,
//     required Color color,
//     required Color iconColor,
//   }) {
//     return Card(
//       elevation: 8,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       color: color,
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           children: [
//             Icon(icon, size: 40, color: iconColor),
//             const SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: iconColor.withOpacity(0.9),
//                     ),
//                   ),
//                   const SizedBox(height: 5),
//                   Text(
//                     value,
//                     style: const TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Widget ช่วยสร้าง Card แสดงสรุปการสนทนา
//   Widget _buildSummaryCard({
//     required String title,
//     required List<String> summaries,
//     required Color color,
//   }) {
//     return Card(
//       elevation: 8,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       color: color,
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: color.withOpacity(0.9), // สีข้อความให้กลมกลืนกับพื้นหลัง Card
//               ),
//             ),
//             const Divider(color: Colors.white70, height: 20, thickness: 1.0),
//             if (summaries.isEmpty)
//               const Text(
//                 'ยังไม่มีการสนทนาล่าสุด',
//                 style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.white70),
//                 textAlign: TextAlign.center,
//               )
//             else
//               ...summaries.map((summary) => Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 4.0),
//                     child: Text(
//                       summary,
//                       style: const TextStyle(fontSize: 16, color: Colors.white),
//                     ),
//                   )).toList(),
//           ],
//         ),
//       ),
//     );
//   }

//   // Widget ช่วยสร้างปุ่มหลักที่มีไอคอน
//   Widget _buildActionButton(
//     BuildContext context, {
//     required String text,
//     required IconData icon,
//     required Color color,
//     required VoidCallback onPressed,
//   }) {
//     return ElevatedButton.icon(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: color, // สีพื้นหลังปุ่ม
//         foregroundColor: Colors.white, // สีข้อความและไอคอน
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(30),
//         ),
//         elevation: 5,
//         minimumSize: const Size(double.infinity, 50), // ทำให้ปุ่มขยายเต็มความกว้าง
//       ),
//       icon: Icon(icon, size: 28),
//       label: Text(
//         text,
//         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }










import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import for SharedPreferences
import 'main.dart'; // Import LoginPage (assuming it's in main.dart)
import 'chatbot.dart'; // Import ChatbotScreen

/// HomeScreen is a StatefulWidget to manage and display chat statistics.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // State variables to hold chat statistics
  int _totalMessagesSent = 0;
  List<String> _latestChatSummaries = [];

  @override
  void initState() {
    super.initState();
    _loadChatStatistics(); // Load data when the screen initializes
  }

  /// Asynchronously loads chat statistics from SharedPreferences.
  ///
  /// This function retrieves the total message count and latest chat summaries
  /// and updates the UI using `setState`.
  Future<void> _loadChatStatistics() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _totalMessagesSent = prefs.getInt('messageCount') ?? 0;
      _latestChatSummaries = prefs.getStringList('chatSummaries') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'welcome!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Display the total number of messages sent
            Text(
              'Number of messages sent in Chatbot: $_totalMessagesSent ข้อความ',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),

            // Display the latest chat summaries
            const Text(
              'Summary of recent conversations:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (_latestChatSummaries.isEmpty)
              const Text(
                'There are no recent conversations.',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              )
            else
              // Use a Column for better control over spacing of multiple summaries
              Column(
                children: _latestChatSummaries.map((summary) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    summary,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                )).toList(),
              ),
            const SizedBox(height: 20),

            // Button to navigate to the Chatbot screen
            ElevatedButton(
              onPressed: () async {
                // Navigate to ChatbotScreen and await its completion
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatbotScreen()),
                );
                // When returning from ChatbotScreen, reload the statistics
                _loadChatStatistics();
              },
              child: const Text('Chatbot'),
            ),
            const SizedBox(height: 10),

            // Button to log out and return to the login page
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (Route<dynamic> route) => false, // Remove all previous routes
                );
              },
              child: const Text('logout'),
            ),
          ],
        ),
      ),
    );
  }
}