
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/bloc/splash_bloc.dart';
import 'package:instaclonebloc/bloc/splash_event.dart';
import 'package:instaclonebloc/bloc/splash_state.dart';
import 'package:instaclonebloc/main.dart';
import 'package:instaclonebloc/services/log_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  late SplashBloc splashBloc;

  @override
  void initState() {
    super.initState();
    splashBloc = context.read<SplashBloc>();
    splashBloc.add(SplashWaitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state){
          if(state is SplashLoadedState){
            splashBloc.callNextPage(context);
          }
        },
        builder: (context, state){

          return Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(193, 53, 132, 1),
                      Color.fromRGBO(131, 58, 180, 1),
                    ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                Expanded(
                  child: Center(
                    child: Text(
                      "Instagram",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                          fontFamily: "Billabong"),
                    ),
                  ),
                ),
                Text(
                  "All rights reserved",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(
                  height: 20,
                ),

              ],
            ),
          );
        },
      )
    );
  }
}
