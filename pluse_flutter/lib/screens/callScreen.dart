import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pluse_flutter/app/appshell.dart';

class MeetingView extends ConsumerWidget {
  const MeetingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: const Color(0xFFF8EEFC), // Match shell background
      child: SafeArea(
        child: Column(
          children: [
            // Top App Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                    onPressed: () => ref.read(shellViewProvider.notifier).state = ShellView.home,
                  ),
                  const Column(
                    children: [
                      Text("Project Breef Ui", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text("13:24:40", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                  IconButton(icon: const Icon(Icons.help_outline), onPressed: () {}),
                ],
              ),
            ).animate().slideY(begin: -0.5).fadeIn(),

            // Main Speaker Video
            Expanded(
              flex: 2,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: const DecorationImage(
                    image: NetworkImage('https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?q=80&w=600&auto=format&fit=crop'), // Placeholder
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 16, left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: Colors.white70, borderRadius: BorderRadius.circular(12)),
                        child: const Row(
                          children: [
                            Icon(Icons.circle, color: Colors.red, size: 10),
                            SizedBox(width: 4),
                            Text("00:24:56", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    const Positioned(
                      bottom: 16, left: 16,
                      child: Row(
                        children: [
                          CircleAvatar(radius: 16, backgroundImage: NetworkImage('https://i.pravatar.cc/102')),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Alexx Manuel", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              Text("Project Manager - Host", style: TextStyle(color: Colors.white70, fontSize: 10)),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ).animate().scale(delay: 200.ms, curve: Curves.easeOutBack),
            ),

            // Grid of Other Participants
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(child: _ParticipantTile('https://i.pravatar.cc/103', 'Adams - UI').animate().slideX(begin: -0.2, delay: 300.ms).fadeIn()),
                    const SizedBox(width: 12),
                    Expanded(child: _ParticipantTile('https://i.pravatar.cc/104', 'Iman - UX').animate().slideX(begin: 0.2, delay: 300.ms).fadeIn()),
                  ],
                ),
              ),
            ),
            
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(child: _ParticipantTile('https://i.pravatar.cc/105', 'Anna - Dev').animate().slideX(begin: -0.2, delay: 400.ms).fadeIn()),
                    const SizedBox(width: 12),
                    Expanded(child: _ParticipantTile('https://i.pravatar.cc/106', 'Prince - Lead').animate().slideX(begin: 0.2, delay: 400.ms).fadeIn()),
                  ],
                ),
              ),
            ),

            // Bottom Call Controls
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.mic_off, color: Colors.grey),
                  const Icon(Icons.videocam, color: Colors.black),
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.deepPurpleAccent,
                    child: const Icon(Icons.auto_awesome, color: Colors.white),
                  ).animate(onPlay: (controller) => controller.repeat(reverse: true)).scaleXY(begin: 1, end: 1.1, duration: 1.seconds), // Subtle pulsing animation
                  const Icon(Icons.chat_bubble_outline, color: Colors.black),
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.redAccent,
                    child: const Icon(Icons.call_end, color: Colors.white),
                  ),
                ],
              ),
            ).animate().slideY(begin: 1, delay: 500.ms, curve: Curves.easeOutCubic),
          ],
        ),
      ),
    );
  }
}

class _ParticipantTile extends StatelessWidget {
  final String imageUrl;
  final String name;

  const _ParticipantTile(this.imageUrl, this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(8),
      child: Text(
        name,
        style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, backgroundColor: Colors.black38),
      ),
    );
  }
}