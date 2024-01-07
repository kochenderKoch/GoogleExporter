import 'package:flutter/material.dart';

class ProjectOverviewScreen extends StatelessWidget {
  const ProjectOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // Logik zum Erstellen eines neuen Projekts
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.onBackground,
              backgroundColor:
                  Theme.of(context).primaryColor, // Textfarbe des Buttons
            ),
            child: const Text('Neues Projekt erstellen'),
          ),
          const SizedBox(height: 16), // Leerraum zwischen den Buttons
          OutlinedButton(
            onPressed: () {
              // Logik zum Laden eines bestehenden Projekts
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Theme.of(context).primaryColor,
              side: BorderSide(
                color: Theme.of(context).primaryColor,
              ), // Randfarbe des Buttons
            ),
            child: const Text('Bestehendes Projekt laden'),
          ),
        ],
      ),
    );
  }
}
