import 'package:flutter/material.dart';

class TablingWidget extends StatelessWidget {
  final Map<int, TableColumnWidth> columnWidths;
  final TableRow header;
  final List<TableRow> rows;

  TablingWidget(
      {super.key,
      required this.columnWidths,
      required this.header,
      required this.rows}) {
    assert(columnWidths.length >= header.children.length);
    for (var row in rows) {
      assert(row.children.length == header.children.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Table(
          border: TableBorder.all(),
          columnWidths: columnWidths,
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: <TableRow>[
            header,
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Table(
              border: TableBorder.all(),
              columnWidths: columnWidths,
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: rows,
            ),
          ),
        ),
      ],
    );
  }
}
