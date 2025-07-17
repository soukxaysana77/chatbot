// import 'package:flutter/material.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';

// class ChatbotScreen extends StatefulWidget {
//   const ChatbotScreen({super.key});

//   @override
//   State<ChatbotScreen> createState() => _ChatbotScreenState();
// }

// class _ChatbotScreenState extends State<ChatbotScreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final List<ChatMessage> _messages = [];
//   bool _isLoading = false; // <<< เพิ่มตัวแปรสถานะการโหลด

//   final String _apiKey = 'AIzaSyBmlX742ShmlyB1FHYRBtt_uGdrJaKO080';

//   late GenerativeModel _model;
//   late ChatSession _chat;

//   @override
//   void initState() {
//     super.initState();
//     _initializeGemini();
//   }

//   void _initializeGemini() {
//     _model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: _apiKey);
//     _chat = _model.startChat(history: []);
//   }

//   void _sendMessage() async {
//     final String text = _messageController.text.trim();
//     _messageController.clear();

//     if (text.isEmpty) return;

//     setState(() {
//       _messages.add(ChatMessage(text: text, isUser: true));
//       _isLoading = true; // <<< เริ่มต้นการโหลด
//     });

//     try {
//       final response = await _chat.sendMessage(Content.text(text));
//       final String? geminiResponse = response.text;

//       if (geminiResponse != null) {
//         setState(() {
//           _messages.add(ChatMessage(text: geminiResponse, isUser: false));
//         });
//       } else {
//         setState(() {
//           _messages.add(ChatMessage(text: 'ขออภัย, ไม่ได้รับคำตอบจาก AI.', isUser: false));
//         });
//       }
//     } catch (e) {
//       print('Error sending message to Gemini: $e');
//       setState(() {
//         _messages.add(ChatMessage(text: 'เกิดข้อผิดพลาด: ${e.toString()}', isUser: false));
//       });
//     } finally {
//       setState(() {
//         _isLoading = false; // <<< สิ้นสุดการโหลดไม่ว่าจะสำเร็จหรือล้มเหลว
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Chatbot Gemini'),
//         centerTitle: true,
//         backgroundColor: Colors.teal,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(8.0),
//               reverse: false,
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 return _MessageBubble(message: _messages[index]);
//               },
//             ),
//           ),
//           // <<< แสดง Loading Indicator ตรงนี้
//           if (_isLoading)
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: CircularProgressIndicator(
//                 color: Colors.teal,
//               ),
//             ),
//           const Divider(height: 1.0),
//           _buildMessageComposer(),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageComposer() {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 8.0),
//       padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               controller: _messageController,
//               decoration: InputDecoration(
//                 hintText: 'พิมพ์ข้อความของคุณ...',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25.0),
//                   borderSide: BorderSide.none,
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[200],
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//               ),
//               onSubmitted: (_) => _sendMessage(),
//             ),
//           ),
//           const SizedBox(width: 8.0),
//           FloatingActionButton(
//             onPressed: _sendMessage,
//             backgroundColor: Colors.teal,
//             elevation: 0,
//             child: const Icon(Icons.send, color: Colors.white),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     super.dispose();
//   }
// }

// class ChatMessage {
//   final String text;
//   final bool isUser;

//   ChatMessage({required this.text, required this.isUser});
// }

// class _MessageBubble extends StatelessWidget {
//   final ChatMessage message;

//   const _MessageBubble({required this.message});

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
//         padding: const EdgeInsets.all(12.0),
//         constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
//         decoration: BoxDecoration(
//           color: message.isUser ? Colors.blue[100] : Colors.grey[200],
//           borderRadius: BorderRadius.circular(12.0).copyWith(
//             bottomLeft: message.isUser ? const Radius.circular(12.0) : const Radius.circular(0),
//             bottomRight: message.isUser ? const Radius.circular(0) : const Radius.circular(12.0),
//           ),
//         ),
//         child: Text(
//           message.text,
//           style: TextStyle(
//             color: message.isUser ? Colors.blue[900] : Colors.black87,
//           ),
//         ),
//       ),
//     );
//   }
// }



















import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];

  // **สำคัญ:** API Key ของคุณ ควรจัดการด้วยความระมัดระวังเมื่อนำไปใช้จริง
  // ไม่ควร Hardcode แบบนี้ใน Production App
  final String _apiKey = 'AIzaSyBmlX742ShmlyB1FHYRBtt_uGdrJaKO080';

  late GenerativeModel _model;
  late ChatSession _chat;

  int _messageCount = 0; // ตัวแปรสำหรับนับจำนวนข้อความที่ส่ง
  List<String> _chatSummaries = []; // List สำหรับเก็บสรุปการสนทนาล่าสุด

  @override
  void initState() {
    super.initState();
    _initializeGemini();
    _loadChatData(); // โหลดข้อมูลการแชทเมื่อเริ่มต้น ChatbotScreen
  }

  // ฟังก์ชันสำหรับเริ่มต้นการเชื่อมต่อกับ Gemini AI
  void _initializeGemini() {
    // สามารถเลือกโมเดลที่ต้องการได้ เช่น 'gemini-1.5-flash', 'gemini-1.0-pro'
    // 'gemini-2.5-flash' เป็นโมเดลที่รวดเร็ว เหมาะสำหรับการแชท
    _model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: _apiKey);
    _chat = _model.startChat(history: []);
  }

  // ฟังก์ชันสำหรับโหลดข้อมูลจำนวนข้อความและสรุปการแชทจาก SharedPreferences
  Future<void> _loadChatData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _messageCount = prefs.getInt('messageCount') ?? 0;
      _chatSummaries = prefs.getStringList('chatSummaries') ?? [];
    });
  }

  // ฟังก์ชันสำหรับบันทึกข้อมูลจำนวนข้อความและสรุปการแชทลงใน SharedPreferences
  Future<void> _saveChatData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('messageCount', _messageCount);
    await prefs.setStringList('chatSummaries', _chatSummaries);
  }

  // ฟังก์ชันสำหรับส่งข้อความไปยัง Chatbot (Gemini AI)
  void _sendMessage() async {
    final String text = _messageController.text.trim();
    _messageController.clear(); // ล้างช่องข้อความหลังจากส่ง

    if (text.isEmpty) return; // ไม่ทำอะไรถ้าข้อความเป็นค่าว่าง

    setState(() {
      _messages.add(ChatMessage(text: text, isUser: true)); // เพิ่มข้อความผู้ใช้ลงใน List
      _messageCount++; // เพิ่มจำนวนข้อความที่ส่ง
    });

    try {
      final response = await _chat.sendMessage(Content.text(text));
      final String? geminiResponse = response.text;

      if (geminiResponse != null) {
        setState(() {
          _messages.add(ChatMessage(text: geminiResponse, isUser: false)); // เพิ่มข้อความ AI ลงใน List
          _addChatSummary(text, geminiResponse); // เพิ่มสรุปการสนทนา
        });
      } else {
        setState(() {
          _messages.add(ChatMessage(text: 'ขออภัย, ไม่ได้รับคำตอบจาก AI.', isUser: false));
        });
      }
    } catch (e) {
      // แสดงข้อผิดพลาดใน Console (สำหรับการ Debug)
      print('Error sending message to Gemini: $e');
      setState(() {
        _messages.add(ChatMessage(text: 'เกิดข้อผิดพลาด: ${e.toString()}', isUser: false));
      });
    } finally {
      // บันทึกข้อมูลลง SharedPreferences เสมอ ไม่ว่าจะส่งข้อความสำเร็จหรือไม่
      _saveChatData();
    }
  }

  // ฟังก์ชันสำหรับเพิ่มสรุปการสนทนาลงใน List และจำกัดจำนวน
  void _addChatSummary(String userMessage, String aiResponse) {
    // สร้างสรุปสั้นๆ จากข้อความผู้ใช้และข้อความตอบกลับของ AI
    String summary = 'คุณ: "${userMessage.length > 30 ? userMessage.substring(0, 30) + '...' : userMessage}" - AI: "${aiResponse.length > 30 ? aiResponse.substring(0, 30) + '...' : aiResponse}"';

    // เพิ่มสรุปใหม่ไว้ที่ด้านหน้าของ List (เพื่อให้สรุปล่าสุดอยู่บนสุด)
    _chatSummaries.insert(0, summary);

    // จำกัดจำนวนสรุปให้ไม่เกิน 2 รายการ เพื่อไม่ให้ List ใหญ่เกินไป
    if (_chatSummaries.length > 2) {
      _chatSummaries = _chatSummaries.sublist(0, 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot Gemini'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 36, 138, 255),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              reverse: false, // สามารถตั้งเป็น true หากต้องการให้ข้อความใหม่ล่าสุดอยู่ด้านล่าง
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _MessageBubble(message: _messages[index]);
              },
            ),
          ),
          const Divider(height: 1.0), // เส้นคั่นระหว่าง List ข้อความกับช่องพิมพ์
          _buildMessageComposer(), // Widget สำหรับช่องพิมพ์ข้อความและปุ่มส่ง
        ],
      ),
    );
  }

  // Widget สำหรับช่องพิมพ์ข้อความและปุ่มส่ง
  Widget _buildMessageComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.only(bottom: 16.0, top: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type your message......',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              ),
              onSubmitted: (_) => _sendMessage(), // ส่งข้อความเมื่อกด Enter
            ),
          ),
          const SizedBox(width: 8.0),
          FloatingActionButton(
            onPressed: _sendMessage, // ส่งข้อความเมื่อกดปุ่ม
            backgroundColor: Colors.teal,
            elevation: 0,
            child: const Icon(Icons.send, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose(); // ปิด Controller เมื่อ Widget ถูกทำลาย
    super.dispose();
  }
}

