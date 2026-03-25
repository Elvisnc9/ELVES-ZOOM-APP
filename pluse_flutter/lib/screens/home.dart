import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pluse_flutter/app/appshell.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Custom Top Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage('https://i.pravatar.cc/100'),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Hi, Jualine 👋", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text("Ready to meeting Today?", style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {},
                  )
                ],
              ),
            ).animate().slideX(begin: -0.1).fadeIn(),

            // AI Assistants Banner
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: const LinearGradient(
                  colors: [Color(0xFFE0C3FC), Color(0xFF8EC5FC)], // Soft purple/blue gradient
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.auto_awesome, color: Colors.deepPurple),
                      const SizedBox(width: 8),
                      const Text("Ai Assistants", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text("Use AI assistant to help you, automatic translator, answer questions, etc.", style: TextStyle(fontSize: 13)),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.auto_awesome, size: 16),
                    label: const Text("Access Now"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.5),
                      foregroundColor: Colors.deepPurple,
                      elevation: 0,
                    ),
                  )
                ],
              ),
            ).animate().scale(delay: 100.ms, curve: Curves.easeOutBack),

            // Tab Bar Area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ["On Going", "Up Coming", "Ended", "Cancel"].map((tab) {
                  bool isActive = tab == "On Going";
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isActive ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: isActive ? Colors.deepPurple : Colors.transparent),
                    ),
                    child: Text(
                      tab,
                      style: TextStyle(
                        color: isActive ? Colors.deepPurple : Colors.grey,
                        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ).animate().fadeIn(delay: 200.ms),

            const SizedBox(height: 20),

            // Meeting List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _MeetingCard(
                    title: "Weekly Meeting Vektora",
                    subtitle: "User Interface Design",
                    time: "3:00 PM",
                    onTapVideo: () => ref.read(shellViewProvider.notifier).state = ShellView.meeting,
                  ).animate().slideY(begin: 0.2, delay: 300.ms).fadeIn(),
                  
                  const SizedBox(height: 16),
                  
                  _MeetingCard(
                    title: "Weekly Meeting Hohua",
                    subtitle: "Client Feedback Meeting",
                    time: "5:00 PM",
                    onTapVideo: () => ref.read(shellViewProvider.notifier).state = ShellView.meeting,
                  ).animate().slideY(begin: 0.2, delay: 400.ms).fadeIn(),
                ],
              ),
            ),

            // Custom Floating Bottom Nav bar
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _NavIcon(Icons.home_filled, "Home", true),
                  _NavIcon(Icons.videocam_outlined, "", false),
                  _NavIcon(Icons.calendar_today_outlined, "", false),
                  _NavIcon(Icons.person_outline, "", false),
                ],
              ),
            ).animate().slideY(begin: 1.0, delay: 500.ms, curve: Curves.easeOutBack),
          ],
        ),
      ),
    );
  }
}

// Helper Widgets
class _MeetingCard extends StatelessWidget {
  final String title, subtitle, time;
  final VoidCallback onTapVideo;

  const _MeetingCard({required this.title, required this.subtitle, required this.time, required this.onTapVideo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F5FF), // Very light purple
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(radius: 12, backgroundImage: NetworkImage('https://i.pravatar.cc/101')),
              const SizedBox(width: 8),
              const Text("Sabiq Meeting Room", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const Spacer(),
              const Icon(Icons.keyboard_arrow_up),
            ],
          ),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    child: const Text("Start in 7h 30m", style: TextStyle(fontSize: 11, color: Colors.grey)),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 14, color: Colors.grey),
                      const SizedBox(width: 4),
                      Text(time, style: const TextStyle(fontSize: 11, color: Colors.grey)),
                    ],
                  )
                ],
              ),
              GestureDetector(
                onTap: onTapVideo,
                child: CircleAvatar(
                  backgroundColor: Colors.deepPurpleAccent,
                  child: const Icon(Icons.videocam, color: Colors.white, size: 20),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

Widget _NavIcon(IconData icon, String label, bool isActive) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: isActive ? 16 : 8, vertical: 8),
    decoration: BoxDecoration(
      color: isActive ? Colors.deepPurple : Colors.transparent,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Icon(icon, color: isActive ? Colors.white : Colors.grey),
        if (isActive) ...[
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ]
      ],
    ),
  );
}