import 'package:acad/analysis_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ProAcademyApp());
}

class ProAcademyApp extends StatelessWidget {
  const ProAcademyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Academy Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        primaryColor: const Color(0xFF007AFF),
        fontFamily: 'Inter',
        textTheme: const TextTheme(
          displaySmall: TextStyle(color: Color(0xFF111827), fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: Color(0xFF111827), fontWeight: FontWeight.w700),
          titleMedium: TextStyle(color: Color(0xFF111827), fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(color: Color(0xFF111827), fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(color: Color(0xFF6B7280)),
          labelSmall: TextStyle(color: Color(0xFF9CA3AF), fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSessionHeader(context),
            const SizedBox(height: 24),

            _buildBentoStatsGrid(context),
            const SizedBox(height: 24),

            _buildFocalActionCard(context),
            const SizedBox(height: 32),

            _buildSectionTitle(context, 'Player Highlights'),
            _buildStandardListTile(
              context,
              icon: Icons.auto_awesome,
              title: 'Sarah Jenkins leveled up',
              subtitle: 'Batting speed increased by 15%',
              trailingText: '10m ago',
            ),
            const SizedBox(height: 24),

            _buildSectionTitle(context, 'Upcoming Sessions', actionText: 'View Schedule'),
            _buildUpcomingSessionCard(context),
            const SizedBox(height: 24),

            _buildSectionTitle(context, 'Recent Activity'),
            _buildStandardListTile(
              context,
              icon: Icons.feedback_outlined,
              title: 'Feedback submitted',
              subtitle: 'You reviewed David Chen',
              trailingText: 'Yesterday',
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFF007AFF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.sports_cricket, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Text(
            'ACADEMYPRO',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(letterSpacing: 1.0),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Color(0xFF111827)),
          onPressed: () {},
        ),
        const Padding(
          padding: EdgeInsets.only(right: 16.0, left: 8.0),
          child: CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage('https://i.pravatar.cc/100?img=33'), // Mock Profile
          ),
        ),
      ],
    );
  }

  Widget _buildSessionHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Elite U18 Batting', style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 24)),
        const SizedBox(height: 8),
        Row(
          children: [
            const Icon(Icons.schedule, size: 16, color: Color(0xFF6B7280)),
            const SizedBox(width: 6),
            Text('02:30 PM - 04:30 PM', style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(width: 16),
            const Icon(Icons.location_on_outlined, size: 16, color: Color(0xFF6B7280)),
            const SizedBox(width: 6),
            Text('Nets 1-3', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ],
    );
  }

  Widget _buildBentoStatsGrid(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Container(
            height: 140,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> AcademyAnalysisApp()));
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(
                          value: 0.85,
                          strokeWidth: 6,
                          backgroundColor: const Color(0xFFF3F4F6),
                          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF007AFF)),
                        ),
                      ),
                      Text('85%', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text('ATTENDANCE', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 10)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 5,
          child: Container(
            height: 140,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMiniStatRow(context, 'PRESENT', '18', const Color(0xFF111827)),
                _buildMiniStatRow(context, 'ABSENT', '2', const Color(0xFF6B7280)),
                _buildMiniStatRow(context, 'UNMARKED', '4', const Color(0xFFF59E0B)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMiniStatRow(BuildContext context, String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 11)),
        Text(value, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: valueColor, fontSize: 16)),
      ],
    );
  }

  Widget _buildFocalActionCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF007AFF).withOpacity(0.3)), // Subtle blue border
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF007AFF).withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF007AFF).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.assignment_ind_outlined, color: Color(0xFF007AFF)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('3 Pending Reviews', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text('Complete coach feedback', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF007AFF), // High Contrast Focus
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: const Text('Review', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, {String? actionText}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18)),
          if (actionText != null)
            Text(
              actionText,
              style: const TextStyle(color: Color(0xFF007AFF), fontWeight: FontWeight.w600, fontSize: 13),
            ),
        ],
      ),
    );
  }

  Widget _buildStandardListTile(BuildContext context, {required IconData icon, required String title, required String subtitle, required String trailingText}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: const Color(0xFF111827), size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15)),
                const SizedBox(height: 2),
                Text(subtitle, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13)),
              ],
            ),
          ),
          Text(trailingText, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildUpcomingSessionCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF007AFF).withOpacity(0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Text('FEB', style: TextStyle(color: const Color(0xFF007AFF), fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 1.0)),
                Text('24', style: Theme.of(context).textTheme.titleLarge?.copyWith(color: const Color(0xFF007AFF))),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('U16 Fast Bowling', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 15)),
                const SizedBox(height: 4),
                Text('10:00 AM • Main Oval', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 13)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('22', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18)),
              Text('PLAYERS', style: Theme.of(context).textTheme.labelSmall?.copyWith(fontSize: 9)),
            ],
          ),
        ],
      ),
    );
  }
}
