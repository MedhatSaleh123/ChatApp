
import 'package:chat/constants.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/widgets/custom_botton.dart';
import 'package:chat/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snak_bar.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({super.key});
  static String id = 'registerPage';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: KpraimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                    height: 150,
                    child: Image.asset('assets/images/scholar.png')),
                Text(
                  'Scholar Chat',
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontFamily: 'pacifico'),
                ),
                SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'REGISTER',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomFormTextField(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: 'Email',
                ),
                // new FlutterPwValidator(
                //   controller: controller,
                //   minLength: 6,
                //   uppercaseCharCount: 2,
                //   lowercaseCharCount: 2,
                //   numericCharCount: 3,
                //   specialCharCount: 1,
                //   width: 400,
                //   height: 150,
                //   onSuccess: () {
                //     print("MATCHED");
                //     ScaffoldMessenger.of(context).showSnackBar(
                //         new SnackBar(content: new Text("Password is matched")));
                //   },
                //   onFail: () {
                //     print("NOT MATCHED");
                //   },
                // ),
                SizedBox(
                  height: 10,
                ),
                CustomFormTextField(
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: 'Password',
                ),
                SizedBox(
                  height: 10,
                ),
                CustomButton(
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await registerUser();
                        Navigator.pushNamed(context, ChatPage.id);
                        showSnakBar(context, "success");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnakBar(context, "user not found");
                        } else if (e.code == 'wrong-password') {
                          showSnakBar(context, "wrong password");
                        }
                      }
                      isLoading = false;
                      setState(() {});
                    }
                  },
                  text: 'Register',
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "already have an account? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          '  login',
                          style: TextStyle(color: Color(0xffC7EDE6)),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
