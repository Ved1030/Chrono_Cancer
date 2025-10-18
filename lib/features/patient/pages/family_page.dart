import 'package:flutter/material.dart';

class CommunityInsightsApp extends StatefulWidget {
  const CommunityInsightsApp({Key? key}) : super(key: key);

  @override
  _CommunityInsightsAppState createState() => _CommunityInsightsAppState();
}

class _CommunityInsightsAppState extends State<CommunityInsightsApp> {
  List<FamilyMember> familyMembers = [
    FamilyMember(
      initials: 'JS',
      name: 'John Smith',
      role: 'Spouse',
      status: 'Healthy',
      lastReport: '2/15/2024',
      statusColor: Colors.green,
      initialsColor: Colors.deepPurpleAccent,
    ),
    FamilyMember(
      initials: 'ES',
      name: 'Emma Smith',
      role: 'Daughter',
      status: 'Needs Attention',
      lastReport: '2/10/2024',
      statusColor: Colors.orange,
      initialsColor: Colors.blueAccent,
    ),
    FamilyMember(
      initials: 'RS',
      name: 'Robert Smith',
      role: 'Father',
      status: 'Healthy',
      lastReport: '2/8/2024',
      statusColor: Colors.green,
      initialsColor: Colors.redAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 1,
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.deepPurple),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.deepPurple),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.home_outlined),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Family Cancer Intelligence',
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
              const SizedBox(height: 4),
              Text(
                'Track hereditary patterns & community risk factors',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: const AssetImage('assets/images/transparent_default_user.png'),
                backgroundColor: Colors.deepPurple.shade200,
                child: const Icon(Icons.person, color: Colors.white),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Family Cancer History', 'Track genetic lineage and health status of family members.'),
                const SizedBox(height: 16),
                _buildFamilyCancerTreeCard(),
                const SizedBox(height: 32),
                _buildSectionTitle('Hereditary Risk Assessment', 'Understand your personalized cancer risk based on family patterns.'),
                const SizedBox(height: 16),
                _buildHereditaryRiskCard(),
                const SizedBox(height: 32),
                _buildSectionTitle('Environmental Insights', 'Identify cancer risk factors in your local environment.'),
                const SizedBox(height: 16),
                _buildEnvironmentalCancerHotspots(),
                const SizedBox(height: 32),
                _buildSectionTitle('Prevention Impact', 'See the positive outcomes of proactive health management.'),
                const SizedBox(height: 16),
                _buildPreventionImpactCard(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
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
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  // -------------------- Section 1 --------------------
  Widget _buildFamilyCancerTreeCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.account_tree, color: Colors.deepPurple, size: 24),
                    const SizedBox(width: 10),
                    Text(
                      'Family Cancer History',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${familyMembers.length} tracked',
                    style: TextStyle(color: Colors.deepPurple[700], fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ..._buildFamilyMemberList(),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _showAddFamilyMemberDialog,
              icon: const Icon(Icons.add),
              label: const Text('Add Family Member'),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.orange[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning_amber, color: Colors.orange[700], size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '2 family members with breast cancer history detected - genetic screening recommended',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.orange[800],
                            fontWeight: FontWeight.w500,
                          ),
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

  List<Widget> _buildFamilyMemberList() {
    List<Widget> widgets = [];
    for (int i = 0; i < familyMembers.length; i++) {
      widgets.add(_buildFamilyMemberTile(member: familyMembers[i]));
      if (i != familyMembers.length - 1) {
        widgets.add(const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Divider(height: 1, thickness: 1.0, color: Colors.grey),
        ));
      }
    }
    return widgets;
  }

  Widget _buildFamilyMemberTile({required FamilyMember member}) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: member.initialsColor,
          child: Text(
            member.initials,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                member.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                member.role,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: member.statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                member.status,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: member.statusColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Last scan: ${member.lastReport}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[500],
                  ),
            ),
          ],
        ),
      ],
    );
  }

  // -------------------- Section 2 --------------------
  Widget _buildHereditaryRiskCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.biotech, color: Colors.red, size: 24),
                const SizedBox(width: 10),
                Text(
                  'Your Hereditary Cancer Risk',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildRiskRow('Breast Cancer', 'High', 0.65, Colors.red, '2 maternal cases'),
            const SizedBox(height: 16),
            _buildRiskRow('Colon Cancer', 'Medium', 0.35, Colors.orange, '1 paternal case'),
            const SizedBox(height: 16),
            _buildRiskRow('Lung Cancer', 'Low', 0.15, Colors.green, 'No family history'),
            const SizedBox(height: 16),
            _buildRiskRow('Prostate Cancer', 'Medium', 0.40, Colors.orange, '1 case detected'),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[50]!, Colors.blue[100]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.insights, color: Colors.blue[700], size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'AI recommends BRCA1/BRCA2 genetic test based on family pattern',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.blue[900],
                            fontWeight: FontWeight.w500,
                          ),
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

  Widget _buildRiskRow(String cancer, String level, double value, Color color, String reason) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(cancer, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(level, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: value,
          valueColor: AlwaysStoppedAnimation<Color>(color),
          backgroundColor: color.withOpacity(0.2),
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
        const SizedBox(height: 6),
        Text(reason, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600])),
      ],
    );
  }

  // -------------------- Section 3 --------------------
  Widget _buildEnvironmentalCancerHotspots() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.map, color: Colors.deepOrange, size: 24),
                const SizedBox(width: 10),
                Text(
                  'Environmental Cancer Hotspots',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Areas with elevated cancer incidence near you',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: NetworkImage('https://i.ibb.co/3kX93G1/OIG-2.png'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildHotspotRow('Industrial Zone East', 'Lung cancer: 2.3x avg', Colors.red, '342 cases/yr', '8 hospitals'),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(height: 1, thickness: 1.0, color: Colors.grey),
            ),
            _buildHotspotRow('Downtown Metro', 'Breast cancer: 1.8x avg', Colors.orange, '156 cases/yr', '5 hospitals'),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(height: 1, thickness: 1.0, color: Colors.grey),
            ),
            _buildHotspotRow('Suburban West', 'Colon cancer: 1.4x avg', Colors.orange, '89 cases/yr', '3 hospitals'),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.warning, color: Colors.red[700], size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'You live 3km from Industrial Zone East - consider quarterly lung screenings',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.red[900],
                            fontWeight: FontWeight.w500,
                          ),
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

  Widget _buildHotspotRow(String area, String stats, Color color, String cases, String hospitals) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(area, style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              Text(stats, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(Icons.people_outline, size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 6),
                  Text(cases, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600])),
                  const SizedBox(width: 16),
                  Icon(Icons.local_hospital, size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 6),
                  Text(hospitals, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600])),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // -------------------- Section 4 --------------------
  Widget _buildPreventionImpactCard() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[400]!, Colors.green[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.shield_outlined, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 16),
                Text(
                  'Community Impact',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildImpactStat('1,847', 'Early\nDetections', Icons.search),
                _buildImpactStat('92%', 'Survival\nRate', Icons.favorite),
                _buildImpactStat('6mo', 'Avg Time\nSaved', Icons.schedule),
              ],
            ),
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Impact This Year',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      Text('3 family members screened', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      Text('1 polyp detected,removed early', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      Text('Prevented Stage 3 diagnosis', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImpactStat(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 36),
        const SizedBox(height: 10),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  void _showAddFamilyMemberDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController roleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Family Member'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: roleController,
              decoration: const InputDecoration(labelText: 'Relation (e.g., Mother, Sister)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final name = nameController.text.trim();
              final role = roleController.text.trim();

              if (name.isNotEmpty && role.isNotEmpty) {
                final initials = name.split(' ').map((e) => e[0]).take(2).join();
                setState(() {
                  familyMembers.add(FamilyMember(
                    initials: initials,
                    name: name,
                    role: role,
                    status: 'Pending Screening',
                    lastReport: 'N/A',
                    statusColor: Colors.grey,
                    initialsColor: Colors.purple,
                  ));
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class FamilyMember {
  final String initials;
  final String name;
  final String role;
  final String status;
  final String lastReport;
  final Color statusColor;
  final Color initialsColor;

  FamilyMember({
    required this.initials,
    required this.name,
    required this.role,
    required this.status,
    required this.lastReport,
    required this.statusColor,
    required this.initialsColor,
  });
}
