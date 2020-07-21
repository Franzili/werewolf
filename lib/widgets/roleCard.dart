import 'package:flutter/material.dart';

class RoleCard extends StatelessWidget {
  final String roleTitle;

  const RoleCard(this.roleTitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8.0),
        title: Text(
          roleTitle,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600
          ),
        ),
        ),
    );
  }
}

enum Role {
  none,
  Werwolf,
  Quacksalber,
  Seher
}
