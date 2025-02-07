
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/bloc/signin_bloc.dart';
import 'package:instaclonebloc/bloc/splash_event.dart';
import 'package:instaclonebloc/bloc/splash_state.dart';
import 'package:instaclonebloc/pages/home_page.dart';
import 'package:instaclonebloc/pages/signin_page.dart';
import 'package:instaclonebloc/services/auth_service.dart';

import 'home_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState>{

  SplashBloc(): super(SplashInitialState()){
    on<SplashWaitEvent>(_onSplashWaitEvent);
  }

  Future<void> _onSplashWaitEvent(SplashWaitEvent event, Emitter<SplashState> emit) async{
    emit(SplashLoadingState());
    await Future.delayed(Duration(seconds: 2));
    emit(SplashLoadedState());
  }

  callNextPage(BuildContext context){
    if(AuthService.isLoggedIn()){
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => HomeBloc(),
                child: HomePage(),
              )));
    }else{
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => SignInBloc(),
              child: SignInPage(),
            );
          }
      ));
    }
  }
}