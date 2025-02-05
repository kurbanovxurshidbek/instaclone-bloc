
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instaclonebloc/bloc/splash_event.dart';
import 'package:instaclonebloc/bloc/splash_state.dart';
import 'package:instaclonebloc/pages/home_page.dart';

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
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return HomePage();
      }
    ));
  }
}