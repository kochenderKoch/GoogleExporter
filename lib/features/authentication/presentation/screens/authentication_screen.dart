import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_exporter/features/authentication/presentation/widgets/auth_table.dart';
import 'package:google_exporter/features/authentication/presentation/widgets/project_card.dart';

class AuthenticationOverviewScreen extends ConsumerWidget {
  const AuthenticationOverviewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: ProjectCard(),
          ),
          Expanded(
            child: AuthenticationTable(),
          ),
        ],
      ),
      floatingActionButton: SpeedDial(
        // animatedIcon: AnimatedIcons.menu_close,
        // animatedIconTheme: IconThemeData(size: 22.0),
        // / This is ignored if animatedIcon is non null
        // child: Text("open"),
        // activeChild: Text("close"),
        icon: Icons.add,
        activeIcon: Icons.close,
        spacing: 3,
        mini: true,

        childPadding: const EdgeInsets.all(5),
        spaceBetweenChildren: 4,
        // dialRoot:
        //      (ctx, open, toggleChildren) {
        //         return ElevatedButton(
        //           onPressed: toggleChildren,
        //           style: ElevatedButton.styleFrom(
        //             backgroundColor: Colors.blue[900],
        //             padding: const EdgeInsets.symmetric(
        //                 horizontal: 22, vertical: 18),
        //           ),
        //           child: const Text(
        //             "Custom Dial Root",
        //             style: TextStyle(fontSize: 17),
        //           ),
        //         );
        //       }
        //     ,

        iconTheme: IconThemeData(size: 22),
        label: const Text("Add"), // The label of the main button.
        /// The active label of the main button, Defaults to label if not specified.
        activeLabel: const Text("Close"),

        /// Transition Builder between label and activeLabel, defaults to FadeTransition.
        // labelTransitionBuilder: (widget, animation) => ScaleTransition(scale: animation,child: widget),
        /// The below button size defaults to 56 itself, its the SpeedDial childrens size

        onOpen: () => debugPrint('OPENING DIAL'),
        onClose: () => debugPrint('DIAL CLOSED'),
        heroTag: 'speed-dial-hero-tag',
        // foregroundColor: Colors.black,
        // backgroundColor: Colors.white,
        // activeForegroundColor: Colors.red,
        // activeBackgroundColor: Colors.blue,
        elevation: 8.0,
        animationCurve: Curves.elasticInOut,
        isOpenOnStart: false,

        // childMargin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.person),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            label: 'Add Account Information',
            onTap: () {},
          ),
          SpeedDialChild(
            child: const Icon(Icons.generating_tokens),
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            label: 'Add Master Token',
            onTap: () {},
          ),
          SpeedDialChild(
            child: const Icon(Icons.storage),
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            label: 'Add Android Database',
            visible: true,
            onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(("Third Child Pressed")))),
          ),
        ],
      ),
    );
  }
}
