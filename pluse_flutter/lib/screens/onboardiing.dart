import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pluse_flutter/app/appshell.dart';
import 'package:pluse_flutter/core/theme/app_theme.dart';
import 'package:the_responsive_builder/the_responsive_builder.dart';
import 'package:video_player/video_player.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late final PageController _pageController;
  VideoPlayerController? _videoController;

  Timer? _autoScrollTimer;

  int currentPage = 0;
  bool _isLoading = false;

  bool _isVideoReady = false;
  bool _showIntroCover = true;
  bool _showMainContent = false;

  final List<_OnboardingPageData> pages = const [
    _OnboardingPageData(
      title: 'Video meetings with expressions',
      title2: '& personality',
      subtext:
          'Talk in real time and switch into avatar mode for a more personal calling experience.',
    ),
    _OnboardingPageData(
      title: 'More personal video conversations',
      title2: 'More naturally',
      subtext:
          'Enjoy smooth video conversations with expressive avatar features that bring more personality.',
    ),
    _OnboardingPageData(
      title: 'Talk naturally, appear differently',
      title2: 'With avatars',
      subtext:
          'Join seamless conversations and communicate through both real video and avatar presence.',
    ),
    _OnboardingPageData(
      title: 'Built for immersive conversations',
      title2: 'Presence & style',
      subtext:
          'Experience video calling with avatar-based interaction built for comfort and personality.',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _pageController = PageController()
      ..addListener(() {
        if (!_pageController.hasClients) return;
        final nextPage = _pageController.page?.round() ?? 0;
        if (nextPage != currentPage && mounted) {
          setState(() {
            currentPage = nextPage;
          });
        }
      });

    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _videoController = VideoPlayerController.asset(
        'assets/images/BackgroundVideo.mp4', // <-- replace with your real path
      );

      await _videoController!.initialize();
      await _videoController!.setLooping(true);
      await _videoController!.setVolume(0);
      await _videoController!.play();

      if (!mounted) return;

      setState(() {
        _isVideoReady = true;
      });

      // Let the intro text breathe a little before revealing the video
      await Future.delayed(const Duration(milliseconds: 1400));

      if (!mounted) return;

      setState(() {
        _showIntroCover = false;
        _showMainContent = true;
      });

      // Start page auto-scroll after reveal
      await Future.delayed(const Duration(milliseconds: 500));

      if (!mounted) return;
      _startAutoScroll();
    } catch (e) {
      // If video fails, still reveal the content so the screen is usable
      if (!mounted) return;

      setState(() {
        _showIntroCover = false;
        _showMainContent = true;
      });

      _startAutoScroll();
    }
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();

    _autoScrollTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!_pageController.hasClients) return;

      final nextPage = (currentPage + 1) % pages.length;
      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    });
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _pageController.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  Future<void> _handleLoginTap() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    ref.read(shellViewProvider.notifier).state = ShellView.home;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return  Stack(
      children: [
        // =========================
        // 1. FULLSCREEN VIDEO BACKGROUND
        // =========================
        Positioned.fill(
          child: AnimatedOpacity(
            opacity: _isVideoReady ? 1 : 0,
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOut,
            child: _buildVideoBackground(),
          ),
        ),
    
        // =========================
        // 2. SOFT WHITE OVERLAY FOR LEGIBILITY
        // =========================
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedOpacity(
              opacity: _isVideoReady ? 1 : 0,
              duration: const Duration(milliseconds: 700),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withOpacity(0.2),
                      Colors.white.withOpacity(0.6),
                      Colors.white.withOpacity(0.3),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    
        // =========================
        // 3. MAIN ONBOARDING CONTENT
        // =========================
        Positioned.fill(
          child: IgnorePointer(
            ignoring: _showIntroCover,
            child: AnimatedOpacity(
              opacity: _showMainContent ? 1 : 0,
              duration: const Duration(milliseconds: 600),
              curve: Curves.easeOut,
              child: Column(
                children: [
                  SizedBox(height: 55.h),
    
                  Text(
                    "PluseMeet",
                    style: textTheme.labelSmall?.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.w700,
                    ),
                  )
                      .animate(target: _showMainContent ? 1 : 0)
                      .fadeIn(duration: 500.ms)
                      .slideY(begin: -0.2, end: 0),
    
                  SizedBox(height: 2.h),
    
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                        margin: EdgeInsets.symmetric(horizontal: 0.5.w),
                        width: currentPage == index ? 3.w : 2.w,
                        height: 0.8.h,
                        decoration: BoxDecoration(
                          color: currentPage == index
                              ? Colors.black
                              : Colors.black.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  )
                      .animate(target: _showMainContent ? 1 : 0)
                      .fadeIn(delay: 200.ms, duration: 450.ms)
                      .slideY(begin: -0.15, end: 0),
    
                  SizedBox(height: 4.h),
    
                  SizedBox(
                    height: 25.h,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: pages.length,
                      itemBuilder: (context, idx) {
                        final page = pages[idx];
                        return PageSlider(
                          title: page.title,
                          title2: page.title2,
                          subtext: page.subtext,
                        );
                      },
                    ),
                  ),
    
                 
    
                  Button(
                    logo: _isLoading
                        ? const Indicator()
                        : SizedBox(width: 1.w),
                    onTap: _handleLoginTap,
                  )
                      .animate(target: _showMainContent ? 1 : 0)
                      .fadeIn(delay: 500.ms, duration: 500.ms)
                      .slideY(begin: 0.25, end: 0)
                      .scaleXY(begin: 0.96, end: 1),
    
                  SizedBox(height: 1.h),
                ],
              ),
            ),
          ),
        ),
    
        // =========================
        // 4. INTRO COVER
        // =========================
        Positioned.fill(
          child: AnimatedSlide(
            offset: _showIntroCover ? Offset.zero : const Offset(0, -1),
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeInOutCubic,
            child: AnimatedOpacity(
              opacity: _showIntroCover ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "PluseMeet",
                          textAlign: TextAlign.center,
                          style: textTheme.labelSmall?.copyWith(
                            color: Colors.black87,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                            .animate()
                            .fadeIn(duration: 450.ms)
                            .slideY(begin: -0.2, end: 0),
    
                        SizedBox(height: 3.h),
    
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: "Video meetings with expressions\n",
                                style: textTheme.displayLarge?.copyWith(
                                  fontSize: 34.sp,
                                  height: 1.15,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: "& personality",
                                style: textTheme.displayLarge?.copyWith(
                                  fontSize: 40.sp,
                                  height: 1.0,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        )
                            .animate()
                            .slideX(
                              begin: 0.45,
                              end: 0,
                              duration: 700.ms,
                              curve: Curves.easeOutCubic,
                            )
                            .fadeIn(duration: 350.ms)
                            .scaleXY(
                              begin: 1.03,
                              end: 1,
                              duration: 700.ms,
                              curve: Curves.easeOutCubic,
                            ),
    
                        SizedBox(height: 2.h),
    
                        Text(
                          "Talk in real time and switch into avatar mode for a more personal calling experience.",
                          textAlign: TextAlign.center,
                          style: textTheme.labelMedium?.copyWith(
                            fontSize: 12.5.sp,
                            color: Colors.black87,
                            height: 1.45,
                          ),
                        )
                            .animate()
                            .fadeIn(delay: 350.ms, duration: 450.ms)
                            .slideY(
                              begin: 0.18,
                              end: 0,
                              delay: 350.ms,
                              duration: 500.ms,
                              curve: Curves.easeOutCubic,
                            ),
    
                        SizedBox(height: 4.h),
    
                        if (!_isVideoReady)
                          const SizedBox(
                            width: 26,
                            height: 26,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.4,
                              color: Colors.black,
                            ),
                          )
                              .animate(onPlay: (controller) => controller.repeat())
                              .fadeIn(duration: 350.ms)
                              .scaleXY(begin: 0.92, end: 1.04, duration: 700.ms)
                              .then()
                              .scaleXY(begin: 1.04, end: 0.92, duration: 700.ms),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVideoBackground() {
    if (_videoController == null || !_videoController!.value.isInitialized) {
      return const SizedBox.shrink();
    }

    final videoSize = _videoController!.value.size;

    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: videoSize.width,
          height: videoSize.height,
          child: VideoPlayer(_videoController!),
        ),
      ),
    );
  }
}

class _OnboardingPageData {
  final String title;
  final String title2;
  final String subtext;

  const _OnboardingPageData({
    required this.title,
    required this.title2,
    required this.subtext,
  });
}

class PageSlider extends StatelessWidget {
  const PageSlider({
    super.key,
    required this.title,
    required this.title2,
    required this.subtext,
  });

  final String title;
  final String title2;
  final String subtext;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 7.w),
      child: Column(
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "$title\n",
                  style: textTheme.displayLarge?.copyWith(
                    fontSize: 35.sp,
                    color: Colors.black,
                    height: 1.18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextSpan(
                  text: title2,
                  style: textTheme.displayLarge?.copyWith(
                    fontSize: 40.sp,
                    height: 1.0,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          )
              .animate()
              .slideX(
                begin: 0.18,
                end: 0,
                duration: 420.ms,
                curve: Curves.easeOutCubic,
              )
              .fadeIn(duration: 280.ms),

          const SizedBox(height: 16),

          Text(
            subtext,
            textAlign: TextAlign.center,
            style: textTheme.labelMedium?.copyWith(
              fontSize: 12.sp,
              color: Colors.black87,
              height: 1.45,
            ),
          )
              .animate()
              .fadeIn(delay: 120.ms, duration: 350.ms)
              .slideY(begin: 0.15, end: 0),
        ],
      ),
    );
  }
}

class Button extends StatelessWidget {
  final VoidCallback onTap;
  final Widget logo;

  const Button({
    super.key,
    required this.onTap,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 28),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.black,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logo,
            SizedBox(width: 3.w),
            const Text(
              "Get Started Now",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  const Indicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: AppColors.light,
      strokeWidth: 3.5,
    );
  }
}