import 'package:brandface/uikit/tokens/colors.dart';
import 'package:flutter/material.dart';

import '../../../../uikit/typography/typography.dart';

class SelectRole extends StatefulWidget {
  final Function(String role)? onRoleSelected;

  const SelectRole({super.key, this.onRoleSelected});

  @override
  State<SelectRole> createState() => _SelectRoleState();
}

class _SelectRoleState extends State<SelectRole> {
  String? _selectedRole;
  final List<String> _roles = ['Influencer', 'Ambassador', 'Brandface', 'Brand'];

  @override
  void initState() {
    _selectedRole = _roles[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // Keraksiz joy egallamasligi uchun
      children: [
        Row(children: [_buildItem(0), const SizedBox(width: 8), _buildItem(1)]),
        const SizedBox(height: 16),
        Row(children: [_buildItem(2), const SizedBox(width: 8), _buildItem(3)]),
      ],
    );
  }

  Widget _buildItem(int index) {
    final role = _roles[index];
    return _RoleItem(
      title: role,
      isSelected: _selectedRole == role,
      onTap: () {
        setState(() => _selectedRole = role);
        widget.onRoleSelected?.call(role);
      },
    );
  }
}

class _RoleItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleItem({required this.title, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.black : AppColors.lightBg2,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Center(
            child: Text(
              title,
              style: Typographies.labelMedium.copyWith(color: isSelected ? AppColors.lightBg : AppColors.black),
            ),
          ),
        ),
      ),
    );
  }
}
