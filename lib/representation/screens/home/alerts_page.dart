import 'package:flutter/material.dart';

class AlertsPage extends StatefulWidget {
  @override
  AlertsState createState() => AlertsState();
}

class AlertsState extends State<AlertsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Filter Section
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: SizedBox(),
                        hint: Text('Categorie'),
                        onChanged: (value) {}, items: [],
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: SizedBox(),
                        hint: Text('Gravité'),
                        items: [], // Add your gravity items here
                        onChanged: (value) {},
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              // Alerts List
              Expanded(
                child: ListView(
                  children: [
                    _buildAlertCard(
                      title: 'Accident sur la Route Nationale 5',
                      description:
                          'Un accident entre deux véhicules a été signalé près de la sortie "Boulevard Central".\nCirculation ralentie sur 3 km.',
                      gravity: 'Critical',
                      color: Color(0xFFFFE5E5),
                      textColor: Color(0xFFD92D20),
                    ),
                    SizedBox(height: 8),
                    _buildAlertCard(
                      title: 'Travaux en cours - Autoroute Est-Ouest',
                      description:
                          'Des travaux de réparation sont en cours au niveau du tronçon "PK 120".\nUne seule voie reste ouverte.',
                      gravity: 'High',
                      color: Color(0xFFFFF8E5),
                      textColor: Color(0xFFB88217),
                    ),
                    SizedBox(height: 8),
                    _buildAlertCard(
                      title: 'Embouteillage prolongé - Centre-ville',
                      description:
                          'Un embouteillage de plus de 4 km est en cours sur la Route 12 suite à un accident.\nTemps d\'attente estimé à 45 minutes.',
                      gravity: 'Low',
                      color: Color.fromARGB(255, 219, 219, 219),
                      textColor: Color(0xFF17B824),
                    ),
                    SizedBox(height: 8),
                    _buildAlertCard(
                      title: 'Violation de feu rouge - Rue Zighout Yousef',
                      description:
                          'Un véhicule a franchi le feu rouge à l\'intersection avec la rue des Frères Benkhelifa.\nAttention aux risques d\'accident.',
                      gravity: 'Very high',
                      color: Color(0xFFE5F0FF),
                      textColor: Color(0xFF1757B8),
                    ),
                    SizedBox(height: 8),
                    _buildAlertCard(
                      title: 'Accident sur la Route Nationale 45',
                      description:
                          'Un accident entre deux véhicules a été signalé près de la sortie "Place des martyrs".\nCirculation ralentie.',
                      gravity: 'Medium',
                      color: Color(0xFFFFE5E5),
                      textColor: Color(0xFFD92D20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlertCard({
    required String title,
    required String description,
    required String gravity,
    required Color color,
    required Color textColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.error_outline, color: textColor, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              color: textColor,
              fontSize: 13,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Gravité : $gravity',
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
