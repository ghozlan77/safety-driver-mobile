import 'package:flutter/material.dart';

enum DemoScenario { safe, warning, critical, off }

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  static const navy = Color(0xFF101A2B);
  static const teal = Color(0xFF18A582);
  static const orange = Color(0xFFF2A65A);
  static const red = Color(0xFFE75F56);
  static const muted = Color(0xFF718096);
  static const background = Color(0xFFF3F6F8);

  DemoScenario _scenario = DemoScenario.safe;

  void _notReady(String feature) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$feature is not connected yet (demo UI).')),
    );
  }

  _ScenarioData get _data {
    switch (_scenario) {
      case DemoScenario.safe:
        return const _ScenarioData(
          title: 'Cabin status stable',
          description: 'No simulated safety event is active.',
          statusLabel: 'SAFE',
          icon: Icons.shield_outlined,
          color: teal,
          eyeValue: 'Normal',
          eyeTag: 'Safe',
          drowsinessValue: 'Low',
          drowsinessTag: 'Safe',
          occupantsValue: '3',
          occupantsTag: 'Detected',
        );
      case DemoScenario.warning:
        return const _ScenarioData(
          title: 'Driver needs attention',
          description: 'A simulated warning requires attention.',
          statusLabel: 'WARNING',
          icon: Icons.warning_amber_rounded,
          color: orange,
          eyeValue: '3.8 sec',
          eyeTag: 'High',
          drowsinessValue: 'Medium',
          drowsinessTag: 'Watch',
          occupantsValue: '3',
          occupantsTag: 'Detected',
          alertTitle: 'Prolonged eye closure',
          alertDescription: 'Simulated warning - eyes closed for 3.8 seconds',
        );
      case DemoScenario.critical:
        return const _ScenarioData(
          title: 'Critical driver warning',
          description: 'A simulated critical event requires attention.',
          statusLabel: 'CRITICAL',
          icon: Icons.report_problem_outlined,
          color: red,
          eyeValue: '5.2 sec',
          eyeTag: 'Critical',
          drowsinessValue: 'High',
          drowsinessTag: 'Critical',
          occupantsValue: '3',
          occupantsTag: 'Detected',
          alertTitle: 'Critical eye-closure event',
          alertDescription: 'Simulated critical event - 5.2 seconds',
        );
      case DemoScenario.off:
        return const _ScenarioData(
          title: 'Monitoring not active',
          description: 'No monitoring signals are available.',
          statusLabel: 'OFF',
          icon: Icons.videocam_off_outlined,
          color: muted,
          eyeValue: 'N/A',
          eyeTag: 'Off',
          drowsinessValue: 'N/A',
          drowsinessTag: 'Off',
          occupantsValue: 'N/A',
          occupantsTag: 'Off',
        );
    }
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Text(
        title,
        style: const TextStyle(
          color: navy,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildStatusCard(_ScenarioData data) {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1B3047), navy],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.circle, color: teal, size: 9),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'SAFETY OVERVIEW',
                  style: TextStyle(
                    color: Color(0xFF78DFC6),
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    letterSpacing: 1,
                  ),
                ),
              ),
              Text(
                'DEMO - NOT LIVE',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.72),
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 23),
          Row(
            children: [
              Icon(data.icon, color: data.color, size: 34),
              const SizedBox(width: 12),
              Text(
                data.statusLabel,
                style: TextStyle(
                  color: data.color,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.2,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            data.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            data.description,
            style: const TextStyle(
              color: Color(0xFFB9CAD8),
              fontSize: 13,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          const Divider(color: Color(0xFF3C4C60)),
          const SizedBox(height: 11),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _notReady('Live Monitoring'),
              icon: const Icon(Icons.videocam_outlined),
              label: const Text('Open Live Monitoring'),
              style: ElevatedButton.styleFrom(
                backgroundColor: teal,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignals(_ScenarioData data) {
    final cards = [
      _SignalCard(
        icon: Icons.remove_red_eye_outlined,
        title: 'Eye closure',
        value: data.eyeValue,
        tag: data.eyeTag,
        color: data.color,
      ),
      _SignalCard(
        icon: Icons.bedtime_outlined,
        title: 'Drowsiness',
        value: data.drowsinessValue,
        tag: data.drowsinessTag,
        color: data.color,
      ),
      _SignalCard(
        icon: Icons.people_outline,
        title: 'Occupants',
        value: data.occupantsValue,
        tag: data.occupantsTag,
        color: _scenario == DemoScenario.off ? muted : teal,
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth < 360 ? 2 : 3;
        final width = (constraints.maxWidth - (columns - 1) * 10) / columns;
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: cards
              .map((card) => SizedBox(width: width, child: card))
              .toList(),
        );
      },
    );
  }

  Widget _buildRecentAlert(_ScenarioData data) {
    final hasAlert = data.alertTitle != null;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: hasAlert ? () => _notReady('Alerts') : null,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: hasAlert ? const Color(0xFFFFF0E9) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasAlert
                ? const Color(0xFFFFD8C9)
                : const Color(0xFFE3E9EE),
          ),
        ),
        child: Row(
          children: [
            Icon(
              hasAlert ? Icons.error_outline : Icons.check_circle_outline,
              size: 25,
              color: hasAlert ? red : teal,
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.alertTitle ?? 'No alerts in this demo scenario',
                    style: const TextStyle(
                      color: navy,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    data.alertDescription ??
                        'This is a preview, not real alert history.',
                    style: const TextStyle(color: muted, fontSize: 12),
                  ),
                ],
              ),
            ),
            if (hasAlert) const Icon(Icons.chevron_right, color: navy),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3E9EE)),
      ),
      child: const Row(
        children: [
          Icon(Icons.videocam_off_outlined, color: muted, size: 26),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Demo preview only',
                  style: TextStyle(color: navy, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  'No live camera or AI connection yet',
                  style: TextStyle(color: muted, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = _data;
    return Scaffold(
      backgroundColor: background,
      bottomNavigationBar: Container(
        color: Colors.white,
        child: SafeArea(
          top: false,
          child: Center(
            heightFactor: 1,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: NavigationBar(
                height: 72,
                selectedIndex: 0,
                backgroundColor: Colors.white,
                indicatorColor: const Color(0xFFE1F5EE),
                onDestinationSelected: (index) {
                  if (index == 1) _notReady('Live Monitoring');
                  if (index == 2) _notReady('Alerts');
                  if (index == 3) _notReady('More');
                },
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home, color: teal),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.videocam_outlined),
                    label: 'Live',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.notifications_outlined),
                    label: 'Alerts',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.more_horiz),
                    label: 'More',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: ListView(
              padding: const EdgeInsets.all(22),
              children: [
                Row(
                  children: [
                    Container(
                      width: 47,
                      height: 47,
                      decoration: BoxDecoration(
                        color: navy,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.verified_user_outlined,
                        color: Color(0xFF78DFC6),
                        size: 27,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'SAFETY DRIVER',
                            style: TextStyle(
                              color: navy,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            'Driver Dashboard',
                            style: TextStyle(color: muted, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () => _notReady('Notifications'),
                      icon: const Icon(
                        Icons.notifications_outlined,
                        color: navy,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Welcome back',
                  style: TextStyle(color: muted, fontSize: 14),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Your safety overview',
                  style: TextStyle(
                    color: navy,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 19),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(color: const Color(0xFFE3E9EE)),
                  ),
                  child: Row(
                    children: [
                      const Text(
                        'Demo scenario',
                        style: TextStyle(
                          color: navy,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: DropdownButton<DemoScenario>(
                          value: _scenario,
                          isExpanded: true,
                          underline: const SizedBox.shrink(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => _scenario = value);
                            }
                          },
                          items: const [
                            DropdownMenuItem(
                              value: DemoScenario.safe,
                              child: Text('Safe'),
                            ),
                            DropdownMenuItem(
                              value: DemoScenario.warning,
                              child: Text('Warning'),
                            ),
                            DropdownMenuItem(
                              value: DemoScenario.critical,
                              child: Text('Critical'),
                            ),
                            DropdownMenuItem(
                              value: DemoScenario.off,
                              child: Text('Monitoring off'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                _buildStatusCard(data),
                const SizedBox(height: 26),
                _sectionTitle('Current Signals'),
                _buildSignals(data),
                const SizedBox(height: 26),
                _sectionTitle('Recent Alert'),
                _buildRecentAlert(data),
                const SizedBox(height: 26),
                _sectionTitle('Monitoring Session'),
                _buildSessionCard(),
                const SizedBox(height: 26),
                _sectionTitle('Quick Access'),
                Row(
                  children: [
                    Expanded(
                      child: _QuickAction(
                        icon: Icons.history,
                        label: 'History',
                        onTap: () => _notReady('Event History'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _QuickAction(
                        icon: Icons.bar_chart_rounded,
                        label: 'Reports',
                        onTap: () => _notReady('Reports'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _QuickAction(
                        icon: Icons.memory_outlined,
                        label: 'Hardware',
                        onTap: () => _notReady('Hardware'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ScenarioData {
  final String title;
  final String description;
  final String statusLabel;
  final IconData icon;
  final Color color;
  final String eyeValue;
  final String eyeTag;
  final String drowsinessValue;
  final String drowsinessTag;
  final String occupantsValue;
  final String occupantsTag;
  final String? alertTitle;
  final String? alertDescription;

  const _ScenarioData({
    required this.title,
    required this.description,
    required this.statusLabel,
    required this.icon,
    required this.color,
    required this.eyeValue,
    required this.eyeTag,
    required this.drowsinessValue,
    required this.drowsinessTag,
    required this.occupantsValue,
    required this.occupantsTag,
    this.alertTitle,
    this.alertDescription,
  });
}

class _SignalCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String tag;
  final Color color;

  const _SignalCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.tag,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE3E9EE)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 23),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(color: Color(0xFF718096), fontSize: 11),
          ),
          const SizedBox(height: 7),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Color(0xFF101A2B),
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            tag,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFE3E9EE)),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF18A582), size: 26),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF101A2B),
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
