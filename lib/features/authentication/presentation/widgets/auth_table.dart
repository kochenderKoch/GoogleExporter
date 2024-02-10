import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class AuthenticationTable extends StatelessWidget {
  const AuthenticationTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 600,
          columns: [
            DataColumn2(
              label: Text('Username'),
              size: ColumnSize.L,
            ),
            DataColumn(
              label: Text('Passwort'),
            ),
            DataColumn(
              label: Text('Token'),
            ),
          ],
          rows: List<DataRow>.generate(
              100,
              (index) => DataRow(cells: [
                    DataCell(
                      Text(
                        'A' * (10 - index % 10),
                      ),
                    ),
                    DataCell(
                      Text(
                        'B' * (10 - (index + 5) % 10),
                      ),
                    ),
                    DataCell(
                      Text(
                        'C' * (15 - (index + 5) % 10),
                      ),
                    ),
                  ]))),
    );
  }
}
