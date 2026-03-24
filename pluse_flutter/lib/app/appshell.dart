import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class AppShell extends ConsumerStatefulWidget {


  const AppShell({super.key, });

  @override
  ConsumerState<AppShell> createState() => AppShellState();
}

class AppShellState extends ConsumerState<AppShell> {
  @override

 

  @override
  Widget build(BuildContext context) {
    final view = ref.watch(shellViewProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        layoutBuilder: (current, previous) => Stack(
          children: [...previous, if (current != null) current],
        ),
        child: _buildPage(view),
      ),
    );
  }

   Widget _buildPage(ShellView view) {
    switch (view) {
      case ShellView.onboarding:
        return ;
      case ShellView.authScreen:
        return ;
      case ShellView.callScreen:
        return ;
      case ShellView.home
      return ;

    }
  }
}




enum ShellView {onboarding, home, authScreen, callScreen }

final shellViewProvider =
    StateProvider<ShellView>((ref) => ShellView.chat);