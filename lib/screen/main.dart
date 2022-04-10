import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kreazy_chat/google_signin.dart';
import 'package:kreazy_chat/screen/list_chat_screen.dart';
import 'package:kreazy_chat/value/colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Message App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.white,
        child: Column(children: [
          Container(
            width: double.infinity,
            child: Image.asset("asset/images/background.png"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 24, right: 24),
            child: TextField(
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                  hintText: "Username",
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  hintStyle: TextStyle(fontSize: 20),
                  filled: true,
                  fillColor: AppColors.primaryColor,
                  enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(40)))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 24, right: 24),
            child: TextField(
              style: TextStyle(fontSize: 24),
              decoration: InputDecoration(
                  suffixIcon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                  hintText: "Password",
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.grey,
                  ),
                  focusedBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                  hintStyle: TextStyle(fontSize: 20),
                  filled: true,
                  fillColor: AppColors.primaryColor,
                  enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(40)))),
            ),
          ),
          Container(
            width: 250,
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: OutlineButton(
                onPressed: () {},
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 36, color: AppColors.mainColor),
                ),
                focusColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                borderSide: BorderSide(color: AppColors.primaryColor),
                color: AppColors.primaryColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    height: 2,
                    width: 60,
                    color: Colors.grey,
                  ),
                ),
                const Text(
                  "OR",
                  style: TextStyle(fontSize: 20, color: Colors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Container(
                    height: 2,
                    width: 60,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 30,
                width: 30,
                child: GestureDetector(
                  onTap: () {},
                  child: Image.asset("asset/images/ff.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                ),
                child: Container(
                  height: 30,
                  width: 30,
                  child: GestureDetector(
                    onTap: () async {
                      FirebaseService service = new FirebaseService();
                      await service.signInwithGoogle();
                      User? user = FirebaseAuth.instance.currentUser;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListChatScreen(
                                    url: user!.photoURL!.toString(),
                                    username: user.email.toString(),
                                  )));
                    },
                    child: Image.asset("asset/images/gg.jpg"),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Dont have account ?",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Sign in",
                      style:
                          TextStyle(fontSize: 18, color: AppColors.mainColor),
                    ))
              ],
            ),
          )
        ]),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
