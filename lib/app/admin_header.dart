import 'package:flutter/material.dart';

// Header atau AppBar utama aplikasi
class AdminHeader extends StatefulWidget implements PreferredSizeWidget {
  const AdminHeader({super.key});

  @override
  State<AdminHeader> createState() => _AdminHeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _AdminHeaderState extends State<AdminHeader> {
  late final TextEditingController _searchController;
  late final FocusNode _searchFocusNode;

  @override
  void initState() {
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1.0, 1.0),
            blurRadius: 1.0,
            spreadRadius: 2.0,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Admin Gudang Pakaian Dalam',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          CircleAvatar(
            child: Image.asset('assets/images/cv.png', fit: BoxFit.cover),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }
}
