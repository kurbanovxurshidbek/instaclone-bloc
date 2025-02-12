import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instaclonebloc/bloc/home_bloc.dart';
import 'package:instaclonebloc/bloc/home_state.dart';
import 'package:instaclonebloc/pages/signin_page.dart';
import 'package:instaclonebloc/services/auth_service.dart';
import 'package:instaclonebloc/services/log_service.dart';

import '../bloc/axis_count_bloc.dart';
import '../bloc/follow_member_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/image_picker_bloc.dart';
import '../bloc/like_post_bloc.dart';
import '../bloc/my_feed_bloc.dart';
import '../bloc/my_likes_bloc.dart';
import '../bloc/my_photo_bloc.dart';
import '../bloc/my_posts_bloc.dart';
import '../bloc/my_profile_bloc.dart';
import '../bloc/my_search_bloc.dart';
import '../bloc/my_upload_bloc.dart';
import '../bloc/signin_bloc.dart';
import 'my_feed_page.dart';
import 'my_likes_page.dart';
import 'my_profile_page.dart';
import 'my_search_page.dart';
import 'my_upload_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();
  late HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = context.read<HomeBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        LogService.i(state.currentIndex.toString());
      },
      builder: (context, state) {
        return Scaffold(
          body: PageView(
            onPageChanged: (int index) {
              homeBloc.add(PageViewEvent(currentIndex: index));
            },
            controller: pageController,
            children: [
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => MyFeedBloc(),
                  ),
                  BlocProvider(
                    create: (context) => LikePostBloc(),
                  ),
                ],
                child: MyFeedPage(
                  pageController: pageController,
                ),
              ),
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => MySearchBloc(),
                  ),
                  BlocProvider(
                    create: (context) => FollowMemberBloc(),
                  ),
                ],
                child: const MySearchPage(),
              ),
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => MyUploadBloc(),
                  ),
                  BlocProvider(
                    create: (context) => ImagePickerBloc(),
                  ),
                ],
                child: MyUploadPage(
                  pageController: pageController,
                ),
              ),
              BlocProvider(
                create: (context) => MyLikedBloc(),
                child: const MyLikesPage(),
              ),
              MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => MyProfileBloc(),
                  ),
                  BlocProvider(
                    create: (context) => MyPostsBloc(),
                  ),
                  BlocProvider(
                    create: (context) => AxisCountBloc(),
                  ),
                  BlocProvider(
                    create: (context) => MyPhotoBloc(),
                  ),
                ],
                child: const MyProfilePage(),
              ),
            ],
          ),
          bottomNavigationBar: CupertinoTabBar(
            onTap: (int index) {
              homeBloc.add(BottomNavEvent(currentIndex: index));
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeIn);
            },
            currentIndex: state.currentIndex,
            activeColor: const Color.fromRGBO(193, 53, 132, 1),
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: 32,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  size: 32,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_box,
                  size: 32,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  size: 32,
                ),
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_circle,
                  size: 32,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
