import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CancerAwarenessPage extends StatefulWidget {
  const CancerAwarenessPage({Key? key}) : super(key: key);

  @override
  State<CancerAwarenessPage> createState() => _CancerAwarenessPageState();
}

class CancerType {
  final String name;
  final IconData icon;
  final String description;
  final double risk;
  final Color color;

  CancerType({
    required this.name,
    required this.icon,
    required this.description,
    required this.risk,
    required this.color,
  });
}

final List<CancerType> dummyCancerTypes = [
  CancerType(
    name: 'Brain Cancer',
    icon: FontAwesomeIcons.brain,
    description:
        'Abnormal cells form in the brain, causing headaches, seizures, and vision changes.',
    risk: 0.15,
    color: Colors.redAccent,
  ),
  CancerType(
    name: 'Liver Cancer',
    icon: FontAwesomeIcons.droplet,
    description:
        'Begins in the liver; risk factors include hepatitis, alcohol use, and genetics.',
    risk: 0.08,
    color: Colors.orangeAccent,
  ),
  CancerType(
    name: 'Lung Cancer',
    icon: FontAwesomeIcons.lungs,
    description: 'Starts in the lungs; smoking is the leading cause.',
    risk: 0.25,
    color: Colors.deepOrange,
  ),
  CancerType(
    name: 'Breast Cancer',
    icon: FontAwesomeIcons.ribbon,
    description:
        'Forms in breast cells; early detection is crucial for recovery.',
    risk: 0.12,
    color: Colors.pinkAccent,
  ),
  CancerType(
    name: 'Prostate Cancer',
    icon: FontAwesomeIcons.mars,
    description: 'Common in men; often grows slowly at first.',
    risk: 0.07,
    color: Colors.lightBlueAccent,
  ),
  CancerType(
    name: 'Leukemia',
    icon: FontAwesomeIcons.droplet,
    description:
        'Cancer of blood-forming tissues; causes fatigue and frequent infections.',
    risk: 0.07,
    color: Colors.deepPurpleAccent,
  ),
];

class _CancerAwarenessPageState extends State<CancerAwarenessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Types of Cancer We Treat',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.purpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 0.85,
            ),
            itemCount: dummyCancerTypes.length,
            itemBuilder: (context, index) {
              final cancer = dummyCancerTypes[index];
              return _buildCancerCard(context, cancer);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCancerCard(BuildContext context, CancerType cancer) {
    return GestureDetector(
      onTap: () => _showCancerInfo(context, cancer),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: 40.0,
                lineWidth: 6.0,
                percent: (cancer.risk).clamp(0.0, 1.0),
                progressColor: cancer.color,
                backgroundColor: Colors.black.withOpacity(0.1),
                circularStrokeCap: CircularStrokeCap.round,
                center: FaIcon(
                  cancer.icon,
                  size: 36,
                  color: cancer.color,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                cancer.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black),
              ),
              const SizedBox(height: 4),
              Text(
                '${(cancer.risk * 100).toInt()}% Risk',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCancerInfo(BuildContext context, CancerType cancer) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(cancer.name, textAlign: TextAlign.center),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(cancer.icon, size: 50, color: cancer.color),
            const SizedBox(height: 12),
            Text(
              cancer.description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            Text(
              'Risk: ${(cancer.risk * 100).toInt()}%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: cancer.color,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
