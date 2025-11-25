import 'package:flutter/material.dart';

/// A data class for configuring a tab item in the [ConvexAppBar].
class TabItem {
  final IconData icon;
  final String? title;

  const TabItem({required this.icon, this.title});
}

/// A simplified, opinionated bottom navigation bar that implements a "fixed" style layout.
///
/// All items are distributed equally and always visible. This widget is self-contained
/// and built to be easy to use with sensible defaults.
class ConvexAppBar extends StatefulWidget {
  final List<TabItem> items;
  final int initialActiveIndex;
  final ValueChanged<int>? onTap;
  final Color? backgroundColor;
  final Color? activeColor;
  final Color? color;
  final double height;

  const ConvexAppBar({
    Key? key,
    required this.items,
    this.initialActiveIndex = 0,
    this.onTap,
    this.backgroundColor,
    this.activeColor,
    this.color,
    this.height = 56.0, // Sensible default height
  })  : assert(items.length >= 2, 'At least 2 items are required'),
        super(key: key);

  @override
  _ConvexAppBarState createState() => _ConvexAppBarState();
}

class _ConvexAppBarState extends State<ConvexAppBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialActiveIndex;
  }

  @override
  void didUpdateWidget(covariant ConvexAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialActiveIndex != _currentIndex) {
      setState(() {
        _currentIndex = widget.initialActiveIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = widget.activeColor ?? theme.colorScheme.primary;
    final color = widget.color ?? theme.unselectedWidgetColor;

    return Container(
      height: widget.height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? theme.bottomAppBarTheme.color,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widget.items.map((item) {
          final index = widget.items.indexOf(item);
          final bool isActive = index == _currentIndex;

          return Expanded(
            child: InkWell(
              onTap: () {
                if (_currentIndex != index) {
                  setState(() {
                    _currentIndex = index;
                  });
                  widget.onTap?.call(index);
                }
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(item.icon, color: iconColor),
        if (item.title != null) ...[
          const SizedBox(height: 2),
          Text(
            item.title!,
            style: TextStyle(
              color: iconColor,
              fontSize: 12,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ]
      ],
    );
  }
}
