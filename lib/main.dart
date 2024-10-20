import 'package:chat/pages/chat_page.dart';

import 'package:chat/pages/cubits/loginCubit/login_cubit.dart';
import 'package:chat/pages/cubits/registerCubit/register_cubit.dart';
import 'package:chat/pages/login_page.dart';
import 'package:chat/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ScholarChat());
}

class ScholarChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:[
BlocProvider(create: (context) => LoginCubit(),), 
BlocProvider(create: (context) => RegisterCubit(),),
 
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          LoginPage.id: (context) => LoginPage(),
          RegisterPage.id: (context) => RegisterPage(),
          ChatPage.id: (context) => ChatPage(),
        },
        initialRoute: LoginPage.id,
        home: LoginPage(),
      ),
    );
  }
}
