import 'package:flutter/material.dart';

class ServiceTile extends StatefulWidget {
  ServiceTile(
      {super.key,
      required this.name,
      required this.val,
      this.settingsScreen,
      this.logo});

  final String name;
  final Image? logo;
  final double val;
  final StatefulWidget? settingsScreen;
  @override
  State<ServiceTile> createState() => _ServiceTileState();
}

class _ServiceTileState extends State<ServiceTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: (widget.logo) ?? Text(widget.name),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Account: X"),
          Text(" - Status: Y"),
          Expanded(
            child: Container(),
          ),
          Text("Progress: ${(widget.val * 100).toStringAsFixed(2)}%"),
        ],
      ),
      subtitle: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          LinearProgressIndicator(
            minHeight: 7.5,
            value: widget.val,
            backgroundColor: Colors.grey,
            color: (widget.val < 1) ? Colors.blue : Colors.green,
          ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 1,
            child: IconButton(
                iconSize: 15.0,
                icon: const Icon(Icons.settings),
                onPressed: () {}),
          ),
          Flexible(
            flex: 1,
            child: IconButton(
                iconSize: 15.0,
                icon: const Icon(Icons.play_arrow),
                onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
