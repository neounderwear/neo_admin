import 'package:flutter/material.dart';

class AdminHeader extends StatefulWidget implements PreferredSizeWidget {
  const AdminHeader({super.key});

  @override
  State<AdminHeader> createState() => _AdminHeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _AdminHeaderState extends State<AdminHeader> {
  late final TextEditingController searchController;
  late final FocusNode searchFocusNode;

  @override
  void initState() {
    searchController = TextEditingController();
    searchFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
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
          const Text(
            'Admin Neo',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            width: 700,
            child: TextField(
              controller: searchController,
              focusNode: searchFocusNode,
              autofocus: false,
              decoration: const InputDecoration(
                hintText: 'Cari apa...',
                border: InputBorder.none,
              ),
              style: const TextStyle(color: Colors.black),
            ),
          ),
          const CircleAvatar(),
        ],
      ),
    );
  }
}
