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

class _AnalysisTab extends StatefulWidget {
  const _AnalysisTab();

  @override
  State<_AnalysisTab> createState() => _AnalysisTabState();
}

class _AnalysisTabState extends State<_AnalysisTab> {
  int selectedPill = 0;

  final List<String> pillLabels = [
    'Score',
    'Section 1',
    'Section 2',
    'Section 3',
    'Section 4',
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRankCard(),
          const SizedBox(height: 20),
          _buildStatsCard(),
          const SizedBox(height: 16),

          // View Solutions Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                // Handle View Solutions tap
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'View Solutions',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Sectional Summary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // Pills
          SizedBox(
            height: 40,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: pillLabels.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (context, index) {
                final isSelected = index == selectedPill;
                return GestureDetector(
                  onTap: () => setState(() => selectedPill = index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      pillLabels[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // Dynamic Section Content
          selectedPill == 0
              ? const _ScoreSectionCard()
              : _SectionAnalysisCard(title: pillLabels[selectedPill]),
        ],
      ),
    );
  }

  Widget _buildRankCard() {
    return Container(
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Text(
                      '479',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
    );
  }

  Widget _buildStatsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green.shade300),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              SizedBox(width: 12),
              Expanded(child: _TopStatItem(label: 'Correct', value: '7')),
              _VerticalDivider(),
              Expanded(child: _TopStatItem(label: 'Wrong', value: '28')),
              _VerticalDivider(),
              Expanded(child: _TopStatItem(label: 'Skipped', value: '15')),
              SizedBox(width: 12),
            ],
          ),
          const Divider(height: 20, thickness: 0.3),
          Row(
            children: const [
              _StatItem(icon: Icons.psychology, label: 'Attempts', value: '35'),
              _StatItem(
                  icon: Icons.assignment, label: 'Marks', value: '100/100.0'),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              _StatItem(
                  icon: Icons.track_changes, label: 'Accuracy', value: '20%'),
              _StatItem(icon: Icons.timer, label: 'Speed', value: '51 Q/Min'),
            ],
          ),
        ],
      ),
    );
  }
}

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

class _VerticalDivider extends StatelessWidget {
  const _VerticalDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey.shade300,
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatItem(
      {required this.icon, required this.label, required this.value});

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

class _ScoreSectionCard extends StatelessWidget {
  const _ScoreSectionCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Row(
                children: [
                  Icon(Icons.emoji_events, color: Colors.green),
                  SizedBox(width: 8),
                  Text('Score',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text('0/100',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          _buildSectionRow(
              label: 'General Intelligence', value: '1/26', progress: 1 / 26),
          _buildSectionRow(
              label: 'General Awareness', value: '1.5/26', progress: 1.5 / 26),
          _buildSectionRow(
              label: 'Quantitative Aptitude', value: '0/24', progress: 0),
          _buildSectionRow(
              label: 'English Language',
              value: '-2.5/24',
              progress: 0,
              progressColor: Colors.pinkAccent,
              valueColor: Colors.red),
        ],
      ),
    );
  }

  Widget _buildSectionRow({
    required String label,
    required String value,
    required double progress,
    Color progressColor = Colors.green,
    Color valueColor = Colors.black,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: const TextStyle(fontSize: 14)),
              Text(value,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: valueColor)),
            ],
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: 6,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          ),
        ],
      ),
    );
  }
}

class _SectionAnalysisCard extends StatelessWidget {
  final String title;

  const _SectionAnalysisCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.insights, color: Colors.green),
              const SizedBox(width: 8),
              Text(
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text('Score: 1/26',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Text('Accuracy: 23.1%',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
          const SizedBox(height: 6),
          const Text('Time: 0.3 min',
              style: TextStyle(fontSize: 16, color: Colors.black87)),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              _AttemptStat(label: 'Correct', count: 3, color: Colors.green),
              _AttemptStat(label: 'Incorrect', count: 10, color: Colors.red),
              _AttemptStat(label: 'Unattempted', count: 0, color: Colors.grey),
            ],
          ),
        ],
      ),
    );
  }
}

class _AttemptStat extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const _AttemptStat(
      {required this.label, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(Icons.circle, size: 16, color: color),
        const SizedBox(height: 4),
        Text(label,
            style: const TextStyle(fontSize: 12, color: Colors.black54)),
        Text('$count',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
