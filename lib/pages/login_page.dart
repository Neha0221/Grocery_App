import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/api/api_service.dart';
import 'package:groceryapp/config.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isAsynCallProgress = false;
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool hidePassword = true;
  bool isRemeber = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.grey,
          body: ProgressHUD(
            child: Form(
              key: globalKey,
              child: _loginUI(context),
            ),
            inAsyncCall: isAsynCallProgress,
            opacity: .3,
            key: UniqueKey(),
          )),
    );
  }

  Widget _loginUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "./lib/pages/assets/images/Basket.png",
                  fit: BoxFit.contain,
                  width: 180,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Grocery App",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
          const Center(
            child: Text(
              "Login",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromARGB(255, 165, 25, 15),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FormHelper.inputFieldWidget(
            context,
            "Email",
            "E-mail",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "* Required";
              }

                bool emailValid =
                  RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?]+").hasMatch(onValidateVal);

              if (!emailValid) {
                return "Invalid E-mail";
              }
              return null;
            },
            (onSaveVal) {
            email= onSaveVal.toString().trim();
            },
            showPrefixIcon: true,
            prefixIcon: const Icon(Icons.email_outlined),
            borderRadius: 10,
            contentPadding: 15,
            fontSize: 14,
            prefixIconPaddingLeft: 10,
            borderColor: Colors.grey.shade400,
            textColor: Colors.black,
            prefixIconColor: Colors.black,
            hintColor: Colors.black.withOpacity(.6),
            backgroundColor: Colors.grey.shade100,
            borderFocusColor: Colors.grey.shade200,
          ),
          const SizedBox(
            height: 10,
          ),
          const SizedBox(
            height: 10,
          ),
          FormHelper.inputFieldWidget(
              context,
              "password",
              "Password",
              (onValidateVal) {
                if (onValidateVal.isEmpty) {
                  return "* Required";
                }
                return null;
              },
              (onSaveVal) {
                password = onSaveVal.toString().trim();
              },
              showPrefixIcon: true,
              prefixIcon: const Icon(Icons.lock_outlined),
              borderRadius: 10,
              contentPadding: 15,
              fontSize: 14,
              prefixIconPaddingLeft: 10,
              borderColor: Colors.grey.shade400,
              textColor: Colors.black,
              prefixIconColor: Colors.black,
              hintColor: Colors.black.withOpacity(.6),
              backgroundColor: Colors.grey.shade100,
              borderFocusColor: Colors.grey.shade200,
              obscureText: hidePassword,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    });
                  },
                  color: Colors.redAccent.withOpacity(.9),
                  icon: Icon(
                      hidePassword ? Icons.visibility_off : Icons.visibility)),
              onChange: (val) {
                password = val;
              }),
          
          const SizedBox(
            height: 15,
          ),
          Center(
              child: FormHelper.submitButton(
            "Sign In",
            () {
              if (validateAndSave()) {
                // API Request
                setState(() {
                  isAsynCallProgress = true;
                });

                APIService.loginUser(email!, password!)
                    .then((res) {
                  setState(() {
                    isAsynCallProgress = false;
                  });
                  if (res) {
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config.appName,
                      "User Logged-In sucessfully",
                      "OK",
                      () {
                        Navigator.of(context).pop();
                        Navigator.pushNamedAndRemoveUntil(
                          context ,"/Dashboard",
                          (route) => false,
                        );
                      },
                    );
                  } else {
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config.appName,
                      "Invalid Email/Password",
                      "OK",
                      () {
                        Navigator.of(context).pop();
                      },
                    );
                  }
                });
              }
            },
            btnColor: Color.fromARGB(255, 165, 25, 15),
            borderColor: Colors.white,
            txtColor: Colors.white,
            borderRadius: 20,
          )),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: RichText(
                text: TextSpan(
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14.0,
                    ),
                    children: <TextSpan>[
                  TextSpan(text: "Don't have an account ? "),
                  TextSpan(
                      text: "Sign Up",
                      style: TextStyle(
                          color: Color.fromARGB(255, 165, 25, 15),
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            "/register",
                            (route) => false,
                          );
                        })
                ])),
          )
        ],
      ),
    );
  }
   bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}



