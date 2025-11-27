import 'package:flutter/material.dart';

/// A data class for configuring a tab item in the [ConvexAppBar].
class TabItem {
  final IconData icon;
  final String? title;
  final double? iconSize; // Allow overriding the default icon size.

  const TabItem({required this.icon, this.title, this.iconSize});
}

/// A simplified, opinionated bottom navigation bar that implements a "fixed" style layout.
class ConvexAppBar extends StatelessWidget {
  final List<TabItem> items;
  final int activeIndex;
  final ValueChanged<int>? onTap;
  final Color? backgroundColor;
  final Color? activeColor;
  final Color? color;
  final double height;
  final double iconSize; // Default icon size for all tabs.
  final TextStyle? titleStyle; // Default text style for all titles.
  final List<BoxShadow>? shadow; // Allow custom shadow.

  const ConvexAppBar({
    Key? key,
    required this.items,
    required this.activeIndex,
    this.onTap,
    this.backgroundColor,
    this.activeColor,
    this.color,
    this.height = 56.0,
    this.iconSize = 24.0, // Add a default value.
    this.titleStyle,
    this.shadow,
  })  : assert(items.length >= 2, 'At least 2 items are required'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = this.activeColor ?? theme.colorScheme.primary;
    final color = this.color ?? theme.unselectedWidgetColor;

    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.bottomAppBarTheme.color,
        // Use the provided shadow or a default one.
        boxShadow: shadow ??
            const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
              ),
            ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          final index = items.indexOf(item);
          final bool isActive = index == activeIndex;

          return Expanded(
            child: InkWell(
              onTap: () {
                onTap?.call(index);
              },
              child: _buildItem(item, isActive, activeColor, color),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildItem(TabItem item, bool isActive, Color activeColor, Color color) {
    final iconColor = isActive ? activeColor : color;

    // Create a base style and merge it with active/inactive properties.
    final finalTitleStyle = (titleStyle ?? const TextStyle(fontSize: 12)).copyWith(
      color: iconColor,
      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          item.icon,
          // Use the item's specific iconSize or fall back to the default.
          size: item.iconSize ?? iconSize,
          color: iconColor,
        ),
        if (item.title != null) ...[
          const SizedBox(height: 2),
          Text(
            item.title!,
            style: finalTitleStyle, // Apply the final computed style.
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ]
      ],
    );
  }
}
