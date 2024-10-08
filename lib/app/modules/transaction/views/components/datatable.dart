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
    return Row(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: PaginatedDataTable(
                  header: Text("Transactions"),
                  rowsPerPage: 10,
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
                      onSort: (columnIndex, ascending) => _sort<DateTime>(
                          (t) => t.date, columnIndex, ascending),
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
                  source: TransactionDataSource(
                      transactions, selectedRows, setState),
                ),
              );
            },
          ),
        ),
      ],
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

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class DataTableDemo extends StatefulWidget {
//   const DataTableDemo({super.key});

//   @override
//   State<DataTableDemo> createState() => _DataTableDemoState();
// }

// class _RestorableDessertSelections extends RestorableProperty<Set<int>> {
//   // The set of indices of selected dessert rows
//   Set<int> _dessertSelections = {};

//   /// Returns whether or not a dessert row is selected by index.
//   bool isSelected(int index) => _dessertSelections.contains(index);

//   /// Takes a list of [_Dessert]s and saves the row indices of selected rows
//   /// into a [Set].
//   void setDessertSelections(List<_Dessert> desserts) {
//     final updatedSet = <int>{};
//     for (var i = 0; i < desserts.length; i += 1) {
//       var dessert = desserts[i];
//       if (dessert.selected) {
//         updatedSet.add(i);
//       }
//     }
//     _dessertSelections = updatedSet;
//     notifyListeners();
//   }

//   @override
//   Set<int> createDefaultValue() => _dessertSelections;

//   @override
//   Set<int> fromPrimitives(Object? data) {
//     final selectedItemIndices = data as List<dynamic>;
//     _dessertSelections = {
//       ...selectedItemIndices.map<int>((dynamic id) => id as int),
//     };
//     return _dessertSelections;
//   }

//   @override
//   void initWithValue(Set<int> value) {
//     _dessertSelections = value;
//   }

//   @override
//   Object toPrimitives() => _dessertSelections.toList();
// }

// class _DataTableDemoState extends State<DataTableDemo> with RestorationMixin {
//   // Create restoration properties
//   final _RestorableDessertSelections _dessertSelections =
//       _RestorableDessertSelections();
//   final RestorableInt _rowIndex = RestorableInt(0);
//   final RestorableInt _rowsPerPage =
//       RestorableInt(PaginatedDataTable.defaultRowsPerPage);
//   final RestorableBool _sortAscending = RestorableBool(true);
//   final RestorableIntN _sortColumnIndex = RestorableIntN(null);

//   // Declare a _DessertDataSource instance and initialize it to null
//   _DessertDataSource? _dessertsDataSource;

//   // Set restoration ID
//   @override
//   String get restorationId => 'data_table_demo';

//   // Register restorable properties for restoration
//   @override
//   void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
//     registerForRestoration(_dessertSelections, 'selected_row_indices');
//     registerForRestoration(_rowIndex, 'current_row_index');
//     registerForRestoration(_rowsPerPage, 'rows_per_page');
//     registerForRestoration(_sortAscending, 'sort_ascending');
//     registerForRestoration(_sortColumnIndex, 'sort_column_index');

//     // Initialize _dessertsDataSource if it is null
//     _dessertsDataSource ??= _DessertDataSource(context);

//     // Sort the data source according to the sort column index
//     switch (_sortColumnIndex.value) {
//       case 0:
//         _dessertsDataSource!._sort<String>((d) => d.name, _sortAscending.value);
//         break;
//       case 1:
//         _dessertsDataSource!
//             ._sort<num>((d) => d.calories, _sortAscending.value);
//         break;
//       case 2:
//         _dessertsDataSource!._sort<num>((d) => d.fat, _sortAscending.value);
//         break;
//       case 3:
//         _dessertsDataSource!._sort<num>((d) => d.carbs, _sortAscending.value);
//         break;
//       case 4:
//         _dessertsDataSource!._sort<num>((d) => d.protein, _sortAscending.value);
//         break;
//       case 5:
//         _dessertsDataSource!._sort<num>((d) => d.sodium, _sortAscending.value);
//         break;
//       case 6:
//         _dessertsDataSource!._sort<num>((d) => d.calcium, _sortAscending.value);
//         break;
//       case 7:
//         _dessertsDataSource!._sort<num>((d) => d.iron, _sortAscending.value);
//         break;
//     }

//     // Update the selection of desserts
//     _dessertsDataSource!.updateSelectedDesserts(_dessertSelections);

//     // Add listener to _dessertsDataSource to update selected dessert row
//     _dessertsDataSource!.addListener(_updateSelectedDessertRowListener);
//   }

//   // Add listener to _dessertsDataSource when the widget is attached to the tree
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();

//     // Initialize _dessertsDataSource if it is null
//     _dessertsDataSource ??= _DessertDataSource(context);

//     // Add listener to _dessertsDataSource to update selected dessert row
//     _dessertsDataSource!.addListener(_updateSelectedDessertRowListener);
//   }

//   // Update the selected dessert row
//   void _updateSelectedDessertRowListener() {
//     _dessertSelections.setDessertSelections(_dessertsDataSource!._desserts);
//   }

//   // Sort the data source
//   void _sort<T>(
//     Comparable<T> Function(_Dessert d) getField,
//     int columnIndex,
//     bool ascending,
//   ) {
//     _dessertsDataSource!._sort<T>(getField, ascending);
//     setState(() {
//       _sortColumnIndex.value = columnIndex;
//       _sortAscending.value = ascending;
//     });
//   }

//   @override
//   void dispose() {
//     // Dispose of the _rowsPerPage stream subscription
//     _rowsPerPage.dispose();

//     // Dispose of the _sortColumnIndex stream subscription
//     _sortColumnIndex.dispose();

//     // Dispose of the _sortAscending stream subscription
//     _sortAscending.dispose();

//     // Remove the listener that updates the selected dessert row
//     // from the _dessertsDataSource
//     _dessertsDataSource!.removeListener(_updateSelectedDessertRowListener);

//     // Dispose of the _dessertsDataSource stream subscription
//     _dessertsDataSource!.dispose();

//     // Call the superclass's dispose method
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scrollbar(
//       // Add a scrollbar to the body of the scaffold
//       child: ListView(
//         restorationId: 'data_table_list_view',
//         padding: const EdgeInsets.all(16),
//         children: [
//           PaginatedDataTable(
//             header: Text('Nutrition'), // Set the header text of the data table
//             rowsPerPage: _rowsPerPage.value,
//             onRowsPerPageChanged: (value) {
//               setState(() {
//                 _rowsPerPage.value = value!;
//               });
//             },
//             initialFirstRowIndex: _rowIndex.value,
//             onPageChanged: (rowIndex) {
//               setState(() {
//                 _rowIndex.value = rowIndex;
//               });
//             },
//             sortColumnIndex: _sortColumnIndex.value,
//             sortAscending: _sortAscending.value,
//             onSelectAll: _dessertsDataSource!
//                 ._selectAll, // Set the select all callback of the data table
//             columns: [
//               DataColumn(
//                 label: Text(
//                     'Dessert 1 Serving'), // Set the label of the first column
//                 onSort: (columnIndex, ascending) => _sort<String>(
//                     (d) => d.name,
//                     columnIndex,
//                     ascending), // Set the sorting function of the first column
//               ),
//               DataColumn(
//                 label: Text('Calories'), // Set the label of the second column
//                 numeric: true,
//                 onSort: (columnIndex, ascending) => _sort<num>(
//                     (d) => d.calories,
//                     columnIndex,
//                     ascending), // Set the sorting function of the second column
//               ),
//               DataColumn(
//                 label: Text('Fat (g)'), // Set the label of the third column
//                 numeric: true,
//                 onSort: (columnIndex, ascending) => _sort<num>(
//                     (d) => d.fat,
//                     columnIndex,
//                     ascending), // Set the sorting function of the third column
//               ),
//               DataColumn(
//                 label: Text('Carbs (g)'), // Set the label of the fourth column
//                 numeric: true,
//                 onSort: (columnIndex, ascending) => _sort<num>(
//                     (d) => d.carbs,
//                     columnIndex,
//                     ascending), // Set the sorting function of the fourth column
//               ),
//               DataColumn(
//                 label: Text('Protein (g)'), // Set the label of the fifth column
//                 numeric: true,
//                 onSort: (columnIndex, ascending) => _sort<num>(
//                     (d) => d.protein,
//                     columnIndex,
//                     ascending), // Set the sorting function of the fifth column
//               ),
//               DataColumn(
//                 label: Text('Sodium (mg)'), // Set the label of the sixth column
//                 numeric: true,
//                 onSort: (columnIndex, ascending) => _sort<num>(
//                     (d) => d.sodium,
//                     columnIndex,
//                     ascending), // Set the sorting function of the sixth column
//               ),
//               DataColumn(
//                 label: Text('Calcium %'), // Set the label of the seventh column
//                 numeric: true,
//                 onSort: (columnIndex, ascending) => _sort<num>(
//                     (d) => d.calcium,
//                     columnIndex,
//                     ascending), // Set the sorting function of the seventh column
//               ),
//               DataColumn(
//                 label: Text('Iron %'), // Set the label of the eighth column
//                 numeric: true,
//                 onSort: (columnIndex, ascending) => _sort<num>(
//                     (d) => d.iron,
//                     columnIndex,
//                     ascending), // Set the sorting function of the eighth column
//               ),
//             ],
//             source: _dessertsDataSource!,
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _Dessert {
//   _Dessert(
//     this.name, // The name of the dessert
//     this.calories, // The number of calories in the dessert
//     this.fat, // The amount of fat in the dessert (in grams)
//     this.carbs, // The number of carbohydrates in the dessert (in grams)
//     this.protein, // The amount of protein in the dessert (in grams)
//     this.sodium, // The amount of sodium in the dessert (in milligrams)
//     this.calcium, // The amount of calcium in the dessert (in milligrams)
//     this.iron, // The amount of iron in the dessert (in milligrams)
//   );

//   final String name; // The name of the dessert (immutable)
//   final int calories; // The number of calories in the dessert (immutable)
//   final double fat; // The amount of fat in the dessert (in grams) (immutable)
//   final int
//       carbs; // The number of carbohydrates in the dessert (in grams) (immutable)
//   final double
//       protein; // The amount of protein in the dessert (in grams) (immutable)
//   final int
//       sodium; // The amount of sodium in the dessert (in milligrams) (immutable)
//   final int
//       calcium; // The amount of calcium in the dessert (in milligrams) (immutable)
//   final int
//       iron; // The amount of iron in the dessert (in milligrams) (immutable)
//   bool selected =
//       false; // Whether the dessert is currently selected (default is false)
// }

// class _DessertDataSource extends DataTableSource {
  // Constructor for _DessertDataSource class, takes a BuildContext argument
//   _DessertDataSource(this.context) {
//     // Initialize the list of desserts
//     _desserts = <_Dessert>[
//       _Dessert(
//         'Frozen Yogurt',
//         159,
//         6.0,
//         24,
//         4.0,
//         87,
//         14,
//         1,
//       ),
//       _Dessert(
//         'IceCream Sandwich',
//         237,
//         9.0,
//         37,
//         4.3,
//         129,
//         8,
//         1,
//       ),
//       _Dessert(
//         'Eclair',
//         262,
//         16.0,
//         24,
//         6.0,
//         337,
//         6,
//         7,
//       ),
//       _Dessert(
//         'Cupcake',
//         305,
//         3.7,
//         67,
//         4.3,
//         413,
//         3,
//         8,
//       ),
//       _Dessert(
//         'Gingerbread',
//         356,
//         16.0,
//         49,
//         3.9,
//         327,
//         7,
//         16,
//       ),
//       _Dessert(
//         'JellyBean',
//         375,
//         0.0,
//         94,
//         0.0,
//         50,
//         0,
//         0,
//       ),
//       _Dessert(
//         'Lollipop',
//         392,
//         0.2,
//         98,
//         0.0,
//         38,
//         0,
//         2,
//       ),
//       _Dessert(
//         'Honeycomb',
//         408,
//         3.2,
//         87,
//         6.5,
//         562,
//         0,
//         45,
//       ),
//       _Dessert(
//         'Donut',
//         452,
//         25.0,
//         51,
//         4.9,
//         326,
//         2,
//         22,
//       ),
//       _Dessert(
//         'Apple Pie',
//         518,
//         26.0,
//         65,
//         7.0,
//         54,
//         12,
//         6,
//       ),
//     ];
//   }

//   // The BuildContext passed to the constructor
//   final BuildContext context;

//   // List of desserts
//   late List<_Dessert> _desserts;

//   // Sort the desserts by a given field
//   void _sort<T>(Comparable<T> Function(_Dessert d) getField, bool ascending) {
//     _desserts.sort((a, b) {
//       final aValue = getField(a);
//       final bValue = getField(b);
//       return ascending
//           ? Comparable.compare(aValue, bValue)
//           : Comparable.compare(bValue, aValue);
//     });
//     notifyListeners();
//   }

//   // Number of selected desserts
//   int _selectedCount = 0;

//   // Update the selected desserts
//   void updateSelectedDesserts(_RestorableDessertSelections selectedRows) {
//     _selectedCount = 0;
//     for (var i = 0; i < _desserts.length; i += 1) {
//       var dessert = _desserts[i];
//       if (selectedRows.isSelected(i)) {
//         dessert.selected = true;
//         _selectedCount += 1;
//       } else {
//         dessert.selected = false;
//       }
//     }
//     notifyListeners();
//   }

//   // Get a DataRow for a given index
//   @override
//   DataRow? getRow(int index) {
//     // Number formatter for percentages
//     final format = NumberFormat.decimalPercentPattern(
//       decimalDigits: 0,
//     );
//     // Make sure index is valid
//     assert(index >= 0);
//     if (index >= _desserts.length) return null;
//     final dessert = _desserts[index];
//     // Create the DataRow with cells for each dessert property
//     return DataRow.byIndex(
//       index: index,
//       selected: dessert.selected,
//       onSelectChanged: (value) {
//         // Update the selected count and dessert selection
//         if (dessert.selected != value) {
//           _selectedCount += value! ? 1 : -1;
//           assert(_selectedCount >= 0);
//           dessert.selected = value;
//           notifyListeners();
//         }
//       },
//       cells: [
//         DataCell(Text(dessert.name)),
//         DataCell(Text('${dessert.calories}')),
//         DataCell(Text(dessert.fat.toStringAsFixed(1))),
//         DataCell(Text('${dessert.carbs}')),
//         DataCell(Text(dessert.protein.toStringAsFixed(1))),
//         DataCell(Text('${dessert.sodium}')),
//         DataCell(Text(format.format(dessert.calcium / 100))),
//         DataCell(Text(format.format(dessert.iron / 100))),
//       ],
//     );
//   }

//   // Number of rows in the DataTable
//   @override
//   int get rowCount => _desserts.length;

//   // Whether or not the rowCount is approximate
//   @override
//   bool get isRowCountApproximate => false;

//   // Number of selected rows
//   @override
//   int get selectedRowCount => _selectedCount;

//   // Select or deselect all rows
//   void _selectAll(bool? checked) {
//     for (final dessert in _desserts) {
//       dessert.selected = checked ?? false;
//     }
//     _selectedCount = checked! ? _desserts.length : 0;
//     notifyListeners();
//   }
// }
