import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HealthAnalyticsScreen extends StatefulWidget {
  const HealthAnalyticsScreen({super.key});

  @override
  State<HealthAnalyticsScreen> createState() => _HealthAnalyticsScreenState();
}

class _HealthAnalyticsScreenState extends State<HealthAnalyticsScreen> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // Slightly lighter background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.show_chart, color: Colors.blueAccent),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Health Analytics',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                    softWrap: true,
                    maxLines: 1, // Limit title to one line for cleaner look
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Medical Prevention Group, Inc',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/images/transparent_default_user.png'), // Make sure this asset exists
              backgroundColor: Colors.blueAccent, // Fallback if image not found
              child: Icon(Icons.person, color: Colors.white), // Fallback icon
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0), // Increased vertical padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Harmony Score Trends',
                    'AI converts medical reports into actionable prevention scores.'),
                const SizedBox(height: 12), // Added spacing
                _buildHarmonyScoreOverTimeCard(),
                const SizedBox(height: 32), // Increased spacing between sections
                _buildSectionTitle('Medical Reports Summary',
                    'Analytics reports auto-triggers alerts linked to disease severities.'),
                const SizedBox(height: 12), // Added spacing
                _buildTotalReportsUploadedCard(),
                const SizedBox(height: 20), // Spacing between cards
                _buildNormalVsAbnormalReportsCard(),
                const SizedBox(height: 20), // Spacing between cards
                _buildDetailedBreakdownCard(),
                const SizedBox(height: 32), // Increased spacing between sections
                _buildSectionTitle('Patients Engagement Analytics',
                    'Monitor patient-doctor consistency.'),
                const SizedBox(height: 12), // Added spacing
                _buildPatientEngagementOverviewCard(),
                const SizedBox(height: 20), // Spacing between cards
                _buildActivePatientsSummary(),
                const SizedBox(height: 20), // Added bottom padding
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   selectedItemColor: Colors.blueAccent,
      //   unselectedItemColor: Colors.grey,
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.local_hospital),
      //       label: 'Emergency',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.calendar_today),
      //       label: 'Leave',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Profile',
      //     ),
      //   ],
      // ),
    );
  }

  Widget _buildSectionTitle(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
        ),
        const SizedBox(height: 6), // Slightly more space
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        // Removed bottom SizedBox here, moved to parent Column
      ],
    );
  }

  Widget _buildHarmonyScoreOverTimeCard() {
    return Card(
      elevation: 2, // Added a subtle elevation
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), // More rounded corners
      child: Padding(
        padding: const EdgeInsets.all(20.0), // Increased padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Harmony Score Over Time',
              style: Theme.of(context).textTheme.titleLarge?.copyWith( // Slightly larger title
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 8), // More space
            Row(
              children: [
                const Icon(Icons.info_outline, size: 18, color: Colors.blue), // Slightly larger icon
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'The rising score indicates better prevention status',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                    softWrap: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // More space
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6), // Slightly larger padding
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(10), // More rounded
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.arrow_upward,
                        size: 18, color: Colors.green), // Slightly larger icon
                    const SizedBox(width: 4),
                    Text(
                      '+12 points',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith( // Slightly larger text
                            color: Colors.green[700],
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      ' this month',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith( // Slightly larger text
                            color: Colors.green[700],
                          ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18), // More space
            ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: 150, // Slightly increased min height
                maxHeight: 250,
              ),
              child: SizedBox(
                height: 200,
                child: LineChart(
                  LineChartData(
                    gridData: FlGridData(
                      show: true,
                      drawHorizontalLine: true,
                      drawVerticalLine: false, // Removed vertical lines for a cleaner look
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: Colors.grey[200]!,
                        strokeWidth: 1,
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      bottomTitles: AxisTitles( // Added bottom titles for months
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          interval: 1,
                          getTitlesWidget: (value, meta) {
                            const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'];
                            if (value.toInt() >= 0 && value.toInt() < months.length) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(months[value.toInt()], style: Theme.of(context).textTheme.bodySmall),
                              );
                            }
                            return const Text('');
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            String text;
                            switch (value.toInt()) {
                              case 25:
                                text = '25';
                                break;
                              case 50:
                                text = '50';
                                break;
                              case 75:
                                text = '75';
                                break;
                              case 100:
                                text = '100';
                                break;
                              default:
                                text = '';
                                break;
                            }
                            return Text(text,
                                style: Theme.of(context).textTheme.bodySmall,
                                textAlign: TextAlign.left);
                          },
                          reservedSize: 32, // Increased reserved size for left titles
                          interval: 25,
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(color: Colors.grey[200]!, width: 1),
                    ),
                    minX: 0,
                    maxX: 6,
                    minY: 0,
                    maxY: 100,
                    lineBarsData: [
                      LineChartBarData(
                        spots: const [
                          FlSpot(0, 40),
                          FlSpot(1, 45),
                          FlSpot(2, 55),
                          FlSpot(3, 60),
                          FlSpot(4, 70),
                          FlSpot(5, 72),
                          FlSpot(6, 84),
                        ],
                        isCurved: true,
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.withOpacity(0.5),
                            Colors.blueAccent,
                          ],
                        ),
                        barWidth: 4, // Slightly thicker line
                        isStrokeCapRound: true,
                        dotData: FlDotData( // Custom dots
                          show: true,
                          getDotPainter: (spot, percent, barData, index) {
                            return FlDotCirclePainter(
                              radius: 4,
                              color: Colors.blueAccent,
                              strokeWidth: 1,
                              strokeColor: Colors.white,
                            );
                          },
                        ),
                        belowBarData: BarAreaData(
                          show: true,
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.withOpacity(0.1), // Subtle fill below the line
                              Colors.blueAccent.withOpacity(0.0),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20), // More space
            Wrap(
              spacing: 16,
              runSpacing: 10, // Increased run spacing
              children: [
                _buildLegendItem('Excellent (80+)', Colors.green),
                _buildLegendItem('Good (70-79)', Colors.orange),
                _buildLegendItem('Medium Risk (60-69)', Colors.red),
                _buildLegendItem('Medical Attention (0-59)', Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 180), // Increased max width for better readability
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 12, // Slightly larger color indicator
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3), // Slightly more rounded
            ),
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[700],
                  ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalReportsUploadedCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.description, color: Colors.blueAccent, size: 24), // Larger icon
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Total Reports Uploaded',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                    softWrap: true,
                  ),
                ),
                Container( // Wrapped dropdown in a container for consistent padding
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'This month',
                        style:
                            Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w500,
                                ),
                        softWrap: true,
                      ),
                      const Icon(Icons.keyboard_arrow_down, color: Colors.grey, size: 20),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // More space
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded( // Use Expanded instead of Flexible with flex: 1
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '32',
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith( // Larger number
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Total Reports',
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith( // Slightly larger text
                                  color: Colors.grey[600],
                                ),
                      ),
                    ],
                  ),
                ),
                // Removed SizedBox width: 16, let Expanded handle spacing
                Expanded( // Use Expanded instead of Flexible with flex: 1
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '12',
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith( // Larger number
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.arrow_downward,
                              color: Colors.red, size: 20), // Larger icon
                          const SizedBox(width: 4),
                          Expanded( // Wrapped in Expanded to prevent overflow
                            child: Text(
                              '<7 from last month',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium // Slightly larger text
                                  ?.copyWith(
                                    color: Colors.red,
                                  ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
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

  /// ✅ FIXED PIE CHART OVERLAP ISSUE
  Widget _buildNormalVsAbnormalReportsCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Normal vs Abnormal Reports',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 20),
            LayoutBuilder(builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 360; // Adjust breakpoint if needed
              if (isNarrow) {
                return Column(
                  children: [
                    SizedBox(
                      width: 180, // Slightly larger pie chart for narrow views
                      height: 180,
                      child: PieChart(
                        PieChartData(
                          pieTouchData: PieTouchData(
                            touchCallback:
                                (FlTouchEvent event, pieTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    pieTouchResponse == null ||
                                    pieTouchResponse.touchedSection == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex = pieTouchResponse
                                    .touchedSection!.touchedSectionIndex;
                              });
                            },
                          ),
                          borderData: FlBorderData(show: false),
                          sectionsSpace: 3, // Increased sections space
                          centerSpaceRadius: 50, // Larger center space
                          sections: showingSections(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20), // More space
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildReportStatusItem('Normal', 7, Colors.green),
                        const SizedBox(height: 12), // More space between items
                        _buildReportStatusItem('Abnormal', 3, Colors.red),
                      ],
                    ),
                  ],
                );
              } else {
                return Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 200, // Slightly taller for wider views
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(
                              touchCallback:
                                  (FlTouchEvent event, pieTouchResponse) {
                                setState(() {
                                  if (!event.isInterestedForInteractions ||
                                      pieTouchResponse == null ||
                                      pieTouchResponse.touchedSection == null) {
                                    touchedIndex = -1;
                                    return;
                                  }
                                  touchedIndex = pieTouchResponse
                                      .touchedSection!.touchedSectionIndex;
                                });
                              },
                            ),
                            borderData: FlBorderData(show: false),
                            sectionsSpace: 3, // Increased sections space
                            centerSpaceRadius: 60, // Larger center space
                            sections: showingSections(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 32), // More space
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildReportStatusItem('Normal', 7, Colors.green),
                          const SizedBox(height: 12), // More space between items
                          _buildReportStatusItem('Abnormal', 3, Colors.red),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 22.0 : 18.0; // Larger font size for labels
      final radius = isTouched ? 70.0 : 60.0; // Larger radius for sections
      const shadows = [Shadow(color: Colors.black38, blurRadius: 3)]; // More prominent shadow

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.greenAccent[700],
            value: 70,
            title: '67%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.redAccent,
            value: 30,
            title: '33%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }

  Widget _buildReportStatusItem(String status, int count, Color color) {
    return Row(
      children: [
        Container(
          width: 12, // Slightly larger indicator
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            status,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith( // Slightly larger text
                  color: Colors.black87,
                ),
            softWrap: true,
          ),
        ),
        Text(
          count.toString(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith( // Larger count
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
        ),
      ],
    );
  }

  Widget _buildDetailedBreakdownCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Detailed Breakdown',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 20),
            _buildBreakdownItem('Glucose High', 4, Colors.red),
            _buildBreakdownItem('Cholesterol High', 2, Colors.red),
            _buildBreakdownItem('BP Normal', 7, Colors.green),
            const SizedBox(height: 20), // More space
            Container(
              padding: const EdgeInsets.all(16), // Increased padding
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(12), // More rounded
                border: Border.all(color: Colors.orange[200]!), // Subtle border
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded,
                      color: Colors.orange[700], size: 24), // Larger icon
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Auto alerts triggered for abnormal values',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith( // Slightly larger text
                            color: Colors.orange[800], // Darker orange for better contrast
                            fontWeight: FontWeight.w500,
                          ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBreakdownItem(String metric, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0), // Increased vertical padding
      child: Row(
        children: [
          Container(
            width: 12, // Slightly larger indicator
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              metric,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith( // Slightly larger text
                    color: Colors.black87,
                  ),
              softWrap: true,
            ),
          ),
          Text(
            count.toString(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith( // Larger count
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientEngagementOverviewCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Patient Engagement Overview',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 6),
            Text(
              'Total no. of patients involved in tasks completed',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8), // Increased padding
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(10), // More rounded
                  border: Border.all(color: Colors.blue[200]!),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Top 5 Active Users',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith( // Slightly larger text
                            color: Colors.blue[700],
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.arrow_forward_ios,
                        size: 16, color: Colors.blue), // Slightly larger icon
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildPatientEngagementRow(
              'Sarah Abraham',
              'Female, 32',
              'Score: 90',
              '6 reports',
              '12 tasks completed',
            ),
            const Divider(height: 36, thickness: 1.0, color: Colors.grey), // Thicker divider
            _buildPatientEngagementRow(
              'Michael Brown',
              'Male, 45',
              'Score: 78',
              '6 reports',
              '10 tasks completed',
              isWarning: true,
            ),
            const Divider(height: 36, thickness: 1.0, color: Colors.grey),
             _buildPatientEngagementRow(
              'Emily Johnson',
              'Female, 28',
              'Score: 85',
              '4 reports',
              '8 tasks completed',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientEngagementRow(
      String name, String details, String score, String reports, String tasks,
      {bool isWarning = false}) {
    return Column(
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 24, // Larger avatar
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.person, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 16), // More space
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith( // Larger name
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                    softWrap: true,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    details,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith( // Slightly larger text
                          color: Colors.grey[600],
                        ),
                    softWrap: true,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), // Increased padding
              decoration: BoxDecoration(
                color: isWarning ? Colors.red[100] : Colors.green[100],
                borderRadius: BorderRadius.circular(10), // More rounded
              ),
              child: Text(
                score,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith( // Slightly larger text
                      color: isWarning ? Colors.red[700] : Colors.green[700],
                      fontWeight: FontWeight.bold,
                    ),
                softWrap: true,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12), // More space
        Row(
          children: [
            const SizedBox(width: 64), // Aligned with text
            Expanded( // Use Expanded for better layout control
              child: Row(
                children: [
                  Flexible(
                    child: _buildInfoChip(
                        reports, Colors.blue[100]!, Colors.blue[700]!),
                  ),
                  const SizedBox(width: 10), // More space between chips
                  Flexible(
                    child: _buildInfoChip(
                        tasks, Colors.green[100]!, Colors.green[700]!),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoChip(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), // Increased padding
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8), // More rounded
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600, // Slightly bolder
            ),
        softWrap: true,
      ),
    );
  }

  Widget _buildActivePatientsSummary() {
    return Card( // Wrapped in Card for consistent styling
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0), // Increased vertical padding
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildSummaryColumn('32', 'Active Patients'),
            _buildSummaryColumn('89%', 'Task Completion'),
            _buildSummaryColumn('156', 'Total Reports'),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryColumn(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith( // Larger value
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          width: 100, // Slightly increased width for label
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith( // Slightly larger label
                  color: Colors.grey[600],
                ),
            softWrap: true,
          ),
        ),
      ],
    );
  }
}