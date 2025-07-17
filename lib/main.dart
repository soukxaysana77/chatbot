import 'package:flutter/material.dart';

import 'home_screen.dart';

import 'register_screen.dart';

import 'user_data.dart'; // <<< เพิ่มบรรทัดนี้



void main() {

runApp(const MyApp());

}



class MyApp extends StatelessWidget {
const MyApp({super.key});



@override

Widget build(BuildContext context) {

 return MaterialApp(

 title: 'Beautiful Login',

theme: ThemeData(

 primarySwatch: Colors.blue,

 visualDensity: VisualDensity.adaptivePlatformDensity,

),

home: const LoginPage(),

);

 }

}



class LoginPage extends StatefulWidget {

 const LoginPage({super.key});



@override

State<LoginPage> createState() => _LoginPageState();

}



class _LoginPageState extends State<LoginPage> {

final TextEditingController _usernameController = TextEditingController();

final TextEditingController _passwordController = TextEditingController();



// ไม่ต้องใช้ _correctUsername และ _correctPassword ตรงนี้แล้ว

// เพราะจะไปดึงมาจาก UserDatabase แทน

// final String _correctUsername = 'admin';

// final String _correctPassword = '123456';



@override

Widget build(BuildContext context) {

return Scaffold(

backgroundColor: Colors.white,

appBar: AppBar(

title: const Text('___'),

centerTitle: true,

elevation: 0,

backgroundColor: Colors.transparent,

flexibleSpace: Container(

decoration: const BoxDecoration(

gradient: LinearGradient(

colors: [Colors.blueAccent, Colors.lightBlue],

begin: Alignment.topLeft,

 end: Alignment.bottomRight,

 ),

),

),

),

body: Center(

 child: SingleChildScrollView(

padding: const EdgeInsets.all(32.0),

 child: Column(

 mainAxisAlignment: MainAxisAlignment.center,

 children: <Widget>[

 const Icon(

 Icons.lock_open,

 size: 100,

color: Colors.blueAccent,

 ),

 const SizedBox(height: 30),



 TextFormField(

 controller: _usernameController,

 keyboardType: TextInputType.text,

 decoration: InputDecoration(

labelText: 'user',

 hintText: 'ป้อนชื่อผู้ใช้ของคุณ',

 prefixIcon: const Icon(Icons.person),

 border: OutlineInputBorder(

 borderRadius: BorderRadius.circular(10.0),

 ),

 filled: true,

 fillColor: Colors.grey[100],

 ),
 ),

 const SizedBox(height: 20),



TextFormField(

controller: _passwordController,

obscureText: true,

decoration: InputDecoration(

labelText: 'pw',

 hintText: 'ป้อนรหัสผ่านของคุณ',

 prefixIcon: const Icon(Icons.lock),

 border: OutlineInputBorder(

 borderRadius: BorderRadius.circular(10.0),

 ),

 filled: true,

 fillColor: Colors.grey[100],
 ),

),

 const SizedBox(height: 30),



 Container(

 width: double.infinity,

 height: 50,

 decoration: BoxDecoration(

 gradient: const LinearGradient(

 colors: [Colors.blueAccent, Colors.lightBlue],
 begin: Alignment.topLeft,

 end: Alignment.bottomRight,

),
borderRadius: BorderRadius.circular(10.0),

 ),

 child: ElevatedButton(

onPressed: () {

 String enteredUsername = _usernameController.text;

 String enteredPassword = _passwordController.text;



 // ตรวจสอบ User และ Password จาก UserDatabase

if (UserDatabase.verifyPassword(enteredUsername, enteredPassword)) {

 ScaffoldMessenger.of(context).showSnackBar(

const SnackBar(content: Text('เข้าสู่ระบบสำเร็จ!')),

 );

 Navigator.pushReplacement(

 context,

 MaterialPageRoute(builder: (context) => const HomeScreen()),

 );

 } else {

 ScaffoldMessenger.of(context).showSnackBar(

 const SnackBar(content: Text('ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง!')),

 );

 }

 },

 style: ElevatedButton.styleFrom(

 backgroundColor: Colors.transparent,

 shadowColor: Colors.transparent,

 shape: RoundedRectangleBorder(

 borderRadius: BorderRadius.circular(10.0),

),

 ),

 child: const Text(

 'login',

 style: TextStyle(

 fontSize: 18,

 fontWeight: FontWeight.bold,

 color: Colors.white,

 ),

 ),

 ),

),

 const SizedBox(height: 20),



//  TextButton(

//  onPressed: () {

//  print('ลืมรหัสผ่าน?');

// },

// child: const Text(

//  'ลืมรหัสผ่าน?',

// style: TextStyle(color: Colors.blueAccent),

//  ),

//  ),

TextButton(

onPressed: () {

Navigator.push(

 context,

 MaterialPageRoute(builder: (context) => const RegisterScreen()),

 );

 },

 child: const Text(

'register',

style: TextStyle(color: Colors.blueAccent),

),

),

],

),

),

 ),

 );

}



@override

 void dispose() {

_usernameController.dispose();

_passwordController.dispose();

 super.dispose();

 }

} 