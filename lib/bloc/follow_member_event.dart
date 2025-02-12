import 'package:equatable/equatable.dart';

import '../models/member_model.dart';


abstract class FollowEvent extends Equatable {
  const FollowEvent();
}

class FollowMemberEvent extends FollowEvent {
  Member someone;

  FollowMemberEvent({required this.someone});

  @override
  List<Object> get props => [someone];
}

class UnFollowMemberEvent extends FollowEvent {
  Member someone;

  UnFollowMemberEvent({required this.someone});

  @override
  List<Object> get props => [someone];
}