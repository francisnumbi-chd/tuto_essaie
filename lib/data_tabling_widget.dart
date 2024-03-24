import 'package:flutter/material.dart';

class DataTablingWidget extends StatelessWidget {
  const DataTablingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text('Name'),
          ),
          DataColumn(
            label: Text('Age'),
          ),
          DataColumn(
            label: Text('Role'),
          ),
        ],
        rows: [
          ...List.generate(20, (index) {
            return DataRow(
              cells: <DataCell>[
                DataCell(Text('Name $index')),
                DataCell(Text('Age $index'), showEditIcon: true),
                DataCell(Text('Role $index')),
              ],
            );
          }),
        ],
      ),
    );
  }
}
