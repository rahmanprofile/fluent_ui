import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserTable extends StatelessWidget {
  final List<User> users;
  final BuildContext parentContext; // This context will be passed down to the UserDataSource

  const UserTable({super.key, required this.users, required this.parentContext});

  @override
  Widget build(BuildContext context) {
    // Pass the context to the UserDataSource constructor
    final UserDataSource userDataSource = UserDataSource(users, parentContext);

    return Expanded(
      child: SfDataGrid(
        source: userDataSource,
        columnWidthMode: ColumnWidthMode.fill,
        columns: <GridColumn>[
          GridColumn(
            width: 80,
            columnName: 'profile',
            label: const Center(child: Text('Profile', style: TextStyle(fontWeight: FontWeight.bold))),
            allowSorting: true,
          ),
          GridColumn(
            columnName: 'name',
            label: const Center(child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold))),
            allowSorting: true,
          ),
          GridColumn(
            columnName: 'email',
            label: const Center(child: Text('Email', style: TextStyle(fontWeight: FontWeight.bold))),
            allowSorting: true,
          ),
          GridColumn(
            columnName: 'phone',
            label: const Center(child: Text('Phone', style: TextStyle(fontWeight: FontWeight.bold))),
            allowSorting: true,
          ),
          GridColumn(
            width: 80,
            columnName: 'status',
            label: const Center(child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold))),
            allowSorting: true,
          ),
          GridColumn(
            width: 80,
            columnName: 'actions',
            label: const Center(child: Text('Actions', style: TextStyle(fontWeight: FontWeight.bold))),
          ),
        ],
        gridLinesVisibility: GridLinesVisibility.both,
        headerGridLinesVisibility: GridLinesVisibility.both,
      ),
    );
  }
}

class UserDataSource extends DataGridSource {
  List<DataGridRow> _dataGridRows = [];
  List<User> _users = [];
  final BuildContext context; // Store the context here

  UserDataSource(List<User> users, this.context) {
    _users = users;
    _dataGridRows = users.map<DataGridRow>((user) {
      return DataGridRow(
        cells: [
          DataGridCell<String>(columnName: 'profile', value: user.profileUrl),
          DataGridCell<String>(columnName: 'name', value: user.name),
          DataGridCell<String>(columnName: 'email', value: user.email),
          DataGridCell<String>(columnName: 'phone', value: user.phone),
          DataGridCell<String>(columnName: 'status', value: user.status),
          const DataGridCell<Icon>(columnName: 'actions', value: Icon(Icons.more_vert)),
        ],
      );
    }).toList();
  }

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {

        int rowIndex = _dataGridRows.indexOf(row);

        switch (cell.columnName) {

          case 'profile':
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  User user = _users[rowIndex];

                  // Navigate to the UserDetailsPage with the selected user
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailsPage(user: user),
                    ),
                  );
                },
                child: CircleAvatar(
                  backgroundImage: NetworkImage(cell.value.toString()),
                ),
              ),
            );
          case 'name':
          case 'email':
          case 'phone':
          case 'status':
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(cell.value.toString()),
            );
          case 'actions':
            return IconButton(
              icon: cell.value as Icon,
              onPressed: () {},
            );
          default:
            return const SizedBox.shrink();
        }
      }).toList(),
    );
  }
}

class UserDetailsPage extends StatelessWidget {
  final User user;

  const UserDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name} Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User Details',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SfDataGrid(
              columnWidthMode: ColumnWidthMode.fill,
              columns: <GridColumn>[
                GridColumn(
                  columnName: 'key',
                  label: const Center(child: Text('Key', style: TextStyle(fontWeight: FontWeight.bold))),
                ),
                GridColumn(
                  columnName: 'value',
                  label: const Center(child: Text('Value', style: TextStyle(fontWeight: FontWeight.bold))),
                ),
              ],
              source: UserDetailDataSource(user),
            ),
          ],
        ),
      ),
    );
  }
}

class UserDetailDataSource extends DataGridSource {
  final User user;

  UserDetailDataSource(this.user);

  @override
  List<DataGridRow> get rows => [
    DataGridRow(cells: [
      DataGridCell<String>(columnName: 'key', value: 'Name'),
      DataGridCell<String>(columnName: 'value', value: user.name),
    ]),
    DataGridRow(cells: [
      DataGridCell<String>(columnName: 'key', value: 'Email'),
      DataGridCell<String>(columnName: 'value', value: user.email),
    ]),
    DataGridRow(cells: [
      DataGridCell<String>(columnName: 'key', value: 'Phone'),
      DataGridCell<String>(columnName: 'value', value: user.phone),
    ]),
    DataGridRow(cells: [
      DataGridCell<String>(columnName: 'key', value: 'Status'),
      DataGridCell<String>(columnName: 'value', value: user.status),
    ]),
  ];

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(cell.value.toString()),
        );
      }).toList(),
    );
  }
}

class User {
  final String profileUrl;
  final String name;
  final String email;
  final String phone;
  final String status;

  User({
    required this.profileUrl,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
  });
}
