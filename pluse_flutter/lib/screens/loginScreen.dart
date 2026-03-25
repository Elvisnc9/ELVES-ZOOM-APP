import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pluse_flutter/app/appshell.dart';
import 'package:pluse_flutter/widgets/customTexfield.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFDFCFE), Color(0xFFF3E7F9)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Text(
                "Welcome Back",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A)),
              ).animate().fadeIn(duration: 400.ms).slideX(begin: -0.2),
              
              Text(
                "Login to continue your meetings",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1),

              const SizedBox(height: 48),

              // Email Field
              CustomTextField(
                label: "Email Address",
                hint: "example@gmail.com",
                icon: Icons.email_outlined,
              ).animate().fadeIn(delay: 300.ms).moveY(begin: 20, end: 0),

              const SizedBox(height: 20),

              // Password Field
              CustomTextField(
                label: "Password",
                hint: "••••••••",
                icon: Icons.lock_outline,
                isPassword: true,
              ).animate().fadeIn(delay: 400.ms).moveY(begin: 20, end: 0),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Forgot Password?", style: TextStyle(color: Colors.deepPurple)),
                ),
              ),

              const Spacer(),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => ref.read(shellViewProvider.notifier).state = ShellView.home,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C48EF),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: const Text("Sign In", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ).animate().scale(delay: 500.ms, curve: Curves.easeOutBack),

              const SizedBox(height: 16),

              // Social Login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?", style: TextStyle(color: Colors.grey[600])),
                  TextButton(
                    onPressed: () => ref.read(shellViewProvider.notifier).state = ShellView.signup,
                    child: const Text("Sign Up", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6C48EF))),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}