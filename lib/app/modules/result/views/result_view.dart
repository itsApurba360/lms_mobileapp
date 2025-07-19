import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/result_controller.dart';

class ResultView extends GetView<ResultController> {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ResultView'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Analysis'),
              Tab(text: 'Solutions'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _AnalysisTab(),
            Center(child: Text('Solutions Tab')),
          ],
        ),
      ),
    );
  }
}

class _AnalysisTab extends StatelessWidget {
  const _AnalysisTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // 🎯 First Card: Rank & Image
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.green.shade300),
            ),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: 0.6,
                    alignment: Alignment.centerLeft,
                    child: Opacity(
                      opacity: 0.2,
                      child: Image.asset(
                        'assets/images/medal.png',
                        width: 180,
                        height: 180,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Your Rank',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Text(
                            '479',
                            style: TextStyle(
                                fontSize: 28, fontWeight: FontWeight.bold),
                          ),
                          const Text('/514', style: TextStyle(fontSize: 18)),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'NEED TO IMPROVE',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        '514 Participants',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // 📊 Second Card: Stats Layout
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.green.shade300),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Correct / Wrong / Skipped with dividers + padding
                Row(
                  children: [
                    const SizedBox(width: 12),
                    const Expanded(
                        child: _TopStatItem(label: 'Correct', value: '7')),
                    _VerticalDivider(),
                    const Expanded(
                        child: _TopStatItem(label: 'Wrong', value: '28')),
                    _VerticalDivider(),
                    const Expanded(
                        child: _TopStatItem(label: 'Skipped', value: '15')),
                    const SizedBox(width: 12),
                  ],
                ),
                const Divider(height: 20, thickness: 0.3),
                // Bottom Stats
                Row(
                  children: const [
                    _StatItem(
                        icon: Icons.psychology, label: 'Attempts', value: '35'),
                    _StatItem(
                        icon: Icons.assignment,
                        label: 'Marks',
                        value: '100/100.0'),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: const [
                    _StatItem(
                        icon: Icons.track_changes,
                        label: 'Accuracy',
                        value: '20%'),
                    _StatItem(
                        icon: Icons.timer, label: 'Speed', value: '51 Q/Min'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ✅ Top row: Correct / Wrong / Skipped
class _TopStatItem extends StatelessWidget {
  final String label;
  final String value;

  const _TopStatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}

// ✅ 1px vertical line
class _VerticalDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey.shade300,
    );
  }
}

// ✅ Bottom stats with icons
class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.green, size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      color: Color.fromARGB(255, 129, 129, 129), fontSize: 14)),
              Text(value,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}
