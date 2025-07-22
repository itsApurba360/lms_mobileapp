import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/result_controller.dart';
import '../widgets/solutions.dart';

const Color backgroundColor = Color.fromARGB(255, 244, 244, 244);

class ResultView extends GetView<ResultController> {
  const ResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text('ResultView'),
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.green,
            unselectedLabelColor: Colors.black,
            indicatorColor: Colors.green,
            tabs: [
              Tab(text: 'Analysis'),
              Tab(text: 'Solutions'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _AnalysisTab(),
            Solutions(),
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
                DefaultTabController.of(context).animateTo(1);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                elevation: 0,
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

          const SizedBox(height: 16),

          const Text(
            'Sectional Summary',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // Pills
          SizedBox(
            height: 36,
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
                      color: isSelected ? Colors.green : Colors.grey.shade300,
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
                fontWeight: FontWeight.w500,
                color: Colors.black)),
        const SizedBox(height: 0),
        Text(label,
            style: const TextStyle(fontSize: 14, color: Colors.black54)),
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
            height: 36,
            width: 36,
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.green, size: 20),
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
          const SizedBox(height: 5),
          const Text('30/100',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
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
              Text(label,
                  style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w400)),
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
            borderRadius: BorderRadius.circular(12),
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
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 24),
          _MetricRow(
            icon: Icons.emoji_events_outlined,
            iconColor: Colors.purple,
            label: 'Score',
            valueText: '5 / 26',
            progress: 5 / 26,
            progressColor: Colors.purple,
          ),
          const SizedBox(height: 20),
          _MetricRow(
            icon: Icons.bolt_outlined,
            iconColor: Colors.green,
            label: 'Accuracy',
            valueText: '23.1%',
            progress: 0.231,
            progressColor: Colors.green,
          ),
          const SizedBox(height: 20),
          _MetricRow(
            icon: Icons.timer_outlined,
            iconColor: Colors.orange,
            label: 'Time',
            valueText: '0.3 min / 30 min',
            progress: 0.3 / 30,
            progressColor: Colors.orange,
          ),
        ],
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String valueText;
  final double progress;
  final Color progressColor;

  const _MetricRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.valueText,
    required this.progress,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              valueText,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 6,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(3),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: progressColor,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
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
