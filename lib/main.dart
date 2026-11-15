
import 'package:flutter/material.dart';

void main() {
  runApp(const SafetyDriverApp());
}

class SafetyDriverApp extends StatelessWidget {
  const SafetyDriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const Color navy = Color(0xFF101A2B);
  static const Color mint = Color(0xFF18A582);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD8E1E8),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;

          return Center(
            child: Container(
              width: isWide ? 500 : double.infinity,
              height: isWide ? 640 : constraints.maxHeight,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF172940),
                    navy,
                  ],
                ),
                borderRadius:
                    BorderRadius.circular(isWide ? 34 : 0),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 42,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: _buildWelcomeContent(),
                        ),
                      ),

                      // Get started button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Next screen will be added soon',
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mint,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(15),
                            ),
                          ),
                          child: const Row(
                            mainAxisAlignment:
                                MainAxisAlignment.center,
                            children: [
                              Text(
                                'Get started',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 12),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 17),

                      const Text(
                        'AI-powered in-cabin safety monitoring',
                        style: TextStyle(
                          color: Color(0xFF91A8C0),
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWelcomeContent() {
    return SizedBox(
      height: 340,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Decorative circles
          _circle(310),
          _circle(235),
          _circle(155),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 105,
                height: 105,
                decoration: BoxDecoration(
                  color: const Color(0xFF1C414B),
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(
                    color: const Color(0xFF326977),
                  ),
                ),
                child: const Icon(
                  Icons.verified_user_outlined,
                  color: Color(0xFF78DFC6),
                  size: 51,
                ),
              ),

              const SizedBox(height: 27),

              const Text(
                'Safety Driver',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Intelligent in-cabin protection\n'
                'for every person on board.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF91BDD8),
                  height: 1.6,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 29),

              const Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                runSpacing: 8,
                children: [
                  _InfoChip(
                    icon: Icons.visibility_outlined,
                    title: 'Driver',
                  ),
                  _InfoChip(
                    icon: Icons.people_outline,
                    title: 'Passengers',
                  ),
                  _InfoChip(
                    icon: Icons.monitor_heart_outlined,
                    title: 'Real time',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circle(double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0x1838BCA9),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String title;

  const _InfoChip({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF203149),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF34455B),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: const Color(0xFF65D8C1),
            size: 16,
          ),
          const SizedBox(width: 6),
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFFAFCAE0),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
