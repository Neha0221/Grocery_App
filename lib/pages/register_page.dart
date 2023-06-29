import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAsyncCallProcess = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: ProgressHUD(
          child: Form(
            key: globalKey,
            child: Text("ss"),
          ),
          inAsyncCall: isAsyncCallProcess,
          opacity: .3,
          key: UniqueKey(),
        ),
      ),
    );
  }

  Widget _registerUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/images/Basket.png",
                fit: BoxFit.contain,
                width: 150,
              ),
            ),
            const SizedBox(
              height: 10,
          ),
          Text(
            "Grocery App",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize:35
        ),
    ),
    const SizedBox(
              height: 10,
          ),
          ]
          ),
          Text(
            
          )
    );
  }
}
