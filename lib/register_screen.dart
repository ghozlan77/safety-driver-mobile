
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();

  bool _hidePassword = true;
  bool _hideConfirmPassword = true;

  static const navy = Color(0xFF101A2B);
  static const teal = Color(0xFF18A582);
  static const orange = Color(0xFFF2A65A);
  static const fieldColor = Color(0xFF1C2D43);
  static const muted = Color(0xFF9BB4C9);

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  InputDecoration _inputDecoration(
    String hint,
    IconData icon, {
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: muted),
      prefixIcon: Icon(icon, color: muted),
      suffixIcon: suffix,
      filled: true,
      fillColor: fieldColor,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: Color(0xFF34475B),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(
          color: teal,
          width: 1.5,
        ),
      ),
      errorMaxLines: 2,
    );
  }

  Widget _fieldLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navy,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 24,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFF1C414B),
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: const Color(0xFF326977),
                          ),
                        ),
                        child: const Icon(
                          Icons.verified_user_outlined,
                          color: Color(0xFF78DFC6),
                          size: 43,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    const Center(
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 9),

                    const Center(
                      child: Text(
                        'Join Safety Driver for a safer journey.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: muted,
                          fontSize: 14,
                        ),
                      ),
                    ),

                    const SizedBox(height: 34),

                    _fieldLabel('Full Name'),

                    TextFormField(
                      textCapitalization:
                          TextCapitalization.words,
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration(
                        'Enter your full name',
                        Icons.person_outline_rounded,
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 22),

                    _fieldLabel('Email Address'),

                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration(
                        'Enter your email',
                        Icons.mail_outline_rounded,
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                          r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
                        ).hasMatch(value.trim())) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 22),

                    _fieldLabel('Password'),

                    TextFormField(
                      controller: _passwordController,
                      obscureText: _hidePassword,
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration(
                        'Create a password',
                        Icons.lock_outline_rounded,
                        suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              _hidePassword = !_hidePassword;
                            });
                          },
                          icon: Icon(
                            _hidePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: muted,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 8) {
                          return 'Use at least 8 characters';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 22),

                    _fieldLabel('Confirm Password'),

                    TextFormField(
                      obscureText: _hideConfirmPassword,
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration(
                        'Confirm your password',
                        Icons.lock_reset_outlined,
                        suffix: IconButton(
                          onPressed: () {
                            setState(() {
                              _hideConfirmPassword =
                                  !_hideConfirmPassword;
                            });
                          },
                          icon: Icon(
                            _hideConfirmPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: muted,
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      height: 57,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Register UI ready. '
                                  'Backend integration pending.',
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: teal,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 22),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Flexible(
                          child: Text(
                            'Already have an account?',
                            style: TextStyle(color: muted),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
