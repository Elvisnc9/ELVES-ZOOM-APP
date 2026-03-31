import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pluse_flutter/core/theme/app_theme.dart';
import 'package:pluse_flutter/screens/callScreen.dart';
import 'package:pluse_flutter/screens/home.dart';
import 'package:pluse_flutter/screens/meeting_detail.dart';
import 'package:pluse_flutter/screens/onboardiing.dart';
import 'package:pluse_flutter/screens/videoscreen.dart';


class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentView = ref.watch(shellViewProvider);

    return  Scaffold(
          backgroundColor: AppColors.light,
          body: AnimatedSwitcher(
            duration: 600.ms,
            switchInCurve: Curves.easeOutExpo,
            switchOutCurve: Curves.easeInExpo,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.05, 0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              );
            },
            child: _buildScreen(currentView),
          ),
        );
   
  }

  Widget _buildScreen(ShellView view) {
    switch (view) {
      case ShellView.onboarding:
        return const OnboardingScreen(key: ValueKey('onboarding'));
      case ShellView.home:
        return const HomeScreen(key: ValueKey('home'));
      case ShellView.calling:
        return const CallingScreen(key: ValueKey('calling'));
      case ShellView.video:
        return const VideocallScreen(key: ValueKey('video'));
      case ShellView.meetingDetail:
        return const MeetingDetail(key: ValueKey('meetingDetail'));
      default:
        return const OnboardingScreen(key: ValueKey('onboarding'));
    }
  }
}


enum ShellView { onboarding, home, calling, video, meetingDetail, login, signup }

final shellViewProvider = StateProvider<ShellView>((ref) => ShellView.onboarding);
final selectedMeetingProvider = StateProvider<String?>((ref) => null);