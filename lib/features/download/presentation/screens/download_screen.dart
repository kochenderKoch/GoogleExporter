import 'package:flutter/material.dart';
import 'package:google_exporter/features/download/presentation/widgets/service_tile.dart';

class DownloadOverviewScreen extends StatelessWidget {
  const DownloadOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                  "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet."),
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              ServiceTile(
                name: "Gmail",
                val: 0.5,
              ),
              ServiceTile(
                name: "Drive",
                val: 0.8,
              ),
              ServiceTile(
                name: "Kontakte",
                val: 0.1,
              ),
            ],
          )),
        ],
      ),
    );
  }
}