// Class สำหรับเก็บข้อมูลของข้อความแชทแต่ละข้อความ
class ChatMessage {
  final String text; // ข้อความ
  final bool isUser; // เป็นข้อความของผู้ใช้หรือไม่ (true = ผู้ใช้, false = AI)

  ChatMessage({required this.text, required this.isUser});
}

// Widget สำหรับแสดงข้อความแชทแต่ละข้อความ (Message Bubble)
class _MessageBubble extends StatelessWidget {
  final ChatMessage message;

  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    // จัดตำแหน่ง Bubble ให้เหมาะสมกับว่าเป็นข้อความผู้ใช้หรือ AI
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
        padding: const EdgeInsets.all(12.0),
        // จำกัดความกว้างของ Bubble
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          // กำหนดสีตามว่าเป็นข้อความผู้ใช้หรือ AI
          color: message.isUser ? Colors.blue[100] : Colors.grey[200],
          // กำหนด Border Radius ให้เหมาะสมกับด้านของ Bubble
          borderRadius: BorderRadius.circular(12.0).copyWith(
            bottomLeft: message.isUser ? const Radius.circular(12.0) : const Radius.circular(0),
            bottomRight: message.isUser ? const Radius.circular(0) : const Radius.circular(12.0),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isUser ? Colors.blue[900] : Colors.black87,
          ),
        ),
      ),
    );
  }
}