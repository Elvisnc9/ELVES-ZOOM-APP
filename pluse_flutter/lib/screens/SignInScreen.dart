
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pluse_flutter/app/appshell.dart';
import 'package:pluse_flutter/widgets/customTexfield.dart';

class SignupView extends ConsumerWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => ref.read(shellViewProvider.notifier).state = ShellView.login,
              ),
              const SizedBox(height: 20),
              const Text(
                "Create Account",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ).animate().fadeIn().slideY(begin: 0.1),

              const SizedBox(height: 32),

              // Avatar Picker Placeholder
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.deepPurple.withOpacity(0.1),
                      child: const Icon(Icons.person_outline, size: 40, color: Colors.deepPurple),
                    ),
                    Positioned(
                      bottom: 0, right: 0,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.deepPurple,
                        child: const Icon(Icons.add, size: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ).animate().scale(delay: 200.ms),

              const SizedBox(height: 40),

              CustomTextField(label: "Full Name", hint: "John Doe", icon: Icons.person_outline),
              const SizedBox(height: 20),
              CustomTextField(label: "Email", hint: "example@gmail.com", icon: Icons.email_outlined),
              const SizedBox(height: 20),
              CustomTextField(label: "Password", hint: "••••••••", icon: Icons.lock_outline, isPassword: true),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => ref.read(shellViewProvider.notifier).state = ShellView.home,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C48EF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: const Text("Create Account", style: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ).animate().fadeIn(delay: 400.ms),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}