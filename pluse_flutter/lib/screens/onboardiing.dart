import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pluse_flutter/widgets/circle_Avatar.dart';
import 'dart:math' as math;

import 'package:the_responsive_builder/the_responsive_builder.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoSlideTimer;

  static const int _totalPages = 4;
  static const Duration _autoSlideDuration = Duration(seconds: 4);
  static const Duration _slideAnimDuration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(_autoSlideDuration, (_) {
      if (!mounted) return;
      final nextPage = (_currentPage + 1) % _totalPages;
      _pageController.animateToPage(
        nextPage,
        duration: _slideAnimDuration,
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _autoSlideTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _onSkip() {
    // Navigate to main app — placeholder
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Onboarding skipped!')),
    );
  }

  void _onContinue() {
    if (_currentPage < _totalPages - 1) {
      _pageController.animateToPage(
        _currentPage + 1,
        duration: _slideAnimDuration,
        curve: Curves.easeInOut,
      );
    } else {
      // Last page — navigate to main app
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Let\'s go!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Column(
          children: [
            // ── Top bar ───────────────────────────────────────
            _TopBar(
              currentPage: _currentPage,
              totalPages: _totalPages,
              onSkip: _onSkip,
            ),

            // ── Page content ──────────────────────────────────
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                children:  [
                 _animatedScrollers(),
                 _animatedScrollers(),
                 _animatedScrollers(),
                 _animatedScrollers()
                ],
              ),
            ),

        

           CircleCluster(),


           SizedBox(height: 3.h),
            // ── Bottom button ─────────────────────────────────
            _BottomButton(onTap: _onContinue),

            const SizedBox(height: 10),
          ],
        ),
      
    );
  }
 Widget _animatedScrollers(){
return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       
    
        // ── Title ──────────────────────────────────────────────
         Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.0),
          child: Text(
            'Connect face-to-face anytime!',
            textAlign: TextAlign.center,
            style: GoogleFonts.spaceGrotesk(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w900,
              height: 1.15,
            ),
          ),
        ),
    
        const SizedBox(height: 14),
    
        // ── Subtitle ───────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                color: Color(0xFFBDBDBD),
                fontSize: 15,
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: 'Host or join meetings with crystal-clear video, audio, and smooth collaboration.',
                ),
                TextSpan(
                  text: 'One Tap Join',
                  style: TextStyle(
                    color: Color(0xFF76FF03),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
    
        const SizedBox(height: 18),
    
        // ── HP Badge ───────────────────────────────────────────
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color:  Color(0xFF76FF03), width: 2),
          ),
          child:  Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('⚡', style: TextStyle(fontSize: 16)),
              SizedBox(width: 6),
              Text(
                'Secure Calls',
                 style: GoogleFonts.spaceGrotesk(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w900,
              ),
              ),
            ],
          ),
        ),
    
      
      ],
    );
 }
}

// ─────────────────────────────────────────────────────────────────────────────
// Top Bar: reward text | dot indicators | skip
// ─────────────────────────────────────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final VoidCallback onSkip;

  const _TopBar({
    required this.currentPage,
    required this.totalPages,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text('NexoMeet', style: GoogleFonts.spaceGrotesk(color: Color(0xFFBDBDBD), fontSize: 16.sp, fontWeight: FontWeight.bold)),
            ],
          ),

          SizedBox(
            height: 5.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(totalPages, (i) {
                final bool active = i == currentPage;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: active ? 12 : 7,
                  height: 7,
                  decoration: BoxDecoration(
                    color: active ? Colors.white : const Color(0xFF555555),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Bottom CTA button
// ─────────────────────────────────────────────────────────────────────────────
class _BottomButton extends StatelessWidget {
  final VoidCallback onTap;

  const _BottomButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: const Color(0xFFE8E8E8),
            borderRadius: BorderRadius.circular(18),
          ),
          child:  Center(
            child: Text(
              'Get Started',
              style: GoogleFonts.spaceGrotesk(
                color: Color(0xFF1A1A1A),
                fontSize: 18.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ),
    );
  }
}