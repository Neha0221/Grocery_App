import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:groceryapp/api/api_service.dart';
import 'package:groceryapp/config.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  static final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool isAsyncCallProcess = false;
  String? fullName;
  String? password;
  String? confirmPassword;
  String? email;
  bool hidePassword = true;
  bool hidenConfirmPassword = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: ProgressHUD(
          child: Form(
            key: globalKey,
            child: _registerUI(context),
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
              "Register",
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
            "fullName",
            "Full Name",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "* Required";
              }
              return null;
            },
            (onSaveVal) {
              fullName = onSaveVal.toString().trim();
            },
            showPrefixIcon: true,
            prefixIcon: const Icon(Icons.face),
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
          FormHelper.inputFieldWidget(
            context,
            "email",
            "E-Mail",
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
              email = onSaveVal.toString().trim();
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
            height: 10,
          ),
          FormHelper.inputFieldWidget(
            context,
            "Confirmpassword",
            "Confirm Password",
            (onValidateVal) {
              if (onValidateVal.isEmpty) {
                return "* Required";
              }

              if (onValidateVal != password) {
                return "Confirm Password not matched";
              }

              return null;
            },
            (onSaveVal) {
              confirmPassword = onSaveVal.toString().trim();
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
            obscureText: hidenConfirmPassword,
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    hidenConfirmPassword = !hidenConfirmPassword;
                  });
                },
                color: Colors.redAccent.withOpacity(.9),
                icon: Icon(hidenConfirmPassword
                    ? Icons.visibility_off
                    : Icons.visibility)),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
              child: FormHelper.submitButton(
            "Sign Up",
            () {
              if (validateSave()) {
                // API Request
                setState(() {
                  isAsyncCallProcess = true;
                });

                APIService.registerUser(
                fullName!, 
                email!,
                password!)
                    .then((response) {
                  setState(() {
                    isAsyncCallProcess = false;
                  });
                  if (response) {
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config.appName,
                      "Registration completed sucessfully",
                      "OK",
                      () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            "/login",
                            (route) => false,
                          );
                      },
                    );
                  } else {
                    FormHelper.showSimpleAlertDialog(
                      context,
                      Config.appName,
                      "This E-mail already registered",
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
                  TextSpan(text: "Already have an account? "),
                  TextSpan(
                      text: "Sign In",
                      style: TextStyle(
                          color: Color.fromARGB(255, 165, 25, 15),
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            "/login",
                            (route) => false,
                          );
                        }
                    )
                ])),
          )
        ],
      ),
    );
  }

  bool validateSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
