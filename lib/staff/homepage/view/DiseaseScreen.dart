import 'package:flutter/material.dart';

class DiseaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 247, 246, 246),
      appBar: AppBar(
        title: Text('Disease Surveillance'),
        backgroundColor: Color(0xFF6C63FF).withOpacity(0.8),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                "Select Disease",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F3D56),
                ),
              ),
              SizedBox(height: 20),
              DiseaseCard(
                title: "Typhoid Fever Surveillance",
                description:
                    "Typhoid fever is a bacterial infection that can spread throughout the body, affecting many organs.",
                imagePath: "assets/image/ww.jpg",
                onTap: () {
                  Navigator.pushNamed(context, '/Typhoid');
                },
              ),
              SizedBox(height: 20),
              DiseaseCard(
                title: "IVDPV Surveillance",
                description:
                    "IVDPV Surveillance in Persons with Primary Immunodeficiency.",
                imagePath: "assets/image/ivdv.jpg",
                onTap: () {
                  Navigator.pushNamed(context, '/Ivdv');
                },
              ),
              SizedBox(height: 20),
              DiseaseCard(
                title: "Suspected Measles/Rubella",
                description:
                    "Rubella is a viral infection that may cause adenopathy, rash, and sometimes constitutional symptoms.",
                imagePath: "assets/image/rub.jpg",
                onTap: () {
                  Navigator.pushNamed(context, '/Rubella');
                },
              ),
              SizedBox(height: 20),
              DiseaseCard(
                title: "Acute Flaccid Paralysis",
                description: "Paralysis.",
                imagePath: "assets/image/ac.jpg",
                onTap: () {
                  Navigator.pushNamed(context, '/Paralysis');
                },
              ),
              SizedBox(height: 20),
              DiseaseCard(
                title: "Vaccine Preventable Diseases",
                description: "Vaccine preventable diseases surveillance.",
                imagePath: "assets/image/oo.jpg",
                onTap: () {
                  Navigator.pushNamed(context, '/Vaccine');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DiseaseCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final VoidCallback onTap;

  DiseaseCard({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border:
              Border.all(color: Color.fromARGB(255, 255, 254, 254), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              spreadRadius: 1,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imagePath,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black54.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Color(0xFF6C63FF).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
