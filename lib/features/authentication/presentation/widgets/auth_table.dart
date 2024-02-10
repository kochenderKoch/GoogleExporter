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
            DataColumn(
              label: Text('Actions'),
            )
          ],
          rows: List<DataRow>.generate(
              3,
              (index) => DataRow(cells: [
                    DataCell(
                      Text(
                        'user@name.com',
                      ),
                    ),
                    DataCell(
                      Text(
                        'Password123!',
                      ),
                    ),
                    DataCell(
                      Text(
                        'ya.290b8b9-9b9b-9b9b-9b9b-9b9b9b9b9b9b',
                      ),
                    ),
                    DataCell(Row(children: [
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            Text("Edit"),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Row(
                          children: [
                            Icon(Icons.delete),
                            Text("Delete"),
                          ],
                        ),
                      ),
                    ]))
                  ]))),
    );
  }
}
