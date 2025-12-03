import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:beta_project/cubits/auth_cubit.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late VideoPlayerController _videoController;
  bool _isLogin = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/videos/login_register.mp4')
      ..initialize().then((_) {
        _videoController.setLooping(true);
        _videoController.play();
        setState(() {});
      }).catchError((error) {
        debugPrint("Video initialization error: $error");
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    // Basic Validation
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    if (!_isLogin && _passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    final authCubit = context.read<AuthCubit>();
    if (_isLogin) {
      authCubit.login(_emailController.text, _passwordController.text);
    } else {
      authCubit.register(_emailController.text, _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go('/');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_isLogin ? 'Welcome back, ${state.email}!' : 'Account created successfully!')),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Video Background
            if (_videoController.value.isInitialized)
              SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: _videoController.value.size.width,
                    height: _videoController.value.size.height,
                    child: VideoPlayer(_videoController),
                  ),
                ),
              )
            else
              Container(color: Colors.black),

            // Overlay
            Container(color: Colors.black.withOpacity(0.5)),

            // Content
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
<<<<<<< HEAD
                      width: 500, // Max width for the "card"
=======
                      width: 900, // Max width for the "card"
>>>>>>> 8cd9e3ab77931b854e8024ae6ecf2185a8288932
                      constraints: const BoxConstraints(minHeight: 500),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(20),
<<<<<<< HEAD
                        border: Border.all(color: Colors.white.withOpacity(0.3)),
                      ),
                      child: Container(
                        width: 500,
                        padding: const EdgeInsets.all(20),
                        child: _buildFormSection(),
=======
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          // Responsive Layout
                          if (constraints.maxWidth > 700) {
                            return Row(
                              children: [
                                Expanded(child: _buildFormSection()),
                                Expanded(child: _buildDecorativeSection()),
                              ],
                            );
                          } else {
                            return _buildFormSection();
                          }
                        },
>>>>>>> 8cd9e3ab77931b854e8024ae6ecf2185a8288932
                      ),
                    ),
                  ),
                ),
              ),
            ),
            
            // Back Button
            Positioned(
              top: 40,
              left: 20,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => context.go('/'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormSection() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dots decoration
          Row(
            children: [
              _buildDot(),
              const SizedBox(width: 4),
              _buildDot(),
              const SizedBox(width: 4),
              _buildDot(),
            ],
          ),
          const SizedBox(height: 40),
          
          Text(
            _isLogin ? 'Sign in' : 'Sign up',
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ).animate().fadeIn().slideX(),
          
          const SizedBox(height: 40),

          _buildTextField(
            controller: _emailController,
            label: 'Your email',
            hint: 'example@email.com',
            icon: Icons.email_outlined,
          ),
          
          const SizedBox(height: 20),
          
          _buildTextField(
            controller: _passwordController,
            label: 'Password',
            hint: '••••••••••••',
            isPassword: true,
          ),

          if (!_isLogin) ...[
            const SizedBox(height: 20),
            _buildTextField(
              controller: _confirmPasswordController,
              label: 'Confirm Password',
              hint: '••••••••••••',
              isPassword: true,
            ),
          ],

          const SizedBox(height: 30),

          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              child: Text(
                _isLogin ? 'Sign in' : 'Sign up',
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          const SizedBox(height: 30),

          Center(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isLogin = !_isLogin;
                });
              },
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.white54),
                  children: [
                    TextSpan(text: _isLogin ? "Don't have an account? " : "Already have an account? "),
                    TextSpan(
                      text: _isLogin ? 'Sign up' : 'Sign in',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    bool isPassword = false,
    IconData? icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: TextField(
            controller: controller,
            obscureText: isPassword && !_isPasswordVisible,
            style: const TextStyle(color: Colors.white),
            onSubmitted: (_) => _submit(), // Enter key submission
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              suffixIcon: isPassword
                  ? IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white54,
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    )
                  : (icon != null ? Icon(icon, color: Colors.white54, size: 20) : null),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDot() {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        shape: BoxShape.circle,
      ),
    );
  }


}
