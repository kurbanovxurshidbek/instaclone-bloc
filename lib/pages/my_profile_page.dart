import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/pages/signin_page.dart';
import 'package:instaclonebloc/services/auth_service.dart';

import '../bloc/signin_bloc.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {

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
        title: Text("Profile"),
        actions: [
          IconButton(
            onPressed: (){
              _doSignOut();
            },
            icon: Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Center(
        child: Text("Profile Page"),
      ),
    );
  }
}
