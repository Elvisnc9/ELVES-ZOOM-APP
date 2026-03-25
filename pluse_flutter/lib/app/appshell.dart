import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:pluse_flutter/screens/SignInScreen.dart';
import 'package:pluse_flutter/screens/callScreen.dart';
import 'package:pluse_flutter/screens/home.dart';
import 'package:pluse_flutter/screens/loginScreen.dart';
import 'package:pluse_flutter/screens/onboardiing.dart';

// --- STATE MANAGEMENT ---
enum ShellView { onboarding, home, meeting, login, signup }

final shellViewProvider = StateProvider<ShellView>((ref) => ShellView.onboarding);

// --- APP SHELL ---
class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});
  @override
  ConsumerState<AppShell> createState() => AppShellState();
}

class AppShellState extends ConsumerState<AppShell> {
  Widget _buildPage(ShellView view) {
    switch (view) {
      case ShellView.onboarding:
        return const OnboardingScreen(key: ValueKey('onboarding'));
        case ShellView.login:
  return const LoginView(key: ValueKey('login'));
case ShellView.signup:
  return const SignupView(key: ValueKey('signup'));
      case ShellView.home:
        return const HomeView(key: ValueKey('home'));
      case ShellView.meeting:
        return const MeetingView(key: ValueKey('meeting'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final view = ref.watch(shellViewProvider);

    return Scaffold(
      backgroundColor:  Colors.black, // Light pinkish bg from the design
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: AnimatedSwitcher(
        // Super smooth cross-fade and scale transition between major screens
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.0, 0.05),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        layoutBuilder: (current, previous) => Stack(
          children: [...previous, ?current],
        ),
        child: _buildPage(view),
      ),
    );
  }
}