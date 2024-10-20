import 'package:chat/constants.dart';
import 'package:chat/pages/chat_page.dart';
import 'package:chat/pages/cubits/registerCubit/register_cubit.dart';
import 'package:chat/widgets/custom_botton.dart';
import 'package:chat/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snak_bar.dart';

class RegisterPage extends StatelessWidget {
  String? email;
  static String id = 'registerPage';
  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
        } else if (state is RegisterSuccess) {
          Navigator.of(context).pushNamed(ChatPage.id);
          isLoading = false;
        } else if (state is RegisterFailure) {
          showSnakBar(context, state.errMessage);
          isLoading = false;
        }
      },
      builder: (context, state) {
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
                      height: 50,
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
                      height: 40,
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
                      height: 30,
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
                      height: 30,
                    ),
                    CustomFormTextField(
                      onChanged: (data) {
                        password = data;
                      },
                      hintText: 'Password',
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<RegisterCubit>(context)
                              .registerUser(
                                  email: email!, password: password!);
                        }
                      },
                      text: 'Register',
                    ),
                    SizedBox(
                      height: 30,
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
      },
    );
  }
}
