import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/pages/signin_page.dart';
import 'package:instaclonebloc/services/auth_service.dart';

import '../bloc/signin_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  _doSignOut()async{
    await AuthService.signOutUser();
    callSignInPage(context);
  }

  callSignInPage(BuildContext context) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => SignInBloc(),
              child: const SignInPage(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Home Page"),
      ),
      body: Center(
        child: MaterialButton(
          color: Colors.blue,
          onPressed: (){
            _doSignOut();
          },
          child: Text("Sign Out"),
        ),
      ),
    );
  }
}
