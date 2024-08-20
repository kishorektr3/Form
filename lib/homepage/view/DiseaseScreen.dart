// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class DiseaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40),
              Center(
                child: Text(
                  "Disease",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 30),
              DiseaseCard(
                title: "Typhoid Fever Surveillance",
                description: "Typhoid",
                color: Colors.blueAccent.shade100,
                onTap: () {
                  Navigator.pushNamed(context, '/Typhoid');
                },
              ),
              SizedBox(height: 20),
              DiseaseCard(
                title: "iVDPV Surveillance in Persons \nwith Primary Immunodeficiency",
                description: "Surveillance",
                color: Colors.blueAccent.shade100,
                onTap: () {
                  Navigator.pushNamed(context, '/Ivdv');
                },
              ),
              SizedBox(height: 30),
              DiseaseCard(
                title: "Suspected Measles/Rubella",
                description: "Rubella",
                color: Colors.blueAccent.shade100,
                onTap: () {
                  Navigator.pushNamed(context, '/Rubella');
                },
              ),
              SizedBox(height: 30),
              DiseaseCard(
                title: "Acute Flaccid Paralysis",
                description: "Paralysis",
                color: Colors.blueAccent.shade100,
                onTap: () {
                  Navigator.pushNamed(context, '/Paralysis');
                },
              ),
              SizedBox(height: 30),
              DiseaseCard(
                title: "Vaccine Preventable Diseases",
                description: "Vaccine",
                color: Colors.blueAccent.shade100,
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
  final Color color;
  final VoidCallback onTap;

  DiseaseCard({
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}