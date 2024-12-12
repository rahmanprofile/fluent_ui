import 'package:fluent/dummy_users.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Hide the debug banner
      home: DashboardScreen(), // Home or DashboardScreen
    );
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  bool _isLoad = false;

  final List<String> _menuItems = [
    'Overview',
    'Compute',
    'Storage',
    'Networking',
    'Security',
    'Billing',
  ];

  final Map<String, String> _data = {
    'Overview': 'Some general statistics about the system',
    'Compute': 'Details of compute resources like EC2 instances',
    'Storage': 'Information on storage, S3 buckets, EBS volumes',
    'Networking': 'Details of networking services like VPCs and ELB',
    'Security': 'Security-related configurations, IAM, Security Groups',
    'Billing': 'Account billing details and charges',
  };

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CupertinoColors.activeBlue,
        elevation: 0,
        toolbarHeight: 40,
        titleSpacing: 0,
        centerTitle: false,
        leading: IconButton(
            onPressed: () {
              setState(() {
                _isLoad = !_isLoad;
              });
            },
            icon: const Icon(CupertinoIcons.chevron_down_square, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            icon: const Icon(CupertinoIcons.person_solid, color: Colors.white, size: 18),
          ),
          IconButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.exit_to_app, color: Colors.white, size: 18),
          ),
        ],
        title: Container(
          height: 30,
          width: width / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.white,
          ),
          child: TextFormField(
            scrollPadding: EdgeInsets.zero,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              hintText: "Search here",
              hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              prefixIcon: Icon(CupertinoIcons.search, color: CupertinoColors.activeBlue, size: 18),
            ),
          ),
        ),
      ),
      body: Row(
        children: [
          if (_isLoad)
            Container(
              width: width * 0.25,
              color: Colors.grey.shade200,
              child: Column(
                children: _menuItems.map((item) {
                  int index = _menuItems.indexOf(item);
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index; // Update selected item
                      });
                    },
                    child: Container(
                      color: _selectedIndex == index ? CupertinoColors.activeBlue : Colors.transparent,
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.folder,
                            color: _selectedIndex == index ? Colors.white : Colors.grey[600],
                          ),
                          const SizedBox(width: 8), // Space between icon and label
                          Text(
                            item,
                            style: TextStyle(
                              color: _selectedIndex == index ? Colors.white : Colors.grey[600],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _menuItems[_selectedIndex],
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(_data[_menuItems[_selectedIndex]]!,
                    style: const TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 40),
                  UserTable(users: users, parentContext: context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
final List<User> users = [
  User(
    profileUrl: 'https://via.placeholder.com/50',
    name: 'Alice Johnson',
    email: 'alice@example.com',
    phone: '123-456-7890',
    status: 'Active',
  ),
  User(
    profileUrl: 'https://via.placeholder.com/50',
    name: 'Bob Smith',
    email: 'bob@example.com',
    phone: '987-654-3210',
    status: 'Inactive',
  ),
  User(
    profileUrl: 'https://via.placeholder.com/50',
    name: 'Charlie Brown',
    email: 'charlie@example.com',
    phone: '555-555-5555',
    status: 'Active',
  ),
  User(
    profileUrl: 'https://via.placeholder.com/50',
    name: 'David Williams',
    email: 'david@example.com',
    phone: '234-567-8901',
    status: 'Inactive',
  ),
  User(
    profileUrl: 'https://via.placeholder.com/50',
    name: 'Eva Davis',
    email: 'eva@example.com',
    phone: '876-543-2109',
    status: 'Active',
  ),
  User(
    profileUrl: 'https://via.placeholder.com/50',
    name: 'Frank Miller',
    email: 'frank@example.com',
    phone: '345-678-9012',
    status: 'Inactive',
  ),
  User(
    profileUrl: 'https://via.placeholder.com/50',
    name: 'Grace Wilson',
    email: 'grace@example.com',
    phone: '654-321-0987',
    status: 'Active',
  ),
  User(
    profileUrl: 'https://via.placeholder.com/50',
    name: 'Henry Moore',
    email: 'henry@example.com',
    phone: '543-210-9876',
    status: 'Active',
  ),
  User(
    profileUrl: 'https://via.placeholder.com/50',
    name: 'Isla Taylor',
    email: 'isla@example.com',
    phone: '765-432-1098',
    status: 'Inactive',
  ),
  User(
    profileUrl: 'https://via.placeholder.com/50',
    name: 'Jack Lee',
    email: 'jack@example.com',
    phone: '654-321-8765',
    status: 'Active',
  ),
];
