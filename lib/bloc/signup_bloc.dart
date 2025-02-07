import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/bloc/signin_bloc.dart';
import 'package:instaclonebloc/bloc/signup_event.dart';
import 'package:instaclonebloc/bloc/signup_state.dart';
import 'package:instaclonebloc/pages/home_page.dart';
import 'package:instaclonebloc/services/prefs_service.dart';

import '../pages/signin_page.dart';
import '../services/auth_service.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitialState()) {
    on<SignedUpEvent>(_onSignedUpEvent);
  }

  Future<void> _onSignedUpEvent(
      SignedUpEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpLoadingState());

    User? firebaseUser = await AuthService.signUpUser(event.context, event.email, event.password);

    if (firebaseUser != null) {
      _saveMemberIdToLocal(firebaseUser);
      //_saveMemberToCloud(Member(event.fullname, event.email));
      emit(SignUpSuccessState());
    } else {
      emit(SignUpFailureState("Check information again"));
    }
  }

  _saveMemberIdToLocal(User firebaseUser) async {
    await PrefsService.saveUserId(firebaseUser.uid);
  }

  callHomePage(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
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
}
