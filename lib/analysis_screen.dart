import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const AcademyAnalysisApp());
}

class AcademyAnalysisApp extends StatelessWidget {
  const AcademyAnalysisApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Academy Analysis',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F7FA), // Modern off-white background
        primaryColor: const Color(0xFF007AFF), // Brand Light Blue
        fontFamily: 'Roboto', // Ideally use 'Inter' or 'SF Pro'
        textTheme: const TextTheme(
          headlineSmall: TextStyle(color: Color(0xFF111827), fontWeight: FontWeight.bold, fontSize: 20),
          titleLarge: TextStyle(color: Color(0xFF111827), fontWeight: FontWeight.bold, fontSize: 18),
          titleMedium: TextStyle(color: Color(0xFF111827), fontWeight: FontWeight.w600, fontSize: 16),
          bodyLarge: TextStyle(color: Color(0xFF111827), fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(color: Color(0xFF6B7280), fontSize: 14),
        ),
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFFE5E7EB), width: 1),
          ),
          color: Colors.white,
          margin: EdgeInsets.zero,
        ),
      ),
      home: const AnalysisScreen(),
    );
  }
}

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({Key? key}) : super(key: key);

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  String _selectedTimeRange = '30 days';
  final List<String> _timeRanges = ['30 days', '60 days', '90 days', 'All Time'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterSection(context),
            const SizedBox(height: 24),
            _buildAcademyOverviewCard(context),
            const SizedBox(height: 24),
            _buildAnalysisSummaryCard(context),
            const SizedBox(height: 32),
            _buildTwoColumnPlayerLists(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: const Icon(Icons.menu, color: Color(0xFF111827)),
      title: Row(
        children: [
          Text(
            'ANALYSIS',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(letterSpacing: 1.2),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none_rounded, color: Color(0xFF111827)),
          onPressed: () {},
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: CircleAvatar(
            radius: 16,
            backgroundColor: Color(0xFFE5E7EB),
            child: Icon(Icons.person, color: Color(0xFF111827), size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _buildTabButton(context, 'Recent', isActive: true),
                const SizedBox(width: 12),
                _buildTabButton(context, 'Month', isActive: false),
              ],
            ),
            OutlinedButton.icon(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF111827),
                side: const BorderSide(color: Color(0xFFE5E7EB)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
              icon: const Icon(Icons.filter_list_rounded, size: 18),
              label: const Text('Filter'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 36,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _timeRanges.length,
            separatorBuilder: (context, index) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final range = _timeRanges[index];
              final isSelected = range == _selectedTimeRange;
              return GestureDetector(
                onTap: () => setState(() => _selectedTimeRange = range),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF007AFF) : Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF007AFF) : const Color(0xFFE5E7EB),
                    ),
                  ),
                  child: Text(
                    range,
                    style: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF6B7280),
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Text('Showing last $_selectedTimeRange', style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }

  Widget _buildTabButton(BuildContext context, String text, {required bool isActive}) {
    return Text(
      text,
      style: TextStyle(
        color: isActive ? const Color(0xFF111827) : const Color(0xFF9CA3AF),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }

  Widget _buildAcademyOverviewCard(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Academy Overview', style: Theme.of(context).textTheme.titleLarge),
                Text('10 players', style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                // Focal Point: The Radar Chart
                Expanded(
                  flex: 3,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: CustomPaint(
                      painter: RadarChartPainter(
                        categories: ['Footwork', 'Timing', 'Shot Selection', 'Balance', 'Impact'],
                        values: [0.7, 0.6, 0.8, 0.5, 0.65], // Mock data (0.0 - 1.0)
                        primaryColor: const Color(0xFF007AFF),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                // Legend/Scores
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('BATTING AVG', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: const Color(0xFF007AFF))),
                      const SizedBox(height: 16),
                      _buildScoreRow(context, 'Footwork', '7.0'),
                      _buildScoreRow(context, 'Timing', '6.0'),
                      _buildScoreRow(context, 'Shot Sel.', '8.0'),
                      _buildScoreRow(context, 'Balance', '5.0'),
                      _buildScoreRow(context, 'Impact', '6.5'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreRow(BuildContext context, String label, String score) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: Theme.of(context).textTheme.bodyMedium),
          Text(score, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }

  Widget _buildAnalysisSummaryCard(BuildContext context) {
    return Card(
      color: const Color(0xFF007AFF).withOpacity(0.05), // Subtle light blue tint
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: const Color(0xFF007AFF).withOpacity(0.2), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.insights_rounded, color: Color(0xFF007AFF)),
                const SizedBox(width: 12),
                Text('Analysis Summary', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            const SizedBox(height: 16),
            _buildBulletPoint(context, 'Batting and fielding standards are stable and remain academy strengths.'),
            _buildBulletPoint(context, 'Bowling consistency is the most visible performance gap in current cycles.'),
            _buildBulletPoint(context, 'Fitness repeat-intensity should be lifted for low-trending player groups.'),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: Icon(Icons.circle, size: 6, color: Color(0xFF007AFF)),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14, height: 1.4))),
        ],
      ),
    );
  }

  Widget _buildTwoColumnPlayerLists(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              _buildSectionHeader(context, 'Top Performers', Icons.emoji_events_rounded, const Color(0xFF007AFF)),
              const SizedBox(height: 16),
              _buildPlayerCard(context, 'Vikram Singh', 'Bowler', '7.5', 'U-16', isTrendingUp: true),
              const SizedBox(height: 16),
              _buildPlayerCard(context, 'Arjun Sharma', 'Batter', '7.2', 'U-14', isTrendingUp: true),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            children: [
              _buildSectionHeader(context, 'Needs Attention', Icons.error_outline_rounded, const Color(0xFFD35400)), // Subtle orange
              const SizedBox(height: 16),
              _buildPlayerCard(context, 'Ananya Kumar', 'Batter', '6.5', 'U-16', isTrendingUp: false),
              const SizedBox(height: 16),
              _buildPlayerCard(context, 'Karan Mehta', 'Batter', '5.9', 'U-19', isTrendingUp: false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 8),
        Text(title, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }

  Widget _buildPlayerCard(
      BuildContext context,
      String name,
      String role,
      String score,
      String ageGroup, {
        required bool isTrendingUp,
      }) {
    final trendColor = isTrendingUp ? const Color(0xFF007AFF) : const Color(0xFFD35400);
    final trendIcon = isTrendingUp ? Icons.trending_up_rounded : Icons.trending_down_rounded;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: const Color(0xFFF3F4F6),
                  child: Icon(Icons.person, color: const Color(0xFF9CA3AF)),
                  // backgroundImage: NetworkImage('...'), // Add images here
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15), overflow: TextOverflow.ellipsis),
                      Text(role, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(score, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontSize: 28, color: const Color(0xFF007AFF))),
                Row(
                  children: [
                    Icon(trendIcon, color: trendColor, size: 18),
                    const SizedBox(width: 4),
                    Text(ageGroup, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RadarChartPainter extends CustomPainter {
  final List<String> categories;
  final List<double> values;
  final Color primaryColor;

  RadarChartPainter({required this.categories, required this.values, required this.primaryColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 * 0.8;
    final paint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    for (int i = 0; i < 5; i++) {
      final r = radius * (i + 1) / 5;
      canvas.drawCircle(center, r, paint);
    }

    final angleStep = 2 * math.pi / categories.length;
    for (int i = 0; i < categories.length; i++) {
      final angle = i * angleStep - math.pi / 2;
      final offset = Offset(center.dx + radius * math.cos(angle), center.dy + radius * math.sin(angle));
      canvas.drawLine(center, offset, paint);
    }

    final dataPath = Path();
    for (int i = 0; i < values.length; i++) {
      final r = radius * values[i];
      final angle = i * angleStep - math.pi / 2;
      final offset = Offset(center.dx + r * math.cos(angle), center.dy + r * math.sin(angle));
      if (i == 0) {
        dataPath.moveTo(offset.dx, offset.dy);
      } else {
        dataPath.lineTo(offset.dx, offset.dy);
      }
    }
    dataPath.close();

    paint.color = primaryColor.withOpacity(0.2);
    paint.style = PaintingStyle.fill;
    canvas.drawPath(dataPath, paint);

    paint.color = primaryColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    canvas.drawPath(dataPath, paint);

    for (int i = 0; i < values.length; i++) {
      final r = radius * values[i];
      final angle = i * angleStep - math.pi / 2;
      final offset = Offset(center.dx + r * math.cos(angle), center.dy + r * math.sin(angle));
      canvas.drawCircle(offset, 4, paint..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}