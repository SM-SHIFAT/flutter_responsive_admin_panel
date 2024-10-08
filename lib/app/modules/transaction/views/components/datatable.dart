import 'package:flutter/material.dart';

class TransactionDataTable extends StatefulWidget {
  @override
  _TransactionDataTableState createState() => _TransactionDataTableState();
}

class _TransactionDataTableState extends State<TransactionDataTable> {
  List<Transaction> transactions = [];
  bool sortAscending = true;
  int? sortColumnIndex;
  final Set<int> selectedRows = {};

  @override
  void initState() {
    super.initState();
    _populateTransactions();
  }

  // Populate example transactions
  void _populateTransactions() {
    transactions = List.generate(
      100, // Generates 100 dummy transactions
      (index) => Transaction(
        id: index + 1,
        date: DateTime.now().subtract(Duration(days: index)),
        amount: (index + 1) * 100.0,
        description: 'Transaction $index',
      ),
    );
  }

  // Empty delete function
  void _deleteSelected() {
    // Placeholder for delete functionality
    print("Deleted rows: ${selectedRows.toList()}");
  }

  // Sorting function
  void _sort<T>(Comparable<T> Function(Transaction t) getField, int columnIndex,
      bool ascending) {
    setState(() {
      sortColumnIndex = columnIndex;
      sortAscending = ascending;
      transactions.sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return ascending
            ? Comparable.compare(aValue, bValue)
            : Comparable.compare(bValue, aValue);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: constraints.maxWidth),
            child: PaginatedDataTable(
              header: Text("Transactions"),
              rowsPerPage: 10, // Number of rows per page
              sortColumnIndex: sortColumnIndex,
              sortAscending: sortAscending,
              columns: [
                DataColumn(
                  label: Text("ID"),
                  numeric: true,
                  onSort: (columnIndex, ascending) =>
                      _sort<num>((t) => t.id, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text("Date"),
                  onSort: (columnIndex, ascending) =>
                      _sort<DateTime>((t) => t.date, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text("Amount"),
                  numeric: true,
                  onSort: (columnIndex, ascending) =>
                      _sort<num>((t) => t.amount, columnIndex, ascending),
                ),
                DataColumn(
                  label: Text("Description"),
                  onSort: (columnIndex, ascending) => _sort<String>(
                      (t) => t.description, columnIndex, ascending),
                ),
              ],
              source:
                  TransactionDataSource(transactions, selectedRows, setState),
            ),
          ),
        );
      },
    );
  }
}

class Transaction {
  final int id;
  final DateTime date;
  final double amount;
  final String description;

  Transaction({
    required this.id,
    required this.date,
    required this.amount,
    required this.description,
  });
}

class TransactionDataSource extends DataTableSource {
  final List<Transaction> transactions;
  final Set<int> selectedRows;
  final Function setState;

  TransactionDataSource(this.transactions, this.selectedRows, this.setState);

  @override
  DataRow getRow(int index) {
    final transaction = transactions[index];
    return DataRow(
      selected: selectedRows.contains(index),
      onSelectChanged: (isSelected) {
        setState(() {
          if (isSelected!) {
            selectedRows.add(index);
          } else {
            selectedRows.remove(index);
          }
        });
      },
      cells: [
        DataCell(Text(transaction.id.toString())),
        DataCell(Text(transaction.date.toString())),
        DataCell(Text(transaction.amount.toStringAsFixed(2))),
        DataCell(Text(transaction.description)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => transactions.length;

  @override
  int get selectedRowCount => selectedRows.length;
}
