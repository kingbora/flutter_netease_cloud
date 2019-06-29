import 'package:flutter/material.dart';
import 'package:flutter_netease_cloud/config/constants.dart';

class CustomListItem {
  final leading;
  final String title;
  final String subtitle;
  final Widget trail;
  final BorderSide borderSide;
  final EdgeInsets padding;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  final VoidCallback onClick;
  final Color color;
  final double iconWidth;
  final double leadingWidth;
  const CustomListItem({
    this.leading,
    @required this.title,
    this.subtitle,
    this.trail,
    this.onClick,
    this.iconWidth = 18,
    this.leadingWidth = 50,
    this.borderSide = const BorderSide(
      color: Color(0xFFe6e6e6),
      width: 0.5,
    ),
    this.padding = const EdgeInsets.only(
      top: 10,
      bottom: 10,
    ),
    this.titleStyle = const TextStyle(
      color: Color(0xFF333333),
      fontSize: 16,
    ),
    this.subtitleStyle = const TextStyle(
      color: Color(0xFF999999),
      fontSize: 13,
    ),
    this.color = Colors.white,
  });

  Widget buildListItem(List lists, index) {
    List<Widget> _widgets = [];
    if (leading == null) {
      _widgets.add(SizedBox(
        width: Constants.safeEdge.left,
      ));
    } else {
      if (leading is String) {
        _widgets.add(Container(
          width: leadingWidth,
          alignment: Alignment.center,
          child: Image.asset(
            leading,
            width: iconWidth,
            color: Color(0xFF333333),
          ),
        ));
      } else if (leading is Widget) {
        _widgets.add(leading);
      } else {
        _widgets.add(SizedBox(
          width: Constants.safeEdge.left,
        ));
      }
    }

    List<Widget> _centerWidgets = [];
    if (title != null) {
      _centerWidgets.add(Text(
        title,
        style: titleStyle,
      ));
    }

    List<Widget> _rightWidgets = [];
    if (subtitle != null) {
      _rightWidgets.add(Text(
        subtitle,
        style: subtitleStyle,
      ));
    }
    if (trail != null) {
      _rightWidgets.add(trail);
    } else {
      _rightWidgets.add(Image.asset(
        "assets/images/arrow_right.png",
        width: 18,
        color: Color(0xFFe1e1e1),
      ));
    }

    _rightWidgets.add(SizedBox(
      width: 10,
    ));

    _centerWidgets.add(Row(
      children: _rightWidgets,
    ));

    _widgets.add(Expanded(
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          border: Border(
            bottom: (lists[index] is CustomListItem &&
                    (index + 1) < lists.length &&
                    lists[index + 1] is CustomListItem)
                ? borderSide
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _centerWidgets,
        ),
      ),
    ));

    if (onClick != null) {
      return InkWell(
        onTap: onClick,
        child: Container(
          color: color,
          child: Row(
            children: _widgets,
          ),
        ),
      );
    } else {
      return Container(
        color: color,
        child: Row(
          children: _widgets,
        ),
      );
    }
  }
}

class CustomList extends StatelessWidget {
  final List children;
  final EdgeInsets margin;
  const CustomList({
    @required this.children,
    this.margin = EdgeInsets.zero,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Column(
        children: children.map((item) {
          if (item is CustomListItem) {
            return item.buildListItem(children, children.indexOf(item));
          } else if (item is Widget) {
            return item;
          } else {
            return Container();
          }
        }).toList(),
      ),
    );
  }
}
