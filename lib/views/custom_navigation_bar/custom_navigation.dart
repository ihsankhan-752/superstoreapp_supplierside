import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:superstore_supplier_side/services/notification_services.dart';
import 'package:superstore_supplier_side/views/custom_navigation_bar/chat/customer_list.dart';
import 'package:superstore_supplier_side/views/custom_navigation_bar/dashboard/dashboard.dart';
import 'package:superstore_supplier_side/views/custom_navigation_bar/home/home_screen.dart';
import 'package:superstore_supplier_side/views/custom_navigation_bar/supplier_stores/suppliers_stores.dart';
import 'package:superstore_supplier_side/views/custom_navigation_bar/upload/upload_screen.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  @override
  void initState() {
    NotificationServices().getToken();
    super.initState();
  }

  int _currentIndex = 0;
  List Pages = [
    HomeScreen(),
    SupplierStores(),
    Dashboard(),
    UploadScreen(),
    CustomerList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Pages[_currentIndex],
      bottomNavigationBar: Card(
        elevation: 5,
        child: Container(
          height: 50,
          decoration: BoxDecoration(color: Colors.blueGrey.shade200.withOpacity(0.3), boxShadow: []),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomWidgetSelection(
                title: _currentIndex == 0 ? "Home" : "",
                icon: FontAwesomeIcons.house,
                iconColor: _currentIndex == 0 ? Colors.red : Colors.grey,
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              CustomWidgetSelection(
                title: _currentIndex == 1 ? "Stores" : "",
                iconColor: _currentIndex == 1 ? Colors.red : Colors.grey,
                icon: FontAwesomeIcons.store,
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              CustomWidgetSelection(
                title: _currentIndex == 2 ? "Dashboard" : "",
                icon: Icons.dashboard,
                iconColor: _currentIndex == 2 ? Colors.red : Colors.grey,
                onPressed: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),
              CustomWidgetSelection(
                title: _currentIndex == 3 ? "Upload" : "",
                iconColor: _currentIndex == 3 ? Colors.red : Colors.grey,
                icon: Icons.drive_folder_upload,
                onPressed: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
              ),
              CustomWidgetSelection(
                title: _currentIndex == 4 ? "Chat" : "",
                iconColor: _currentIndex == 4 ? Colors.red : Colors.grey,
                icon: Icons.chat,
                onPressed: () {
                  setState(() {
                    _currentIndex = 4;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomWidgetSelection extends StatelessWidget {
  final Function()? onPressed;
  final IconData? icon;
  final String? title;
  final Color? iconColor;
  const CustomWidgetSelection({Key? key, this.onPressed, this.icon, this.title, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 20),
          SizedBox(width: 04),
          Text(
            title!,
            style: TextStyle(
              color: Colors.red,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
