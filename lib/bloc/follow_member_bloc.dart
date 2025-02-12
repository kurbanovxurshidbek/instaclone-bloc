

import 'package:bloc/bloc.dart';

import '../services/db_service.dart';
import 'follow_member_event.dart';
import 'follow_member_state.dart';

class FollowMemberBloc extends Bloc<FollowEvent, FollowState> {
  FollowMemberBloc() : super(FollowMemberInitialState()) {
    on<FollowMemberEvent>(_onFollowMemberEvent);
    on<UnFollowMemberEvent>(_onUnFollowMemberEvent);
  }


  Future<void> _onFollowMemberEvent(FollowMemberEvent event, Emitter<FollowState> emit) async {
    await DBService.followMember(event.someone);
    event.someone.followed = true;
    emit(FollowMemberSuccessState(member: event.someone));

    DBService.storePostsToMyFeed(event.someone);
  }

  Future<void> _onUnFollowMemberEvent(UnFollowMemberEvent event, Emitter<FollowState> emit) async {
    await DBService.unFollowMember(event.someone);
    event.someone.followed = false;
    emit(UnFollowMemberSuccessState(member: event.someone));

    DBService.removePostsFromMyFeed(event.someone);
  }
}