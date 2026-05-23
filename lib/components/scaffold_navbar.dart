
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lockin_native_2/core/app_size.dart';
import 'package:lockin_native_2/core/app_spacing.dart';
import 'package:lockin_native_2/core/theme.dart';

class ScaffoldNavbar extends StatelessWidget{
  final StatefulNavigationShell navigationShell;

  const ScaffoldNavbar({
    super.key,
    required this.navigationShell
  });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: navigationShell,

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.paper,
        ),

        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.l, vertical: AppSpacing.m),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavbarItem(
                  iconData: Icons.cyclone_rounded,
                  label: "Lock In",
                  isSelected: navigationShell.currentIndex == 0,
                  onTap: () => navigationShell.goBranch(0),
                ),
                _NavbarItem(
                  iconData: Icons.calendar_today_rounded,
                  label: "Schedule",
                  isSelected: navigationShell.currentIndex == 1,
                  onTap: ()=> navigationShell.goBranch(1),
                ),
                _NavbarItem(
                  iconData: Icons.query_stats_rounded,
                  label: "Stats",
                  isSelected: navigationShell.currentIndex == 2,
                  onTap: ()=> navigationShell.goBranch(2),
                ),
                _NavbarItem(
                  iconData: Icons.person_rounded,
                  label: "Profile",
                  isSelected: navigationShell.currentIndex == 3,
                  onTap: ()=> navigationShell.goBranch(3),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}

class _NavbarItem extends StatelessWidget{
  final IconData iconData;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavbarItem({
    required this.iconData,
    required this.label,
    required this.isSelected,
    required this.onTap
  });

  @override
  Widget build(BuildContext context){
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            iconData,
            color: isSelected ? AppTheme.emerald : AppTheme.softGray,
            size: AppSpacing.l,
          ),
          SizedBox(height: AppSpacing.s),
          Text(
            label,
            style: AppTheme.textTheme.bodySmall?.copyWith(
              color: isSelected ? AppTheme.emerald : AppTheme.softGray,
              fontWeight: isSelected? FontWeight.w800 :  FontWeight.w500,
              fontSize: AppSize.s
            ),
          )
        ],
      )
    );
  }
}